From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCHv5 0/2] McBSP: OMAP3: Add sidetone feature
Date: Mon, 22 Feb 2010 14:33:18 +0000
Message-ID: <1266849198.3159.37.camel@odin>
References: <1266841272-13135-1-git-send-email-ilkka.koskinen@nokia.com>
	<201002221618.15859.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <201002221618.15859.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, "Koskinen Ilkka (Nokia-D/Tampere)" <ilkka.koskinen@nokia.com>
List-Id: linux-omap@vger.kernel.org

On Mon, 2010-02-22 at 16:18 +0200, Peter Ujfalusi wrote:
> On Monday 22 February 2010 14:21:10 Koskinen Ilkka (Nokia-D/Tampere) wrote:
> > The first patch implements McBSP sidetone feature on OMAP3 while the second
> > one provides ALSA interface for using it.
> > 
> > The patch set is based on the patch Eduardo Valentin sent to alsa-devel
> > mailing list in October 2009. Channel gain control and enabling the
> > sidetone have been moved to ALSA interface as suggested in comments.
> > 
> > These patches apply on top of Janusz Krzysztofik's McBSP register cache
> > patches in linux-omap-2.6.git
> > 
> > Since the version 4, ASoC part has been modified to deal with McBSP ids
> > consistently (zero based indexing).
> > 
> > Eero Nurkkala (1):
> >   McBSP: OMAP3: Add sidetone feature
> > 
> > Ilkka Koskinen (1):
> >   ASoC: OMAP-McBSP: ASoC interface for McBSP sidetone
> > 
> >  arch/arm/mach-omap2/mcbsp.c             |    2 +
> >  arch/arm/plat-omap/include/plat/mcbsp.h |   60 +++++
> >  arch/arm/plat-omap/mcbsp.c              |  402
> > ++++++++++++++++++++++++++++++- sound/soc/omap/omap-mcbsp.c             | 
> > 138 +++++++++++
> >  sound/soc/omap/omap-mcbsp.h             |    2 +
> >  5 files changed, 603 insertions(+), 1 deletions(-)
> 
> Both looks OK for me:
> 
> Acked-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
