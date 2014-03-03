From: Jon Ringle <jon@ringle.org>
Subject: Ethernet controller not starting
Date: Mon, 3 Mar 2014 14:41:01 -0500
Message-ID: <CAMwGMjwjyZkj3_bKUcx4GXNP764UaUG=d6V1us8GgMKj=HoXVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: rafael.j.wysocki@intel.com
List-Id: linux-omap@vger.kernel.org

I'm working on porting an ARM board from linux-3.10 to linux-3.12 (now
the latest LTS kernel).
I found that Ethernet controller on the board no longer comes up on linux-3.12.
I was able to bisect the issue I'm having to the following commit:

>   45f0a85c8258741d11bda25c0a5669c06267204a is the first bad commit
>   commit 45f0a85c8258741d11bda25c0a5669c06267204a
>   Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>   Date:   Mon Jun 3 21:49:52 2013 +0200
>
>       PM / Runtime: Rework the "runtime idle" helper routine
>
>       The "runtime idle" helper routine, rpm_idle(), currently ignores
>       return values from .runtime_idle() callbacks executed by it.
>       However, it turns out that many subsystems use
>       pm_generic_runtime_idle() which checks the return value of the
>       driver's callback and executes pm_runtime_suspend() for the device
>       unless that value is not 0.  If that logic is moved to rpm_idle()
>       instead, pm_generic_runtime_idle() can be dropped and its users
>       will not need any .runtime_idle() callbacks any more.
>
>       Moreover, the PCI, SCSI, and SATA subsystems' .runtime_idle()
>       routines, pci_pm_runtime_idle(), scsi_runtime_idle(), and
>       ata_port_runtime_idle(), respectively, as well as a few drivers'
>       ones may be simplified if rpm_idle() calls rpm_suspend() after 0 has
>       been returned by the .runtime_idle() callback executed by it.
>
>       To reduce overall code bloat, make the changes described above.
>
>       Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>       Tested-by: Kevin Hilman <khilman@linaro.org>
>       Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>       Acked-by: Kevin Hilman <khilman@linaro.org>
>       Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
>       Acked-by: Alan Stern <stern@rowland.harvard.edu>

Can anyone offer any suggestions on what I should be looking for to
fix this on my board?

Thanks,
Jon
