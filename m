From: Alexander Sverdlin <alexander.sverdlin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH RESEND] i2c: omap: improve duty cycle on SCL
Date: Wed, 17 Jun 2015 20:38:42 +0200
Message-ID: <5581BEB2.6070007@gmail.com>
References: <1434482445-1818-1-git-send-email-balbi@ti.com>
 <55813BA0.3010001@nokia.com> <20150617180052.GF18421@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150617180052.GF18421-HgARHv6XitJaoMGHk7MhZQC/G2K4zDHf@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org, Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hello Felipe,

On 17/06/15 20:00, Felipe Balbi wrote:
>>> With this patch we try to be as close to 50%
>>> > > duty cycle as possible. The reason for this
>>> > > is that some devices present an erratic behavior
>>> > > with certain duty cycles.
>>> > > 
>>> > > One such example is TPS65218 PMIC which fails
>>> > > to change voltages when running @ 400kHz and
>>> > > duty cycle is lower than 34%.
>>> > > 
>>> > > The idea of the patch is simple:
>>> > > 
>>> > > calculate desired scl_period from requested scl
>>> > > and use 50% for tLow and 50% for tHigh.
>>> > > 
>>> > > tLow is calculated with a DIV_ROUND_UP() to make
>>> > > sure it's slightly higher than tHigh and to make
>>> > > sure that we end up within I2C specifications.
>>> > > 
>>> > > Kudos to Nishanth Menon and Dave Gerlach for helping
>>> > > debugging the TPS65218 problem found on AM437x SK.
>>> > > 
>>> > > Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
>> > 
>> > NAK.
>> > This is a direct violation of PHILIPS I2C-bus Specification v.2.1,
>> > section 15.
>> > Namely, you will have LOW period of SCL clock shorter than required
>> > 1.3uS.
> how is this out of spec ?
> 
> http://i.imgur.com/jEDlZT7.png
> 
> -Width = 1.4us, frequency 373.1kHz, duty cycle of 47.76%
> 
> In any case, I have to send v2 anyway (found a bug which would show up
> on frequencies above 400kHz), so I'll resend this patch.

If you really target 50% duty cycle and there will be no rounding/truncation
error, you will end up with 1.25uS at 400kHz. I understand why you want to
make HIGH phase longer, but 50% is a bad target at 400hHz. Probably more safe
value?

Alex.
