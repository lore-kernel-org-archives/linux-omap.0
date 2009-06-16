From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [RESEND][PATCH] input: Added TSC2003
Date: Tue, 16 Jun 2009 08:20:44 +0200
Message-ID: <20090616062044.GA20209@avionic-design.de>
References: <4A366439.70005@mocean-labs.com> <5d5443650906151110u3f7d9d1cm1990e767d29a45b6@mail.gmail.com> <4A36A1C2.2060805@mocean-labs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4A36A1C2.2060805@mocean-labs.com>
Sender: linux-input-owner@vger.kernel.org
To: Richard =?utf-8?Q?R=C3=B6jfors?= <richard.rojfors.ext@mocean-labs.com>
Cc: Trilok Soni <soni.trilok@gmail.com>, linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Richard R=C3=B6jfors wrote:
> On 09-06-15 20.10, Trilok Soni wrote:
> > Hi,
> >=20
> > On Mon, Jun 15, 2009 at 8:39 PM, Richard
> > R=C3=B6jfors<richard.rojfors.ext@mocean-labs.com> wrote:
> >> Supplied is a driver for the TSC2003. There is actually a driver f=
or TSC2007 which can be used in some cases.
> >> The platform struct is reused from the TSC2007.
> >> There is a big difference in the implementation between the driver=
s, this one does not use HR timers.
> >> The TSC2007 driver performs synchronous I2C in the timer callback =
(SW IRQ context) which is bad when
> >> the I2C driver is interrupt driven.
> >>
> >=20
> > Meaning? I think I2C transaction can sleep.
>=20
> Yes that's what it means, and that's bad in a HR timer callback.

Note that my patch to the tsc2007 to support the tsc2003 exactly fixes =
this
problem. It moves the actual I2C transfers into a workqueue, so no slee=
ping
functions are called from the hrtimer callback.

Thierry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
