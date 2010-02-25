From: "Olaya, Margarita" <magi.olaya@ti.com>
Subject: Re: [PATCHv4 0/7] TWL6030 audio codec initial support
Date: Thu, 25 Feb 2010 11:40:46 -0600
Message-ID: <1889FA7136B567478A67D4B0F85B0CCE65DD26C5@dlee06.ent.ti.com>
References: <1889FA7136B567478A67D4B0F85B0CCE65DD1B12@dlee06.ent.ti.com>
	<1267011618.3274.202.camel@odin>
	<1889FA7136B567478A67D4B0F85B0CCE65DD2303@dlee06.ent.ti.com>
	<1267089182.3255.58.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1267089182.3255.58.camel@odin>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>
List-Id: linux-omap@vger.kernel.org



> -----Original Message-----
> From: Liam Girdwood [mailto:lrg@slimlogic.co.uk]
> Sent: Thursday, February 25, 2010 3:13 AM
> To: Olaya, Margarita
> Cc: alsa-devel@alsa-project.org; linux-omap@vger.kernel.org; broonie@opensource.wolfsonmicro.com
> Subject: Re: [alsa-devel] [PATCHv4 0/7] TWL6030 audio codec initial support
> 
> On Wed, 2010-02-24 at 18:17 -0600, Olaya, Margarita wrote:
> >
> > > -----Original Message-----
> > > From: Liam Girdwood [mailto:lrg@slimlogic.co.uk]
> > > Sent: Wednesday, February 24, 2010 5:40 AM
> > > To: Olaya, Margarita
> > > Cc: alsa-devel@alsa-project.org; linux-omap@vger.kernel.org; broonie@opensource.wolfsonmicro.com
> > > Subject: Re: [PATCHv4 0/7] TWL6030 audio codec initial support
> > >
> > > On Tue, 2010-02-23 at 18:10 -0600, Olaya, Margarita wrote:
> > > > Following patch series add initial support for TWL6030 codec driver.
> > > > The patch set is based on the series sent from Misael Lopez in October 2009.
> > > >
> > > > Changes from v3:
> > > > - Remove snd_soc_init_card function
> > > > - Adapt to latest twl core changes based on Balaji's comment
> > > >
> > > > Regards,
> > > > Margarita
> > > >
> > > > ---
> > > > Misael Lopez Cruz (7):
> > > >   OMAP4: PMIC: Add support for twl6030 codec
> > > >   ASoC: TWL6030: Add twl6030 codec driver
> > > >   ASoC: TWL6030: Manual power-up/down sequences
> > > >   ASoC: TWL6030: Add support for low-power PLL
> > > >   ASoC: TWL6030: Add restrictions for low-power playback mode
> > > >   ASoC: TWL6030: Enable audio interrupt
> > > >   ASoC: TWL6030: Detect power-up sequence completion
> > >
> > > Btw, since this is a new driver can you rebase the 6 codec patches into
> > > a single patch.
> > >
> >
> > The second patch adds the basic support for the codec and the others add features, that way it
> could be easier to review.
> 
> Some of the subsequent patches are actually removing chunks of code
> rather than just adding new features. In this case it's actually easier
> to review the complete codec driver as one patch rather than a series of
> changes (showing your internal development history).
> 
Ok, I'll send a single patch then.

Regards,
Margarita

> Thanks
> 
> Liam
> 
> --
> Freelance Developer, SlimLogic Ltd
> ASoC and Voltage Regulator Maintainer.
> http://www.slimlogic.co.uk
