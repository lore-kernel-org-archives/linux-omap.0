From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: Re: [PATCHv4 00/20] OMAP ASoC changes in DMA utilization
Date: Wed, 19 Aug 2009 10:48:35 +0300
Message-ID: <20090819074835.GB25559@esdhcp037198.research.nokia.com>
References: <1250509879-6703-1-git-send-email-eduardo.valentin@nokia.com>
 <20090817170549.f0adf2a4.jhnikula@gmail.com>
 <20090819074011.GA25559@esdhcp037198.research.nokia.com>
Reply-To: eduardo.valentin@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:58421 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750794AbZHSICZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Aug 2009 04:02:25 -0400
Content-Disposition: inline
In-Reply-To: <20090819074011.GA25559@esdhcp037198.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>
Cc: ext Jarkko Nikula <jhnikula@gmail.com>, Takashi Iwai <tiwai@suse.de>, Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>

On Wed, Aug 19, 2009 at 09:40:12AM +0200, Valentin Eduardo (Nokia-D/Helsinki) wrote:
> Hello guys,
> 
> On Mon, Aug 17, 2009 at 04:05:49PM +0200, Jarkko Nikula wrote:
> > On Mon, 17 Aug 2009 14:50:59 +0300
> > Eduardo Valentin <eduardo.valentin@nokia.com> wrote:
> > 
> > > Hello again guys,
> > > 
> > > Here is version 4 of these changes. No real changes from previous versions.
> > > The only thing is that now I've rebased on top of Takashi's tree:
> > > http://git.kernel.org/?p=linux/kernel/git/tiwai/sound-2.6.git;a=summary
> > > 
> > > as there are pending things there which Jarkko has pointed on previous series.
> > > 
> > Here's my ack to the ASoC part. I tested the set on top of these
> > Janusz's patches:
> > 
> > http://mailman.alsa-project.org/pipermail/alsa-devel/2009-August/020170.html
> > http://mailman.alsa-project.org/pipermail/alsa-devel/2009-August/020171.html
> > http://mailman.alsa-project.org/pipermail/alsa-devel/2009-August/020262.html
> > 
> > Note, that I posted modified version for the patch 16 based on Janusz's
> > [PATCH 3/3 v3].
> > 
> > Acked-by: Jarkko Nikula <jhnikula@gmail.com>
> > 
> > > 
> > >  arch/arm/mach-omap2/mcbsp.c             |    5 +
> > >  arch/arm/plat-omap/include/mach/mcbsp.h |   49 ++++
> > >  arch/arm/plat-omap/mcbsp.c              |  377 ++++++++++++++++++++++++++++++-
> > >  sound/soc/omap/omap-mcbsp.c             |   78 ++++++-
> > >  sound/soc/omap/omap-pcm.c               |   14 +-
> > >  sound/soc/omap/omap-pcm.h               |    2 +
> > >  6 files changed, 511 insertions(+), 14 deletions(-)
> > > 
> > Tony, if you are ok with the OMAP McBSP changes, how it would be best
> > get these merged? Via ASoC, LKML or separately from both
> > subsystems during the merge window?
> 
> Tony, Takashi,
> 
> About these changes. I have one doubt. What is the correct tree to base them?
> There are changes under arch/arm/plat-omap/ and under sound/soc/omap/.
> 
> Should I base them:
> - all 20 patches against sound-2.6.git tree (Takashi's tree),
> - all 20 patches against linux-omap.git tree (Tony's tree),
> - make mcbsp part against Tony's tree and asoc part against Takashi's tree
> 
> Please do not apply this version. Let's define this first, then I send
> the correct version.

There is 1 Jarkko's patch which changes arch/arm/plat-omap/ which is already
in Takashi's tree, IIRC.

> 
> BR,
> 
> > 
> > 
> > -- 
> > Jarkko
> 
> -- 
> Eduardo Valentin

-- 
Eduardo Valentin
