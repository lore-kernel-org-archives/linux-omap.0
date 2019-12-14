From: Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [Letux-kernel] BUG - was: [GIT PULL 2/3]
 bcm2835-soc-next-2019-10-15
Date: Sat, 14 Dec 2019 16:54:39 +0100
Message-ID: <20191214165439.6873625b@aktux>
References: <1571159725-5090-1-git-send-email-wahrenst@gmx.net>
        <1571159725-5090-2-git-send-email-wahrenst@gmx.net>
        <12244E4E-A1A0-4EE9-ACD3-EA165D9A2C79@goldelico.com>
        <20191214125947.GD1337@shell.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191214125947.GD1337@shell.armlinux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc: Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, "H. Nikolaus Schaller" <hns@goldelico.com>, Florian Fainelli <f.fainelli@gmail.com>, Tony Lindgren <tony@atomide.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, arm-soc <linux-arm-kernel@lists.infradead.org>, Stefan Wahren <wahrenst@gmx.net>
List-Id: linux-omap@vger.kernel.org

On Sat, 14 Dec 2019 12:59:47 +0000
Russell King - ARM Linux admin <linux@armlinux.org.uk> wrote:

> On Sat, Dec 14, 2019 at 11:54:19AM +0100, H. Nikolaus Schaller wrote:
> > Hi Stefan,
> >   
> > > Am 15.10.2019 um 19:15 schrieb Stefan Wahren <wahrenst@gmx.net>:
> > > 
> > > Hi Florian,
> > > 
> > > The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:
> > > 
> > >  Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)
> > > 
> > > are available in the git repository at:
> > > 
> > >  git://github.com/anholt/linux tags/bcm2835-soc-next-2019-10-15
> > > 
> > > for you to fetch changes up to 781fa0a954240c8487683ddf837fb2c4ede8e7ca:
> > > 
> > >  ARM: bcm: Add support for BCM2711 SoC (2019-10-10 19:21:03 +0200)  
> > 
> > this patch has finally arrived in v5.5-rc1 but it seems to break
> > multiplatform build.
> > 
> > We run a distribution kernel that supports OMAP3/4/5, i.MX6 and RasPi 3B+
> > but since rebasing to v5.5-rc1 the kernel hangs after "Starting Kernel ...".
> > On all ARM devices (incl. RasPi 3B+).
> > 
> > Playing with our defconfig did show that deconfiguring CONFIG_ARCH_BCM2835
> > makes the kernel work again.
> > 
> > After further analysis it turns out that reverting this patch also
> > makes the boards work again.
> > 
> > I am not exactly sure what the reason is, but it may have something to
> > do with the new auto-selection of CONFIG_ZONE_DMA which is not automatically
> > selected by OMAP and i.MX6.
> > 
> > To reproduce on some OMAP device (i.MX6 should be similar)
> > 
> > 1st test:
> > 
> > git checkout v5.5-rc1
> > make omap2plus_defconfig
> >   
> > => boots OMAP device  
> > 
> > 2nd test:
> > 
> > ( echo CONFIG_ARCH_BCM2835=y; echo CONFIG_ARCH_BCM=y ) >>arch/arm/configs/omap2plus_defconfig
> > make omap2plus_defconfig
> >   
> > => fails to boot OMAP device  
> > 
here it does not give any output at all if earlycon is appended to
kernel parameters.

> > 3rd test:
> > 
> > git revert 781fa0a954240c8487683ddf837fb2c4ede8e7ca
> > make omap2plus_defconfig
> >   
> > => boots OMAP device  
> > 
> > BTW: the RasPi 3B+ runs equally well without this patch. So what is it
> > good for?
> > 
> > So please check and fix this patch.  
> 
> Enabling ZONE_DMA shouldn't cause this problem - but as it does, please
> enable memblock debugging and early console, and please send any boot
> messages you can get from the system when it fails to boot.  Also
> having a successful boot log may be useful.
> 
diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index ad08d470a2ca..b46cf3d5e389 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -17,6 +17,7 @@ config ARCH_OMAP3
        select OMAP_INTERCONNECT
        select PM_OPP if PM
        select PM if CPU_IDLE
+       select ZONE_DMA
        select SOC_HAS_OMAP2_SDRC
        select ARM_ERRATA_430973

seems not to cause problems with make omap2plus_defconfig
here.

Regards,
Andreas
