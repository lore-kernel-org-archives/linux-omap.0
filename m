From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v4 11/18] input: Add initial support for
	TWL6040 vibrator
Date: Tue, 14 Jun 2011 10:17:10 +0300
Message-ID: <8556714.NHVg2d8yTv@barack>
References: <1307706876-4768-1-git-send-email-peter.ujfalusi@ti.com>
	<20110613212028.GA13138@core.coreip.homeip.net>
	<20110614063400.GB8141@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20110614063400.GB8141@htj.dyndns.org>
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

On Tuesday 14 June 2011 08:34:00 Tejun Heo wrote:
> Yeap, using a separate workqueue doesn't do anything for latency
> unless WQ_HIGHPRI and/or WQ_CPU_INTENSIVE is used; however, _please_
> stay away from it unless absolutely sure it's necessary (ie. unless
> you can pin point to where latency is coming from - even in that case,
> the thing which induces the latency probably is the one which should
> be fixed).

The latency in most cases comes from the fact, that we are running an embed=
ded =

system. Number of peripherals are connected via I2C, these drivers are usin=
g =

workqueues to communicate with the IC.
Since only one device can communicate through I2C at the time. This is =

basically the source of the latency. It does not really matter, if the devi=
ces =

are on the same I2C bus or not, it is enough if two work belonging to devic=
e, =

which happens to be on the same I2C bus, and the first work in the queue ta=
kes =

long time to complete (reading back bigger chunk of info, configuring, etc).
Even if we could schedule the second work on the other CPU, it will be put =

waiting till the I2C bus is free, so both CPU core has work assigned, the =

first is keeping the I2C bus, the other waits for the I2C bus, and the thir=
d =

is waiting to be scheduled (which will be happening, when the first work =

finished).
IMHO the tactile feedback (vibra) should have an excuse to have separate WQ=
 to =

avoid latency spikes.
I agree, that most cases we can use the global wq.

> CMWQ is pretty good at keeping latency low unless something is
> consuming large amount of CPU cycles and those work items are marked
> WQ_CPU_INTENSIVE, not the other way around and WQ_HIGHPRI is for
> things like MCE error reporting.

So this is not really about CPU utilization, it is due to the wide variety =
of =

peripherals connected to an embedded system.

-- =

P=E9ter
