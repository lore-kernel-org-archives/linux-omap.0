From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: omap2plus_defconfig: add networking over USB device
Date: Tue, 4 Dec 2018 13:52:29 -0800
Message-ID: <20181204215229.GE6707@atomide.com>
References: <20181204205901.14620-1-michael.opdenacker@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181204205901.14620-1-michael.opdenacker@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Opdenacker <michael.opdenacker@bootlin.com>
Cc: linux@armlinux.org.uk, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

* Michael Opdenacker <michael.opdenacker@bootlin.com> [181204 12:59]:
> This adds support for networking over USB device,
> which allows boards such as the BeagleBoneBlack Wireless and
> Pocket Beagle to boot on an NFS root filesystem. Such boards
> have no Ethernet port.
> 
> This is for consistency with CONFIG_ROOT_NFS=y
> which makes no sense if there is no networking.

Hmm well this has few issues though:

1. We've had USB as loadable modules for years now to
   cut down on bloat and try to make things more
   distro friendly

2. MUSB has never worked well with PM and enabling
   it almost certainly would break PM for multiple
   devices

3. The USB gadget configuration should be done using
   configfs as it's device and policy  specific and
   Ethernet gadget may not be even desirable

So I suggest just doing what distros do and use a proper
initramfs :)

BTW what works quite nicely for devices with Ethernet
controller is to have u-boot load dtb, kernel and
modules.tar.gz over Ethernet and write it to mmc. That
way the loaded kernel and modules are available on
boot as long as some init script untars modules.tar.gz
first thing when init starts.

Regards,

Tony
