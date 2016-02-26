From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFT PATCH] arm: omap1_defconfig: convert to use libata PATA drivers
Date: Fri, 26 Feb 2016 17:17 +0100
Message-ID: <14037681.WEvu3PZVCh@wuerfel>
References: <1439571876-13758-1-git-send-email-b.zolnierkie@samsung.com> <20150817063454.GF4215@atomide.com> <6359194.rjne3vOG9H@amdc1976>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <6359194.rjne3vOG9H@amdc1976>
Sender: linux-ide-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Tony Lindgren <tony@atomide.com>, Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thursday 04 February 2016 15:16:10 Bartlomiej Zolnierkiewicz wrote:
> On Sunday, August 16, 2015 11:34:55 PM Tony Lindgren wrote:

> > > Build tested only.
> > > If you have affected hardware please test.  Thank you.
> > 
> > All my omap1 devices are in a rack using NFSroot or MMC so
> > I can't test this. Seems like a good idea to me thoug, and does
> > not cause merge conflicts. So if you want to queue this via
> > along with other PATA related patches, please feel free to
> > add:
> > 
> > Acked-by: Tony Lindgren <tony@atomide.com>
> 
> Thank you.
> 
> Arnd/Olof, could you please merge this patch?
> 

Can you send the two patches in question again, and add arm@kernel.org
to Cc? I have trouble pulling them out of the archive at the moment.

	Arnd
