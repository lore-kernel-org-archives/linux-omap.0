From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH][2.6.31-rc5] ARM: OMAP: McBSP: Fix ASoC on
	OMAP1510 by fixing API of omap_mcbsp_start/stop
Date: Fri, 7 Aug 2009 11:51:43 +0300
Message-ID: <200908071151.44083.peter.ujfalusi@nokia.com>
References: <1249628387-7372-1-git-send-email-jhnikula@gmail.com>
	<200908071130.54337.peter.ujfalusi@nokia.com>
	<20090807114757.0067a707.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20090807114757.0067a707.jhnikula@gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Jarkko Nikula <jhnikula@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Friday 07 August 2009 11:47:57 ext Jarkko Nikula wrote:
> On Fri, 7 Aug 2009 11:30:54 +0300
>
> Peter Ujfalusi <peter.ujfalusi@nokia.com> wrote:
> > Looks nice, but I would have done it a bit differently...
>
> ...
>
> > > -void omap_mcbsp_start(unsigned int id);
> > > -void omap_mcbsp_stop(unsigned int id);
> > > +void omap_mcbsp_start(unsigned int id, int tx, int rx);
> > > +void omap_mcbsp_stop(unsigned int id, int tx, int rx);
> >
> > void omap_mcbsp_start(unsigned int id, int dir);
> > void omap_mcbsp_stop(unsigned int id, int dir);
>
> Valid point and cleans up a bit the ALSA SoC part of the patch.
> However I didn't want to limit this generic arch/arm/plat-omap/mcbsp.c
> into audio use case only. My change still allows to start transmitter
> and receiver exactly at the same time. Might be worth if the
> generic McBSP driver is used for something else than audio.

Good point.

-- =

P=E9ter
