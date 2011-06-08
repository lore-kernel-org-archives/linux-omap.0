From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2 03/12] OMAP3: Move common pmic
	configuration to pmic-common
Date: Wed, 8 Jun 2011 09:51:30 +0300
Message-ID: <201106080951.31056.peter.ujfalusi@ti.com>
References: <1307456297-15010-1-git-send-email-peter.ujfalusi@ti.com>
	<1307456297-15010-4-git-send-email-peter.ujfalusi@ti.com>
	<20110607144534.GA27477@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20110607144534.GA27477@atomide.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tony Lindgren <tony@atomide.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Girdwood, Liam" <lrg@ti.com>
List-Id: linux-omap@vger.kernel.org

On Tuesday 07 June 2011 17:45:35 Tony Lindgren wrote:
> > +#define TWL_COMMON_PDATA_BCI		(1 << 1)
> > +#define TWL_COMMON_PDATA_MADC		(1 << 2)
> > +#define TWL_COMMON_PDATA_CODEC		(1 << 3)
> =

> This is looking good, thanks for cleaning up the twl bloat in
> board-*.c files :)

As I recall the first three patch results ~600 less lines of code under mac=
h-
omap2.

> Maybe already define TWL_COMMON_PDATA_AUDIO here so you can
> drop most of patch 7/12?
> =

> If you need both then you can temporarily have:
> =

> #define TWL_COMMON_PDATA_CODEC	TWL_COMMON_PDATA_AUDIO

I have not thought about this.
But I think we can live with the TWL_COMMON_PDATA_AUDIO all the way.
I'll wait for more comments, and I'll do this for the v3.

Thanks,
P=E9ter
