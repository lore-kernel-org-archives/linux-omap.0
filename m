From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v4 11/18] input: Add initial support for
	TWL6040 vibrator
Date: Fri, 17 Jun 2011 12:39:57 +0300
Message-ID: <5740779.B2nyl9oMW4@barack>
References: <1307706876-4768-1-git-send-email-peter.ujfalusi@ti.com>
	<20110616120244.GA2611@htj.dyndns.org> <4306005.scnJ1lQX4P@barack>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <4306005.scnJ1lQX4P@barack>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Tejun Heo <tj@kernel.org>, "Lopez Cruz, Misael" <misael.lopez@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Girdwood, Liam" <lrg@ti.com>
List-Id: linux-omap@vger.kernel.org

Hello Tejun,

On Thursday 16 June 2011 16:06:00 Ujfalusi, Peter wrote:
> > I suppose you meant alloc_workqueue()? :)
> =

> Oh, yes. I mean that.

Just avoid another series...
I have looked at the alloc_workqueue, and I'm not really sure what paramete=
rs =

should I use.
#define create_singlethread_workqueue(name)			\
	alloc_workqueue((name), WQ_UNBOUND | WQ_MEM_RECLAIM, 1)

I would use something like this instead of create_singlethread_workqueue:

alloc_workqueue("twl6040-vibra", WQ_UNBOUND | WQ_MEM_RECLAIM | WQ_HIGHPRI, =
1);

Is this correct?

Thanks,
P=E9ter
