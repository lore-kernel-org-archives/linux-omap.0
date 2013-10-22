From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] typo fixes (coordiante -> coordinate) in am335x
Date: Tue, 22 Oct 2013 10:05:52 +0100
Message-ID: <20131022090552.GE19112@lee--X1>
References: <1373901928-19605-1-git-send-email-zubair.lutfullah@gmail.com>
 <20130821075828.GZ7656@atomide.com>
 <1382198544.22609.8.camel@polaris.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1382198544.22609.8.camel@polaris.local>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan =?iso-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Samuel Ortiz <sameo@linux.intel.com>, Zubair Lutfullah <zubair.lutfullah@gmail.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Sat, 19 Oct 2013, Jan L=C3=BCbbe wrote:

> On Wed, 2013-08-21 at 00:58 -0700, Tony Lindgren wrote:
> > * Zubair Lutfullah <zubair.lutfullah@gmail.com> [130715 08:33]:
> > > Did a grep for coordiante and replaced them all
> > > with coordinate.
> > >=20
> > > This applies to the mfd-next tree.
> >=20
> > This should be safe to apply via the MFD tree as a non-critical
> > fix assuming the bootloaders are not yet using this:
> >=20
> > Acked-by: Tony Lindgren <tony@atomide.com>
>=20
> It seems this didn't get applied. It fixes the touchscreen on a
> BeagleBone black with the 7" LCD and we should avoid having people us=
e
> the wrong binding.
>=20
> Samuel or Lee: Could you take this patch?

This is the first time this patch has been sent to me.

I need Dmitry's input (no pun intended) on how he's like to deal with
this. At a bare minimum I'd like his Ack.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
