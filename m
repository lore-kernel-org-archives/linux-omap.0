From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: Re: [PATCH v6 11/18] input: Add initial support for TWL6040 vibrator
Date: Wed, 22 Jun 2011 14:37:05 +0300
Message-ID: <9447778.OLKFu0QH6G@barack>
References: <1308663556-29120-1-git-send-email-peter.ujfalusi@ti.com> <1308663556-29120-12-git-send-email-peter.ujfalusi@ti.com> <20110621203200.GA3731@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20110621203200.GA3731@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Girdwood, Liam" <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Samuel Ortiz <sameo@linux.intel.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Lopez Cruz, Misael" <misael.lopez@ti.com>, Tejun Heo <tj@kernel.org>
List-Id: linux-omap@vger.kernel.org

Hello Dmitry,

On Tuesday 21 June 2011 22:32:01 Dmitry Torokhov wrote:
> On Tue, Jun 21, 2011 at 04:39:09PM +0300, Peter Ujfalusi wrote:
> > From: Misael Lopez Cruz <misael.lopez@ti.com>
> >=20
> > Add twl6040_vibra as a child of MFD device twl6040_codec. This
> > implementation covers the PCM-to-PWM mode of TWL6040 vibrator
> > module.
> >=20
> > Signed-off-by: Misael Lopez Cruz <misael.lopez@ti.com>
> > Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > CC: Tejun Heo <tj@kernel.org>
>=20
> Peter,
>=20
> As Tejun mentioned, there is no difference between having a "private"
> workqueue created with alloc_workqueue() with default parameters and
> using system-wide workqueue. Therefore please use system-wide one. If
> your use shows that you indeed need high-priority workqueue it can be
> added later.

I have replaced the singlethreaded wq with the call suggested by Tejun:
https://lkml.org/lkml/2011/6/17/99

If this is a problem, I can rework this, and remove the code, which is =
not=20
going to be needed, when the system_wq is in use, but I would like to k=
eep the=20
alloc_workqueue way, since it is going to be easier for us to experimen=
t with=20
parameters, if we face with issues.
=20
> Otherwise:
>=20
>         Acked-by: Dmitry Torokhov <dtor@mail.ru>
>=20
> Please feel free to merge this code with the rest of TWL6040 patches
> (presumably throgh Samuel's MFD tree).

Thank you,
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
