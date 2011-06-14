From: Tejun Heo <tj@kernel.org>
Subject: Re: Re: Re: [PATCH v4 11/18] input: Add initial support for TWL6040
 vibrator
Date: Tue, 14 Jun 2011 09:31:30 +0200
Message-ID: <20110614073130.GF8141@htj.dyndns.org>
References: <1307706876-4768-1-git-send-email-peter.ujfalusi@ti.com>
 <20110613212028.GA13138@core.coreip.homeip.net>
 <20110614063400.GB8141@htj.dyndns.org>
 <8556714.NHVg2d8yTv@barack>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8556714.NHVg2d8yTv@barack>
Sender: linux-input-owner@vger.kernel.org
To: =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Girdwood, Liam" <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Samuel Ortiz <sameo@linux.intel.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Lopez Cruz, Misael" <misael.lopez@ti.com>
List-Id: linux-omap@vger.kernel.org

Hello,

On Tue, Jun 14, 2011 at 10:17:10AM +0300, P=E9ter Ujfalusi wrote:
> The latency in most cases comes from the fact, that we are running an=
 embedded=20
> system. Number of peripherals are connected via I2C, these drivers ar=
e using=20
> workqueues to communicate with the IC.
> Since only one device can communicate through I2C at the time. This i=
s=20
> basically the source of the latency. It does not really matter, if th=
e devices=20
> are on the same I2C bus or not, it is enough if two work belonging to=
 device,=20
> which happens to be on the same I2C bus, and the first work in the qu=
eue takes=20
> long time to complete (reading back bigger chunk of info, configuring=
, etc).
> Even if we could schedule the second work on the other CPU, it will b=
e put=20
> waiting till the I2C bus is free, so both CPU core has work assigned,=
 the=20
> first is keeping the I2C bus, the other waits for the I2C bus, and th=
e third=20
> is waiting to be scheduled (which will be happening, when the first w=
ork=20
> finished).
> IMHO the tactile feedback (vibra) should have an excuse to have separ=
ate WQ to=20
> avoid latency spikes.
> I agree, that most cases we can use the global wq.

Thanks for the explanation.  I have a couple more questions.

* While transferring data from I2C, I suppose the work item is fully
  occupying the CPU?  If so, how long delay are we talking about?
  Millisecs?

* You said that the if one task is accessing I2C bus, the other would
  wait even if scheduled on a different CPU.  Is access to I2C bus
  protected with a spinlock?

Also, as it's currently implemented, single threaded wq's effectively
bypass concurrency level control.  This is an implementation detail
which may change in the future, so even if you're seeing lower latency
by using a separate single threaded wq, it's an accident and if you
require lower latency you should be expressing the requirement
explicitly.

Thank you.

--=20
tejun
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
