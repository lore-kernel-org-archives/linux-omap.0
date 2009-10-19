From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 3/4] ASoC: TWL4030: Only update the needed
	bits in *set_dai_sysclk
Date: Mon, 19 Oct 2009 15:59:38 +0300
Message-ID: <200910191559.38478.peter.ujfalusi@nokia.com>
References: <1255956140-4829-1-git-send-email-peter.ujfalusi@nokia.com>
	<1255956140-4829-4-git-send-email-peter.ujfalusi@nokia.com>
	<20091019125507.GA1417@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20091019125507.GA1417@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "sameo@linux.intel.com" <sameo@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

On Monday 19 October 2009 15:55:08 ext Mark Brown wrote:
> On Mon, Oct 19, 2009 at 03:42:19PM +0300, Peter Ujfalusi wrote:
> > +	apll_ctrl =3D twl4030_read_reg_cache(codec, TWL4030_REG_APLL_CTL);
> > +	apll_ctrl &=3D ~TWL4030_APLL_INFREQ;
> >  	switch (freq) {
> =

> I'll apply this - it's idiomatic for the current driver - but you might
> want to look at snd_soc_update_bits() which does a read/modify/write
> cycle for you.
> =


Yeah, it is a good idea.
I'll address this when I go through the soc codec driver in my planned revi=
sit =

and cleanup round quite soon.

Thanks,
P=E9ter
