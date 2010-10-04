From: Arun MURTHY <arun.murthy@stericsson.com>
Subject: RE: [PATCH 1/7] pwm: Add pwm core driver
Date: Mon, 4 Oct 2010 06:22:46 +0200
Message-ID: <F45880696056844FA6A73F415B568C695356E67D03@EXDCVYMBSTM006.EQ1STM.local>
References: <4CA1BC16.3020702@metafoo.de>
 <F45880696056844FA6A73F415B568C69532DC2FC60@EXDCVYMBSTM006.EQ1STM.local>
 <4CA25841.4090702@metafoo.de>
 <F45880696056844FA6A73F415B568C69532DC8B7E4@EXDCVYMBSTM006.EQ1STM.local>
 <AANLkTingb8ox5h5rN1YrxONibfrWLicoiS6yqKf_v5bJ@mail.gmail.com>
 <F45880696056844FA6A73F415B568C69532DCF32BC@EXDCVYMBSTM006.EQ1STM.local>
 <AANLkTikTo42Q5-yMEwyQH4mt=qLjaKrtJK3ydZNFyqai@mail.gmail.com>
 <F45880696056844FA6A73F415B568C69532DCF33BB@EXDCVYMBSTM006.EQ1STM.local>
 <AANLkTimPgPY9rX_MYZTv0PpRQgfWGoSeSE9WWy_ami-V@mail.gmail.com>
 <F45880696056844FA6A73F415B568C69532DCF34AE@EXDCVYMBSTM006.EQ1STM.local>
 <20101001180051.GC21157@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <20101001180051.GC21157@opensource.wolfsonmicro.com>
Content-Language: en-US
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>, Trilok Soni <soni.trilok@gmail.com>, "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>, Lars-Peter Clausen <lars@metafoo.de>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Bill Gatliff <bgat@billgatliff.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linus WALLEIJ <linus.walleij@stericsson.com>, Marek Vasut <marek.vasut@gmail.com>, "kgene.kim@samsung.com" <kgene.kim@samsung.com>, "rpurdie@rpsys.net" <rpurdie@rpsys.net>, "philipp.zabel@gmail.com" <philipp.zabel@gmail.com>, Mattias WALLIN <mattias.wallin@stericsson.com>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>, "eric.y.miao@gmail.com" <eric.y.miao@gmail.com>, Andrew
List-Id: linux-omap@vger.kernel.org

> On Fri, Oct 01, 2010 at 10:46:15AM +0200, Arun MURTHY wrote:
> > > On Fri, Oct 1, 2010 at 4:25 PM, Arun MURTHY
> 
> > > > I mean not the functions but the functionality.
> > > > PWM is a simple device and most of its clients are controlling
> > > intensity
> > > > of backlight, leds, vibrator etc.
> > > > I don't think these complex functionality are required.
> > > oh dear !
> > Here I mean why should all those function be exposed to the entire
> kernel,
> > as most of the pwm devices do not use them.
> 
> While many PWM uses are very simple that doesn't mean that we'll never
> need to support more advanced uses.  Normally we try to design APIs so
> that they both scale down to the simplest use cases and also up to more
> complex ones.
My intention is just to enable two pwm drivers and build successfully.
This patch can be considered for this reason and taken up until Bill's
patches are merged.

Thanks and Regards,
Arun R Murthy
-------------
