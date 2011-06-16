From: Tejun Heo <tj@kernel.org>
Subject: Re: Re: Re: Re: Re: Re: [PATCH v4 11/18] input: Add initial support
 for TWL6040 vibrator
Date: Thu, 16 Jun 2011 14:02:44 +0200
Message-ID: <20110616120244.GA2611@htj.dyndns.org>
References: <1307706876-4768-1-git-send-email-peter.ujfalusi@ti.com>
 <20110615081858.GM8141@htj.dyndns.org>
 <20110615082301.GN8141@htj.dyndns.org>
 <5476342.2jZLF0UGcI@barack>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5476342.2jZLF0UGcI@barack>
Sender: linux-input-owner@vger.kernel.org
To: =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Girdwood, Liam" <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Samuel Ortiz <sameo@linux.intel.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Lopez Cruz, Misael" <misael.lopez@ti.com>
List-Id: linux-omap@vger.kernel.org

Hello,

On Thu, Jun 16, 2011 at 02:13:59PM +0300, P=E9ter Ujfalusi wrote:
> On Wednesday 15 June 2011 10:23:01 Tejun Heo wrote:
> > On Wed, Jun 15, 2011 at 10:18:58AM +0200, Tejun Heo wrote:
> > > No human being can feel 120usec difference and I can't see how us=
ing
> > > HIGHPRI is justified here (which is what the code is doing
> > > _accidentally_ by using singlethread_workqueue).
> >=20
> > Ooh, one more thing, and even if you insist on using HIGHPRI (pleas=
e
> > don't), you don't need to create workqueue for each device.  You ca=
n
> > just create one for the whole driver in init and destroy it from ex=
it.
> > What matters is the HIGHPRI attribute of the workqueue.  The number=
 of
> > workqueues is completely irrelevant.
>=20
> Fair enough.
> I'll move to create_workqueue.

I suppose you meant alloc_workqueue()? :)

Sorry about the confusing names, I'm still in the (slow) process of
deprecating older APIs.

Thanks.

--=20
tejun
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
