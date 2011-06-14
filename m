From: Tejun Heo <tj@kernel.org>
Subject: Re: Re: [PATCH v4 11/18] input: Add initial support for TWL6040
 vibrator
Date: Tue, 14 Jun 2011 08:34:00 +0200
Message-ID: <20110614063400.GB8141@htj.dyndns.org>
References: <1307706876-4768-1-git-send-email-peter.ujfalusi@ti.com>
 <1307706876-4768-12-git-send-email-peter.ujfalusi@ti.com>
 <20110611231854.GA3979@core.coreip.homeip.net>
 <1530216.k8lJ4nKZ1s@barack>
 <20110613212028.GA13138@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110613212028.GA13138@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>, "Girdwood, Liam" <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Samuel Ortiz <sameo@linux.intel.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Lopez Cruz, Misael" <misael.lopez@ti.com>, Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
List-Id: linux-omap@vger.kernel.org

Hello,

On Mon, Jun 13, 2011 at 02:20:28PM -0700, Dmitry Torokhov wrote:
> On Mon, Jun 13, 2011 at 12:51:16PM +0300, P=E9ter Ujfalusi wrote:
> > On Sunday 12 June 2011 01:18:54 Dmitry Torokhov wrote:
> >=20
> > > > +static int twl6040_vibra_open(struct input_dev *input)
> > > > +{
> > > > +     struct vibra_info *info =3D input_get_drvdata(input);
> > > > +
> > > > +     info->workqueue =3D create_singlethread_workqueue("vibra"=
);
> > > > +     if (info->workqueue =3D=3D NULL) {
> > > > +             dev_err(&input->dev, "couldn't create workqueue\n=
");
> > > > +             return -ENOMEM;
> > > > +     }
> > >=20
> > > Why do we need to create a separate workqueue? With arrival of CW=
Q
> > > it looks like we should be able to use one of the system-wide
> > > workqueues for this.
> >=20
> > The reason for this is to ensure that we have the lowest latency as=
 possible=20
> > in most case. In the embedded devices we use the vibra for tactile =
type of=20
> > feedbacks as well, where few tens of ms delay can be felt.
>=20
> Even if you create a dedicated workqueue with CWQ it will still be us=
ing
> shared pool of threads so I do not think that latency will be affecte=
d
> by using system-wide workqueue. I might be mistaken though, Tejun wil=
l
> correct me if I am wrong...

Yeap, using a separate workqueue doesn't do anything for latency
unless WQ_HIGHPRI and/or WQ_CPU_INTENSIVE is used; however, _please_
stay away from it unless absolutely sure it's necessary (ie. unless
you can pin point to where latency is coming from - even in that case,
the thing which induces the latency probably is the one which should
be fixed).

CMWQ is pretty good at keeping latency low unless something is
consuming large amount of CPU cycles and those work items are marked
WQ_CPU_INTENSIVE, not the other way around and WQ_HIGHPRI is for
things like MCE error reporting.

Thanks.

--=20
tejun
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
