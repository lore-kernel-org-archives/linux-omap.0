From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Re: In system software upgrade
Date: Sun, 24 Sep 2006 10:00:14 -0500
Message-ID: <45169D7E.60308@gmail.com>
References: <BAY122-DAV978325FCA9F5416C60A15A6260@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <BAY122-DAV978325FCA9F5416C60A15A6260@phx.gbl>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Hieu Ninh <hninh@hotmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hieu Ninh stated on 9/22/2006 10:56 PM:
> Our system requires the software upgrade feature (for both application and
> kernel) during the user space application is running.  I don't know how to
> go about it in Linux environment.  
application upgrade: two ways: one: replace the entire filesystem (bad
idea)- u should be able to do it with uboot/the old setup itself, two:
replace the application and related binaries: it is easier if your
filesystem has some sort of package manager like rpm/apt-tools stuff
like that.

kernel up-grade:
a) as you mentioned, requires u-boot support.
b) from bootup shell prompt(using the old kernel), overwrite the
kernel's mtd partition with the new kernel. reboot, and you should have
the new kernel.
> 
> If I can get an image (from USB flash) and copy it to the RAM while the
> system running and some how reboot the system in U-boot (without reset the
> RAM).  From there I can run the uboot script to copy the image from RAM to
> flash.  Would this work? Is there any better way to do this?
uboot:
a) u can have usb mass-storage support in uboot. boot in u-boot, copy
from mas-storage to flash
b) u can use other paths such as serial/some other interface to install.

But dont download it to ram and expect a "system restart" to keep your
ram alive. it is not a productizable option.

Regards,
Nishanth Menon
