From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH] OMAP3 ROM Random Number Generator support
Date: Tue, 2 Apr 2013 01:09:42 +0300
Message-ID: <20130401220942.GB18196@blackmetal.musicnaut.iki.fi>
References: <2059303614.30062.1364731542427.JavaMail.apache@mail83.abv.bg>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2059303614.30062.1364731542427.JavaMail.apache@mail83.abv.bg>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?B?0JjQstCw0LnQu9C+INCU0LjQvNC40YLRgNC+0LI=?= <freemangordon@abv.bg>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, tony@atomide.com, juha.yrjola@solidboot.com, linux@arm.linux.org.uk, mpm@selenic.com, herbert@gondor.apana.org.au, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Sun, Mar 31, 2013 at 03:05:42PM +0300, =D0=98=D0=B2=D0=B0=D0=B9=D0=BB=
=D0=BE =D0=94=D0=B8=D0=BC=D0=B8=D1=82=D1=80=D0=BE=D0=B2 wrote:
> Yep, the code looks almost identical, I guess with some tweaks all SM=
C
> code from that patch could be removed and instead used the one from S=
MC
> PPA API.
>=20
> What I don't get, is why one needs to disable/enable fiqs/irqs:

[..]

> Do you have any idea why is that needed? Any other code I've ever see=
n
> to call SM, does not disable fiqs/irqs, is RNG SMC somehow special? I
> know this is Nokia's code, but still, if we can get some understandin=
g...

I think without disabling irqs you may suffer some strange crashes when
heavily stressing the RNG... that's why you also have cache flushes bef=
ore
and after the SMC. With proper test suite you could probably verify thi=
s.
How are you testing this driver?

A.
