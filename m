From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 10/22] mfd/ti_am335x_tscadc: Add DT support
Date: Tue, 11 Jun 2013 19:42:14 +0100
Message-ID: <20130611184214.GB4320@laptop>
References: <1370950268-7224-1-git-send-email-bigeasy@linutronix.de>
 <1370950268-7224-11-git-send-email-bigeasy@linutronix.de>
 <20130611142347.GF29135@zurbaran>
 <51B73756.5010004@linutronix.de>
 <20130611150505.GI29135@zurbaran>
 <51B74540.2020608@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <51B74540.2020608@linutronix.de>
Sender: linux-input-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Samuel Ortiz <sameo@linux.intel.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Jonathan Cameron <jic23@cam.ac.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Felipe Balbi <balbi@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, "Patil, Rachna" <rachna@ti.com>, Pantelis Antoniou <panto@antoniou-consulting.com>
List-Id: linux-omap@vger.kernel.org

On Tue, 11 Jun 2013, Sebastian Andrzej Siewior wrote:

> On 06/11/2013 05:05 PM, Samuel Ortiz wrote:
> > Hi Sebastian,
>=20
> Hi Samuel,
>=20
> > On Tue, Jun 11, 2013 at 04:42:30PM +0200, Sebastian Andrzej Siewior=
 wrote:
> >> In the end I would like not to post a patch with "From: !=3D me" a=
nd
> >> don't make change which the original author did not do. Also dropp=
ing
> >> their authorship isn't nice. What could we agree on?
> > You probably don't want to change authorship unless the final patch=
 is
> > really far from the original one. In which case you can change it a=
nd
> > mention the original author name in the commit log.
> > If you have only made a few changes on top of the original patch, p=
lease
> > say so explicitely in the commit log. Don't bother if we're talking
> > about small changes or cosmetic ones. But your commit log has to be
> > readable and clear.
>=20
> Commit 06c9494 on of many examples where cosmetic are recorded. But t=
o
> make some progress I rewrite the commit log to resolve this and don't
> add anything to the sign-off area.

If you are submitting the patch, you still have to add your own SOB.

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
