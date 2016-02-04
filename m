From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [RFT PATCH] arm: omap1_defconfig: convert to use libata PATA
 drivers
Date: Thu, 04 Feb 2016 15:16:10 +0100
Message-ID: <6359194.rjne3vOG9H@amdc1976>
References: <1439571876-13758-1-git-send-email-b.zolnierkie@samsung.com>
 <1439571876-13758-16-git-send-email-b.zolnierkie@samsung.com>
 <20150817063454.GF4215@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-reply-to: <20150817063454.GF4215@atomide.com>
Sender: linux-ide-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


Hi,

On Sunday, August 16, 2015 11:34:55 PM Tony Lindgren wrote:
> * Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com> [150814 10:10]:
> > IDE subsystem has been deprecated since 2009 and the majority
> > (if not all) of Linux distributions have switched to use
> > libata for ATA support exclusively.  However there are still
> > some users (mostly old or/and embedded non-x86 systems) that
> > have not converted from using IDE subsystem to libata PATA
> > drivers.  This doesn't seem to be good thing in the long-term
> > for Linux as while there is less and less PATA systems left
> > in use:
> > 
> > * testing efforts are divided between two subsystems
> > 
> > * having duplicate drivers for same hardware confuses users
> > 
> > This patch converts omap1_defconfig to use libata PATA
> > drivers.
> > 
> > Cc: Tony Lindgren <tony@atomide.com>
> > Cc: linux-omap@vger.kernel.org
> > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > ---
> > Build tested only.
> > If you have affected hardware please test.  Thank you.
> 
> All my omap1 devices are in a rack using NFSroot or MMC so
> I can't test this. Seems like a good idea to me thoug, and does
> not cause merge conflicts. So if you want to queue this via
> along with other PATA related patches, please feel free to
> add:
> 
> Acked-by: Tony Lindgren <tony@atomide.com>

Thank you.

Arnd/Olof, could you please merge this patch?

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> >  arch/arm/configs/omap1_defconfig | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm/configs/omap1_defconfig b/arch/arm/configs/omap1_defconfig
> > index 0c8a787..6ffc984 100644
> > --- a/arch/arm/configs/omap1_defconfig
> > +++ b/arch/arm/configs/omap1_defconfig
> > @@ -96,14 +96,14 @@ CONFIG_BLK_DEV_LOOP=y
> >  CONFIG_BLK_DEV_RAM=y
> >  CONFIG_BLK_DEV_RAM_COUNT=2
> >  CONFIG_BLK_DEV_RAM_SIZE=8192
> > -CONFIG_IDE=m
> > -CONFIG_BLK_DEV_IDECS=m
> >  CONFIG_SCSI=y
> >  # CONFIG_SCSI_PROC_FS is not set
> >  CONFIG_BLK_DEV_SD=y
> >  CONFIG_CHR_DEV_ST=y
> >  CONFIG_BLK_DEV_SR=y
> >  CONFIG_CHR_DEV_SG=y
> > +CONFIG_ATA=m
> > +CONFIG_PATA_PCMCIA=m
> >  CONFIG_NETDEVICES=y
> >  CONFIG_TUN=y
> >  CONFIG_PHYLIB=y

