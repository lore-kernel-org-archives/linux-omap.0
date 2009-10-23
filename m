From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 4/4 v2] ASoC: TWL4030: Driver registration
	via twl4030_codec MFD
Date: Fri, 23 Oct 2009 08:27:55 +0300
Message-ID: <200910230827.55141.peter.ujfalusi@nokia.com>
References: <1256207208-25010-1-git-send-email-peter.ujfalusi@nokia.com>
	<1256207208-25010-5-git-send-email-peter.ujfalusi@nokia.com>
	<20091022165643.GA28051@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20091022165643.GA28051@rakim.wolfsonmicro.main>
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
Cc: "tony@atomide.com" <tony@atomide.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Thursday 22 October 2009 19:56:44 ext Mark Brown wrote:
> On Thu, Oct 22, 2009 at 01:26:48PM +0300, Peter Ujfalusi wrote:
> > Change the way how the twl4030 soc codec driver is
> > loaded/probed.
> > Use the device probing via tlw4030_codec MFD device.
> =

> I'm OK with the series but:
> > @@ -147,6 +147,7 @@ config SND_SOC_TLV320DAC33
> >  	tristate
> >
> >  config SND_SOC_TWL4030
> > +	select TWL4030_CODEC
> >  	tristate
> =

> due to Kconfig ignoring dependencies all the individual machine drivers
> are going to need to select this, and SND_SOC_ALL_CODECS will need to
> select it if the MFD core is enabled.  I should be able to fix this up
> myself so no need to repost for that alone.

Hmm, what do you mean by that?
I have checked it, and selecting the machine driver will enables the MFD_CO=
RE =

and TWL4030_CODEC in .config, also disabling the machine driver will also =

disable the MFD_CORE and the TWL4030_CODEC.

Can you go into details?

-- =

P=E9ter
