From: Alexander Sverdlin <alexander.sverdlin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH RESEND] i2c: omap: improve duty cycle on SCL
Date: Wed, 17 Jun 2015 21:21:33 +0200
Message-ID: <5581C8BD.9060405@gmail.com>
References: <1434482445-1818-1-git-send-email-balbi@ti.com>
 <55813BA0.3010001@nokia.com> <20150617180052.GF18421@saruman.tx.rr.com>
 <5581BEB2.6070007@gmail.com> <20150617185714.GH18421@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150617185714.GH18421-HgARHv6XitJaoMGHk7MhZQC/G2K4zDHf@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hello!

On 17/06/15 20:57, Felipe Balbi wrote:
>>>>>>> duty cycle as possible. The reason for this
>>>>>>> > >>> > > is that some devices present an erratic behavior
>>>>>>> > >>> > > with certain duty cycles.
>>>>>>> > >>> > > 
>>>>>>> > >>> > > One such example is TPS65218 PMIC which fails
>>>>>>> > >>> > > to change voltages when running @ 400kHz and
>>>>>>> > >>> > > duty cycle is lower than 34%.
>>>>>>> > >>> > > 
>>>>>>> > >>> > > The idea of the patch is simple:
>>>>>>> > >>> > > 
>>>>>>> > >>> > > calculate desired scl_period from requested scl
>>>>>>> > >>> > > and use 50% for tLow and 50% for tHigh.
>>>>>>> > >>> > > 
>>>>>>> > >>> > > tLow is calculated with a DIV_ROUND_UP() to make
>>>>>>> > >>> > > sure it's slightly higher than tHigh and to make
>>>>>>> > >>> > > sure that we end up within I2C specifications.
>>>>>>> > >>> > > 
>>>>>>> > >>> > > Kudos to Nishanth Menon and Dave Gerlach for helping
>>>>>>> > >>> > > debugging the TPS65218 problem found on AM437x SK.
>>>>>>> > >>> > > 
>>>>>>> > >>> > > Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
>>>>> > >> > 
>>>>> > >> > NAK.
>>>>> > >> > This is a direct violation of PHILIPS I2C-bus Specification v.2.1,
>>>>> > >> > section 15.
>>>>> > >> > Namely, you will have LOW period of SCL clock shorter than required
>>>>> > >> > 1.3uS.
>>> > > how is this out of spec ?
>>> > > 
>>> > > http://i.imgur.com/jEDlZT7.png
>>> > > 
>>> > > -Width = 1.4us, frequency 373.1kHz, duty cycle of 47.76%
>>> > > 
>>> > > In any case, I have to send v2 anyway (found a bug which would show up
>>> > > on frequencies above 400kHz), so I'll resend this patch.
>> > 
>> > If you really target 50% duty cycle and there will be no
>> > rounding/truncation error, you will end up with 1.25uS at 400kHz. I
>> > understand why you want to make HIGH phase longer, but 50% is a bad
>> > target at 400hHz. Probably more safe value?
> We can't generate exactly 400kHz anyway, and we're not getting exactly
> 50% duty cycle, it just brings it *closer* to that. I even mention the
> reason for the DIV_ROUND_UP() there. Let's just go through the math
> using TRM equation:
> 
> @400kHz with 12MHz internal clock:
> 
> tLow = (SCLL + 7) * iclk_period
> 
> 1250 = (SCLL + 7) * 1/12MHz
> 
> SCLL = DIV_ROUND_UP(1250, 83) - 7
> SCLL = (1250 + 82)/83 - 7
> SCLL = 9
> 
> Now if we do the reverse to find actual tLow:
> 
> tLow = (9 + 7) * 83
> tLow = 1328ns
> 
> Likewise if we do it for tHigh:
> 
> tHigh = (SCLH + 5) iclk_period
> 
> SCLH = 1250 / 83 - 5
> SCLH = 10
> 
> tHigh = 15 * 83
> tHigh = 1245
> 
> tHigh + tLow (SCL period) = 2573ns. That gives us SCL of 388.65kHz. An

The bus rate is actually 12MHz/(SCLH+5+SCLL+7), so it's ~387096Hz.
Anyway, it's still possible to have maximum bus rate if SCLH+SCLL=12000000/400000-5-7

Let say SCLH=9, SCLL=9, still within the spec and exactly 400kHz
But you need another equations and it's not about 50% duty cycle

> error of mere 3% of what we really wanted to achieve. I'd say this is
> pretty darn good.
> 
> Now you tell me, how is this *ever* going to be out of spec ?
> 
> DIV_ROUND_UP() and the truncation at internal clock period calculation
> makes sure that tLow will be within spec. Instead of blindly NAKing the
> patch, you could've gone through this exercise yourself.
