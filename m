From: Tejun Heo <tj@kernel.org>
Subject: Re: Re: [alsa-devel] [PATCH v4 11/18] input: Add initial support for
 TWL6040 vibrator
Date: Fri, 17 Jun 2011 11:43:32 +0200
Message-ID: <20110617094332.GE2611@htj.dyndns.org>
References: <1307706876-4768-1-git-send-email-peter.ujfalusi@ti.com>
 <20110616120244.GA2611@htj.dyndns.org>
 <4306005.scnJ1lQX4P@barack>
 <5740779.B2nyl9oMW4@barack>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5740779.B2nyl9oMW4@barack>
Sender: linux-input-owner@vger.kernel.org
To: =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "Lopez Cruz, Misael" <misael.lopez@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Girdwood, Liam" <lrg@ti.com>
List-Id: linux-omap@vger.kernel.org

Hello, P=E9ter.

On Fri, Jun 17, 2011 at 12:39:57PM +0300, P=E9ter Ujfalusi wrote:
> Just avoid another series...
> I have looked at the alloc_workqueue, and I'm not really sure what pa=
rameters=20
> should I use.
> #define create_singlethread_workqueue(name)			\
> 	alloc_workqueue((name), WQ_UNBOUND | WQ_MEM_RECLAIM, 1)
>=20
> I would use something like this instead of create_singlethread_workqu=
eue:
>=20
> alloc_workqueue("twl6040-vibra", WQ_UNBOUND | WQ_MEM_RECLAIM | WQ_HIG=
HPRI, 1);

Just use the default params

	alloc_workqueue("twl6040-vibra", 0, 0);

Thanks.

--=20
tejun
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
