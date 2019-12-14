From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: BUG - was: [GIT PULL 2/3] bcm2835-soc-next-2019-10-15
Date: Sat, 14 Dec 2019 12:59:47 +0000
Message-ID: <20191214125947.GD1337@shell.armlinux.org.uk>
References: <1571159725-5090-1-git-send-email-wahrenst@gmx.net>
 <1571159725-5090-2-git-send-email-wahrenst@gmx.net>
 <12244E4E-A1A0-4EE9-ACD3-EA165D9A2C79@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <12244E4E-A1A0-4EE9-ACD3-EA165D9A2C79@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Stefan Wahren <wahrenst@gmx.net>, Florian Fainelli <f.fainelli@gmail.com>, Tony Lindgren <tony@atomide.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, Linux-OMAP <linux-omap@vger.kernel.org>, arm-soc <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Sat, Dec 14, 2019 at 11:54:19AM +0100, H. Nikolaus Schaller wrote:
> Hi Stefan,
> 
> > Am 15.10.2019 um 19:15 schrieb Stefan Wahren <wahrenst@gmx.net>:
> > 
> > Hi Florian,
> > 
> > The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:
> > 
> >  Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)
> > 
> > are available in the git repository at:
> > 
> >  git://github.com/anholt/linux tags/bcm2835-soc-next-2019-10-15
> > 
> > for you to fetch changes up to 781fa0a954240c8487683ddf837fb2c4ede8e7ca:
> > 
> >  ARM: bcm: Add support for BCM2711 SoC (2019-10-10 19:21:03 +0200)
> 
> this patch has finally arrived in v5.5-rc1 but it seems to break
> multiplatform build.
> 
> We run a distribution kernel that supports OMAP3/4/5, i.MX6 and RasPi 3B+
> but since rebasing to v5.5-rc1 the kernel hangs after "Starting Kernel ...".
> On all ARM devices (incl. RasPi 3B+).
> 
> Playing with our defconfig did show that deconfiguring CONFIG_ARCH_BCM2835
> makes the kernel work again.
> 
> After further analysis it turns out that reverting this patch also
> makes the boards work again.
> 
> I am not exactly sure what the reason is, but it may have something to
> do with the new auto-selection of CONFIG_ZONE_DMA which is not automatically
> selected by OMAP and i.MX6.
> 
> To reproduce on some OMAP device (i.MX6 should be similar)
> 
> 1st test:
> 
> git checkout v5.5-rc1
> make omap2plus_defconfig
> 
> => boots OMAP device
> 
> 2nd test:
> 
> ( echo CONFIG_ARCH_BCM2835=y; echo CONFIG_ARCH_BCM=y ) >>arch/arm/configs/omap2plus_defconfig
> make omap2plus_defconfig
> 
> => fails to boot OMAP device
> 
> 3rd test:
> 
> git revert 781fa0a954240c8487683ddf837fb2c4ede8e7ca
> make omap2plus_defconfig
> 
> => boots OMAP device
> 
> BTW: the RasPi 3B+ runs equally well without this patch. So what is it
> good for?
> 
> So please check and fix this patch.

Enabling ZONE_DMA shouldn't cause this problem - but as it does, please
enable memblock debugging and early console, and please send any boot
messages you can get from the system when it fails to boot.  Also
having a successful boot log may be useful.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
