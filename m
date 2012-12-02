From: Ming Lei <tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [RFC PATCH 0/5] USB: prepare for support port power off on non-ACPI device
Date: Sun,  2 Dec 2012 23:01:02 +0800
Message-ID: <1354460467-28006-1-git-send-email-tom.leiming@gmail.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Sarah Sharp <sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

This patch set trys to prepare for support of usb port power
off mechanism on non-ACPI devices. The port power off mechasnism
has been discussed for some time[1][2], and support for ACPI
devices has been in shape:

	- usb port device is introduced
	- port connect type is introduced and set via ACPI
	- usb root port power can be switched on/off via ACPI

The above has been merged to upstream, and Tianyu is pushing
patches[3] to enable auto port power feature.

So it is time to discuss how to support it for non-ACPI usb
devices, and there are many embedded system in which some of
usb devices are hardwired(often self-powered) into board, such as,
beagle board, pandaboard, Arndaleboard, etc. So powering on/off
these devices may involve platform dependent way, just like
ACPI power control is used in Tianyu's patch. 

This patch set introduces power controller to hide the power
switch implementation detail to usb subsytem, in theroy it can
be used to other devices and subsystem, and the power controller
instance is stored as device's resource. So the power controller
can be used to power on/off the power supply from the usb port,
and makes support of port power off possible on non-ACPI devices.

Associating power controller with one device(such as usb port)
which providing power logically is not an easy thing, because
platform dependent knowledge(port topology, hardware power domain
on the port, ...) has to be applied and the usb port device isn't
a platform device and it is created during hub probe(). So looks
there is no general approach to do it. This patchset introduces
one global device ADD/DEL notifier in driver core, so when a new
device is added, one match function in platform code is called to
check if the device can be associated with the power controller.
This patchset implements the match function on OMAP4 based Pandaboard,
and defines the power controller to control power for lan95xx hub
and ethernet device.

Another idea of associating power controller with port device
is by introducing usb port driver, and move all this port power
control stuff from platform code to port driver, which is just
what I think of and looks doable. I'd like to get some feedback
about which one is better, then I can do it in next cycle.

Also the two things on Pandaboard have been done at the same time:

	- powering on the two devices can be delayed to the ehci-omap
	root hub probing.

	- the regulatores which are used for these two hardwired and
	self-powered devices are moved out from ehci-omap driver

In fact, Andy Green has been working[4][5] on the above two things,
but which isn't the main purpose of these patches, and they might be
seen as byproduct of the patchset. Inevitably, there are some overlap
between Andy's work and this patchset, hope we can compare, discuss
and figure out the perfect solution.

 arch/arm/mach-omap2/board-omap4panda.c |   99 +++++++++++++++++++++++++++-
 drivers/base/core.c                    |   21 ++++++
 drivers/base/power/Makefile            |    1 +
 drivers/base/power/power_controller.c  |  110 ++++++++++++++++++++++++++++++++
 drivers/usb/core/hub.c                 |   31 ++++++++-
 drivers/usb/host/ehci-omap.c           |   36 -----------
 include/linux/device.h                 |   13 ++++
 include/linux/power_controller.h       |   48 ++++++++++++++
 include/linux/usb/port.h               |   16 +++++
 kernel/power/Kconfig                   |    6 ++
 10 files changed, 339 insertions(+), 42 deletions(-)

Thanks,
--
Ming Lei


[1], http://marc.info/?t=134818354900003&r=1&w=2
[2], http://marc.info/?t=134303384500003&r=1&w=2
[3], http://marc.info/?l=linux-usb&m=135314427413307&w=2
[4], http://marc.info/?t=135393394700003&r=1&w=2
[5], http://www.spinics.net/lists/linux-omap/msg83191.html


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
