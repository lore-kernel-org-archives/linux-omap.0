From: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: [PATCH] i2c: omap: improve duty cycle on SCL
Date: Thu, 18 Jun 2015 08:39:11 +0200
Message-ID: <5582678F.4010505@gmx.de>
References: <1434482276-1210-1-git-send-email-balbi@ti.com> <55815581.80807@gmx.de> <20150617153812.GB18421@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150617153812.GB18421-HgARHv6XitJaoMGHk7MhZQC/G2K4zDHf@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Am 17.06.2015 um 17:38 schrieb Felipe Balbi:
> Hi,
>
> On Wed, Jun 17, 2015 at 01:09:53PM +0200, Michael Lawnick wrote:
>> Am 16.06.2015 um 21:17 schrieb Felipe Balbi:
>>> With this patch we try to be as close to 50%
>>> duty cycle as possible. The reason for this
>>> is that some devices present an erratic behavior
>>> with certain duty cycles.
>>>
>>> One such example is TPS65218 PMIC which fails
>>> to change voltages when running @ 400kHz and
>>> duty cycle is lower than 34%.
>>>
>>> The idea of the patch is simple:
>>>
>>> calculate desired scl_period from requested scl
>>> and use 50% for tLow and 50% for tHigh.
>> ...
>> Hmm, and what's about  Philips I2C specification 2.1, Jan 2000, Tabl=
e 5?
>>
>>> PARAMETER                       SYMBOL  STANDARD-MODE   FAST-MODE  =
   UNIT
>>>                                           MIN. MAX.     MIN. MAX.
>>> LOW period of the SCL clock     tLOW      4.7   =E2=80=93       1.3=
   =E2=80=93       =C2=B5s
>>> HIGH period of the SCL clock    tHIGH     4.0   =E2=80=93       0.6=
   =E2=80=93       =C2=B5s
>>
>> Your signal is in spec (0.85 =C2=B5s high, 1,65 low).
>> Maybe your TPS65218 is just buggy or signals are bad?
>
> yes, tps is buggy, it's written in the commit log itself.
>

So I think it is unacceptable to change the adapters code violating=20
specification because some buggy device doesn't work properly.
This change for your device has chance to blow up many correctly workin=
g=20
ones.
--=20
KR
Michael
