From: Sebastian Reichel <sre-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: [RFCv4 00/11] OMAP SSI driver / N900 modem support
Date: Mon, 16 Dec 2013 00:27:53 +0100
Message-ID: <1387150085-23173-1-git-send-email-sre@debian.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-GFxCN5SEZAc@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Carlos Chinea <cch.devel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, =?UTF-8?q?=27Beno=C3=AEt=20Cousson=27?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?q?=D0=98=D0=B2=D0=B0=D0=B9=D0=BB=D0=BE=20=D0=94=D0=B8=D0=BC=D0=B8=D1=82=D1=80=D0=BE=D0=B2?= <freemangordon-uiMcrn6V0Vs@public.gmane.org>, Joni Lapilainen <joni.lapilainen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>, Sebastian Reichel <sre-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

This is the fourth round of the OMAP SSI driver patches.

I added some more patches on top of the actual OMAP SSI driver, so that one can
get the overall picture of the planned architecture. This patchset contains
everything, that is needed to get the N900's modem running (without audio
support, which requires another hsi client driver).

After applying the patches one can use ofono with the N900's modem.
This is what I did to test the modem:

 # get ofono and mdbus2 to send some dbus commands
 apt-get install ofono mdbus2
 # ofono assumes, that gpios are available in /dev/cmt. Previously
 # a init script exported the gpios and symlinked them to this
 # directory. I added support for the gpio export directly into
 # nokia-cmt and I plan to write a patch for ofono to check for
 # the cmt gpios directly in /sys. For now this hack can be used
 # to test the modem.
 ln -sf /sys/devices/nokia-cmt.5 /dev/cmt
 # start ofono in debug mode
 export OFONO_ISI_DEBUG
 export OFONO_AT_DEBUG=1
 ofono --nodetach --debug
 # enable the modem
 mdbus2 -s org.ofono /n900_0 org.ofono.Modem.SetProperty Powered true
 # enable modem's RF parts
 mdbus2 -s org.ofono /n900_0 org.ofono.Modem.SetProperty Online true
 # scan for available networks
 mdbus2 -s org.ofono /n900_0 org.ofono.NetworkRegistration.Scan

Changes since RFCv3 [0]:
* Added new patches for nokia-cmt driver
* Added new patches for ssi protocol driver
* Removal of ti,hwmods description from DT Documentation
* Removed the hwmod patch, since it has already been applied
* Misc. bug fixes

TODO (short-term):
* Find a DT maintainer, who has time to review the updated DT bindings
* Push nokia-cmt driver through gregkh's linux-misc queue
* Push hsi/ssi drivers through my new linux-hsi queue [1]
* Push DTS patches through benoits queue once the other patches are queued

TODO (long-term):
* Central Message Queue
  I did not yet implement a central message queue in the HSI framework.
  I will do this after Nokia N900 modem is working in the mainline kernel.
* Get clock data from DT
  This depends on a patchset, which is not yet part of any kernel tree.
  Apart from that I don't know which clocks will be needed. That depends
  on the implementation of the hwmod DTification (see next point)
* Remove the hwmod DT hack
  This depends on some future work merging hwmod data into DT.

[0] https://lkml.org/lkml/2013/10/6/127
[1] https://git.kernel.org/cgit/linux/kernel/git/sre/linux-hsi.git/

-- Sebastian

Sebastian Reichel (11):
  HSI: method to unregister clients from an hsi port
  HSI: hsi-char: add Device Tree support
  HSI: hsi-char: fix driver for multiport scenarios
  ARM: OMAP2+: HSI: Introduce OMAP SSI driver
  Documentation: DT: omap-ssi binding documentation
  misc: Introduce Nokia CMT driver
  Documentation: DT: nokia-cmt binding documentation
  HSI: Introduce driver for SSI Protocol
  DTS: ARM: OMAP3-N900: Add SSI support
  DTS: ARM: OMAP3-N900: Add CMT support
  DTS: ARM: OMAP3-N900: Add SSI protocol support

 Documentation/devicetree/bindings/hsi/omap_ssi.txt |   69 +
 .../devicetree/bindings/misc/nokia-cmt.txt         |   28 +
 arch/arm/boot/dts/omap3-n900.dts                   |   72 +
 arch/arm/boot/dts/omap3.dtsi                       |   47 +
 drivers/hsi/Kconfig                                |    1 +
 drivers/hsi/Makefile                               |    1 +
 drivers/hsi/clients/Kconfig                        |    8 +
 drivers/hsi/clients/Makefile                       |    3 +-
 drivers/hsi/clients/hsi_char.c                     |   13 +-
 drivers/hsi/clients/ssi_protocol.c                 | 1201 +++++++++++++++++
 drivers/hsi/controllers/Kconfig                    |   19 +
 drivers/hsi/controllers/Makefile                   |    6 +
 drivers/hsi/controllers/omap_ssi.c                 |  619 +++++++++
 drivers/hsi/controllers/omap_ssi.h                 |  166 +++
 drivers/hsi/controllers/omap_ssi_port.c            | 1401 ++++++++++++++++++++
 drivers/hsi/controllers/omap_ssi_regs.h            |  171 +++
 drivers/hsi/hsi.c                                  |   10 +
 drivers/misc/Kconfig                               |    7 +
 drivers/misc/Makefile                              |    1 +
 drivers/misc/nokia-cmt.c                           |  298 +++++
 include/linux/hsi/hsi.h                            |    1 +
 include/linux/hsi/ssi_protocol.h                   |   41 +
 include/linux/nokia-cmt.h                          |   46 +
 23 files changed, 4227 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hsi/omap_ssi.txt
 create mode 100644 Documentation/devicetree/bindings/misc/nokia-cmt.txt
 create mode 100644 drivers/hsi/clients/ssi_protocol.c
 create mode 100644 drivers/hsi/controllers/Kconfig
 create mode 100644 drivers/hsi/controllers/Makefile
 create mode 100644 drivers/hsi/controllers/omap_ssi.c
 create mode 100644 drivers/hsi/controllers/omap_ssi.h
 create mode 100644 drivers/hsi/controllers/omap_ssi_port.c
 create mode 100644 drivers/hsi/controllers/omap_ssi_regs.h
 create mode 100644 drivers/misc/nokia-cmt.c
 create mode 100644 include/linux/hsi/ssi_protocol.h
 create mode 100644 include/linux/nokia-cmt.h

-- 
1.8.5.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
