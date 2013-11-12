From: Joel Fernandes <joelf@ti.com>
Subject: [RFC] Refactoring and moving dmtimer code
Date: Mon, 11 Nov 2013 18:41:06 -0600
Message-ID: <52817922.8070408@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Nishanth Menon <nm@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Sricharan R <r.sricharan@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Rajendra Nayak <rnayak@ti.com>, Sekhar Nori <nsekhar@ti.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi Thomas and everyone,

I'm currently trying to refactor our dmtimer code in various ways and there are
different challenges in doing so, some goals are shorterm and others long term,
but I need some guidance so that I can do things the right way to begin with.

I wanted to start a discussion on what needs to be done, and sort of track
what's blocking us and establish certain guidelines/recommendations before
starting to do things etc.

(1)
With ARCH_MULTIPLATFORM turned on, arch/arm/plat-*/include/plat/ is no longer
accessible to drivers/. Due to this, all such drivers that need direct access to
a *specific* dmtimer don't work and are disabled:
drivers/media/rc/ir-rx51.c and
drivers/staging/tidspbridge/core/dsp-clock.c

We're also going to be having mailbox code needing dedicated timers at some point.

So as a first step, I'd like to split dmtimer.h
(arch/arm/plat-omap/include/plat/dmtimer.h) into a public header.

The header currently consists of 2 parts, First part is mostly "private" where
__omap_dmtimer functions are defined, which should really not be accessible to
users of the dmtimer API. Second mostly would be the public dmtimer API which
*should* be public so that drivers that need it are not disabled with
ARCH_MULTIPLATFORM.

Could you suggest a good place for this header? I'd like to split this header
and expose a second "dmtimer.h" in a suitable include directory.

(2)
Moving of dmtimer.c code out of plat-omap into a suitable drivers/ directory

This could be the next step where we move dmtimer.c into a suitable place other
than arch/arm/plat-omap/.
The public dmtimer API will be declared through the above header. Drivers that
need specific timers such as DSP and mailbox can use it.

Though this part of the code would not deal with clocksource framework, does it
makes sense to move it into drivers/clocksource/? Any other suggestions?

(3)
Establish an omap clocksource driver in drivers/clocksource/

Currently all our system timer code resides in arch/arm/mach-omap2/timer.c, in
the long run I'd like to convert this to a clocksource driver. But currently the
code is a bit dependent and entangled with PM code (which we call hwmod). This
work may have to wait till hwmod cleanups can happen, that's why I'm keeping it
for last before we can finish with the baby steps. Suggestions are welcome here.

(2) and (3) can indeed be combined into a single driver even and placed in a
suitable location. But the big question I guess is, is drivers/clocksource/ the
right place.

Thanks in advance for your valuable guidance, looking forward to getting some
momentum with this work.

regards,

-Joel
