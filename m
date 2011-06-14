From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v4 11/18] input: Add initial support for
	TWL6040 vibrator
Date: Tue, 14 Jun 2011 10:51:35 +0300
Message-ID: <4476185.bf2jyafmHt@barack>
References: <1307706876-4768-1-git-send-email-peter.ujfalusi@ti.com>
	<8556714.NHVg2d8yTv@barack> <20110614073130.GF8141@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20110614073130.GF8141@htj.dyndns.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tejun Heo <tj@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "Lopez Cruz, Misael" <misael.lopez@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Girdwood, Liam" <lrg@ti.com>
List-Id: linux-omap@vger.kernel.org

On Tuesday 14 June 2011 09:31:30 Tejun Heo wrote:
> Thanks for the explanation.  I have a couple more questions.
> =

> * While transferring data from I2C, I suppose the work item is fully
>   occupying the CPU?

Not exactly on OMAP platforms at least. We do not have busy looping in low =

level driver (we wait with wait_for_completion_timeout for the transfer to =
be =

done), so scheduling on the same CPU can be possible.

>   If so, how long delay are we talking about?
>   Millisecs?

It is hard to predict, but it can be few tens of ms for one device, if we h=
ave =

several devices on the same bus (which we tend to have), and they want to =

read/write something at the same time we can see hundred(s) ms in total - i=
t =

is rare to happen, and hard to reproduce, but it does happen for sure.
 =

> * You said that the if one task is accessing I2C bus, the other would
>   wait even if scheduled on a different CPU.  Is access to I2C bus
>   protected with a spinlock?

At the bottom it is using rt_mutex_lock/unlick to protect the bus.
And yes, the others need to wait till the ongoing transfer has been finishe=
d.
 =

> Also, as it's currently implemented, single threaded wq's effectively
> bypass concurrency level control.  This is an implementation detail
> which may change in the future, so even if you're seeing lower latency
> by using a separate single threaded wq, it's an accident and if you
> require lower latency you should be expressing the requirement
> explicitly.

I see, do you have suggestion to which would be best for this kind of =

scenarios.
In most cases global wq would be OK for this, but time-to-time we face with =

sudden latency spikes, which makes the user experience really bad.
Currently with singlethreaded wq we can avoid these spikes.

Thank you, =

P=E9ter
