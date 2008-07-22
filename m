From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [i2c] N800 problems with MMC, LM8323 on current linux-omap git
	head
Date: Tue, 22 Jul 2008 14:43:14 +0100
Message-ID: <20080722134314.GC8318@fluff.org.uk>
References: <20080722124743.GA5820@kos.to> <90eb4be1e5a489819f08e76ad872e920@felipebalbi.com> <20080722133742.GA7492@kos.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from aeryn.fluff.org.uk ([87.194.8.8]:52884 "EHLO
	kira.home.fluff.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750855AbYGVNnW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Jul 2008 09:43:22 -0400
Content-Disposition: inline
In-Reply-To: <20080722133742.GA7492@kos.to>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Riku Voipio <riku.voipio@iki.fi>
Cc: Felipe Balbi <me@felipebalbi.com>, linux-omap@vger.kernel.org, i2c@lm-sensors.org

On Tue, Jul 22, 2008 at 04:37:42PM +0300, Riku Voipio wrote:
> On Tue, Jul 22, 2008 at 07:52:44AM -0500, Felipe Balbi wrote:
> > On Tue, 22 Jul 2008 15:47:43 +0300, Riku Voipio <riku.voipio@iki.fi> wrote:
> > 
> > > Hmm. I think it would be better to avoid calling the probe
> > > in first place. git diff made the attached patch look more
> > > confusing than it actually is. Personally I'd eliminate
> > > all ifdefs from those i2c_board_info structs.
> 
> > I did the same thing before, but then we're gonna start adding
> > several i2c_board_info for different hw. I mean, we should
> > just reuse the code and the driver should know when the device
> > is not present and stop probing without any problems to the rest
> > of the system.
> 
> If the different hw has different devices on the i2c bus, then
> different i2c_board_info struct should be provided. IIRC i2c_board_info
> is expected to provide a accurate picture of what i2c devices is
> connected to the bus. This has been used as a argument to remove detection
> code from .probe functions.
> 
> To all the confused i2c list readers, the topic is about should we
> split n800_i2c_board_info_2 [0] to n800 and n810 specific structs[1]
> or make the lm8323 configure to err out earlier[2].

Split them into a common and then machine specfic structures, you are
allowed to register more than one board per bus.
 
> [0] http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=blob;f=arch/arm/mach-omap2/board-n800.c;h=ae85c2c60534820856c8bb0e019be29f2375470b;hb=HEAD#l645
> [1] http://article.gmane.org/gmane.linux.ports.arm.omap/9562
> [2] http://article.gmane.org/gmane.linux.ports.arm.omap/9522
> 
> 
> "rm -rf" only sounds scary if you don't have backups
> 
> _______________________________________________
> i2c mailing list
> i2c@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/i2c

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
