From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arm: omap: RX-51: ARM errata 430973 workaround
Date: Wed, 27 Mar 2013 14:12:09 -0700
Message-ID: <20130327211208.GQ10155@atomide.com>
References: <517283541.62064.1362124023621.JavaMail.apache@mail81.abv.bg>
 <201303241526.59275@pali>
 <20130327205606.GN10155@atomide.com>
 <201303272205.17182@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201303272205.17182@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc: Nishanth Menon <nm@ti.com>, =?utf-8?B?0JjQstCw0LnQu9C+INCU0LjQvNC40YLRgNC+0LI=?= <freemangordon@abv.bg>, linux@arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Pali Roh=C3=A1r <pali.rohar@gmail.com> [130327 14:09]:
> On Wednesday 27 March 2013 21:56:07 Tony Lindgren wrote:
> > * Pali Roh=C3=A1r <pali.rohar@gmail.com> [130324 07:31]:
> > > it is possible to upstream errata 430973 workaround for
> > > RX-51?
> >=20
> > I think we should make the SMC handling a generic function for
> > ARM.
> >=20
> > AFAIK just the SMC call numbering is different for various
> > implementations. So the handler and passing of the parameters
> > seems like it should be generic.
> >=20
>=20
> Not only, look at freemangordon's email:=20
> https://lkml.org/lkml/2013/3/1/62

Seem like you may need some SoC specific wrapper to the
generic function to deal with the params. But still seems
like we can have an ARM generic smc funtion.

Regards,

Tony
