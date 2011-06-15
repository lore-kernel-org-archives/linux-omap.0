From: Tejun Heo <tj@kernel.org>
Subject: Re: Re: Re: Re: Re: [PATCH v4 11/18] input: Add initial support for
 TWL6040 vibrator
Date: Wed, 15 Jun 2011 10:18:58 +0200
Message-ID: <20110615081858.GM8141@htj.dyndns.org>
References: <1307706876-4768-1-git-send-email-peter.ujfalusi@ti.com>
 <4476185.bf2jyafmHt@barack>
 <20110614081836.GG8141@htj.dyndns.org>
 <100646074.zaKeYdXKr4@barack>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <100646074.zaKeYdXKr4@barack>
Sender: linux-input-owner@vger.kernel.org
To: =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Girdwood, Liam" <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Samuel Ortiz <sameo@linux.intel.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Lopez Cruz, Misael" <misael.lopez@ti.com>
List-Id: linux-omap@vger.kernel.org

Hello,

On Tue, Jun 14, 2011 at 01:22:45PM +0300, P=E9ter Ujfalusi wrote:
> However I did run a short experiments regarding to latencies:
> With create_singlethread_workqueue :
> Jun 14 12:54:30 omap-gentoo kernel: [  211.269531] vibra scheduling t=
ime: 30 usec
> Jun 14 12:54:30 omap-gentoo kernel: [  211.300811] vibra scheduling t=
ime: 30 usec
> Jun 14 12:54:33 omap-gentoo kernel: [  214.419006] vibra scheduling t=
ime: 31 usec
> Jun 14 12:54:34 omap-gentoo kernel: [  214.980987] vibra scheduling t=
ime: 30 usec
> Jun 14 12:54:35 omap-gentoo kernel: [  215.762115] vibra scheduling t=
ime: 30 usec
> Jun 14 12:54:35 omap-gentoo kernel: [  215.816650] vibra scheduling t=
ime: 30 usec
> Jun 14 12:54:35 omap-gentoo kernel: [  215.871337] vibra scheduling t=
ime: 61 usec
> Jun 14 12:54:35 omap-gentoo kernel: [  215.926025] vibra scheduling t=
ime: 61 usec
> Jun 14 12:54:35 omap-gentoo kernel: [  215.980743] vibra scheduling t=
ime: 61 usec
> Jun 14 12:54:35 omap-gentoo kernel: [  216.035430] vibra scheduling t=
ime: 61 usec
> Jun 14 12:54:38 omap-gentoo kernel: [  219.425659] vibra scheduling t=
ime: 31 usec
> Jun 14 12:54:40 omap-gentoo kernel: [  220.981658] vibra scheduling t=
ime: 31 usec
> Jun 14 12:54:44 omap-gentoo kernel: [  224.692504] vibra scheduling t=
ime: 30 usec
> Jun 14 12:54:44 omap-gentoo kernel: [  225.067138] vibra scheduling t=
ime: 30 usec
>=20
> With create_workqueue :
> Jun 14 12:05:00 omap-gentoo kernel: [  304.965393] vibra scheduling t=
ime: 183 usec
> Jun 14 12:05:01 omap-gentoo kernel: [  305.964996] vibra scheduling t=
ime: 61 usec
> Jun 14 12:05:03 omap-gentoo kernel: [  307.684082] vibra scheduling t=
ime: 152 usec
> Jun 14 12:05:06 omap-gentoo kernel: [  310.972778] vibra scheduling t=
ime: 30 usec
> Jun 14 12:05:08 omap-gentoo kernel: [  312.683715] vibra scheduling t=
ime: 61 usec
> Jun 14 12:05:10 omap-gentoo kernel: [  314.785675] vibra scheduling t=
ime: 183 usec
> Jun 14 12:05:15 omap-gentoo kernel: [  319.800903] vibra scheduling t=
ime: 61 usec
> Jun 14 12:05:16 omap-gentoo kernel: [  320.738403] vibra scheduling t=
ime: 30 usec
> Jun 14 12:05:16 omap-gentoo kernel: [  320.793090] vibra scheduling t=
ime: 61 usec
> Jun 14 12:05:16 omap-gentoo kernel: [  320.847778] vibra scheduling t=
ime: 61 usec
> Jun 14 12:05:16 omap-gentoo kernel: [  320.902465] vibra scheduling t=
ime: 61 usec
> Jun 14 12:05:16 omap-gentoo kernel: [  320.957153] vibra scheduling t=
ime: 61 usec
> Jun 14 12:05:16 omap-gentoo kernel: [  320.996185] vibra scheduling t=
ime: 31 usec
>=20
> This is in a system, where I do not have any other drivers on I2C bus=
, and I have
> generated some load with this command:
> grep -r generate_load /*
>=20
> So, I have some CPU, and IO load as well.
>=20
> At the end the differences are not that big, but with create_singleth=
read_workqueue
> I can see less spikes.
>=20
> This is with 3.0-rc2 kernel
>=20
> I still think, that there is a place for the create_singlethread_work=
queue, and the
> tactile feedback needs such a thing.

So, yes, WQ_HIGHPRI would make difference in latency but as can be
seen above in usecs range not msecs range and you're trading off batch
execution and processing locality for it.

> As I recall correctly this was the reason to use create_singlethread_=
workqueue
> in the twl4030-vibra driver as well (there were latency issues withou=
t it).

Before cmwq, the latency which can be induced by using system
workqueue can be easily upto seconds range.  With cmwq, it should be
in the usecs to few millisecs range.  If that's not enough, the use
case probably calls for dedicated RT thread or threaded IRQ handler.

No human being can feel 120usec difference and I can't see how using
HIGHPRI is justified here (which is what the code is doing
_accidentally_ by using singlethread_workqueue).

Thank you.

--=20
tejun
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
