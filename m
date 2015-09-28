From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v3 0/3] ARM: OMAP2+: hwmod: RTC: Add lock and unlock hooks
Date: Mon, 28 Sep 2015 16:35:51 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1509280822250.7947@utopia.booyaka.com>
References: <1437657946-10733-1-git-send-email-lokeshvutla@ti.com>
 <55DE9055.4090701@ti.com> <56037FEA.5070807@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED;
 BOUNDARY="843723315-1966970628-1443458151=:19891"
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <56037FEA.5070807@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lokesh Vutla <a0131933@ti.com>
Cc: Lokesh Vutla <lokeshvutla@ti.com>, nsekhar@ti.com, t-kristo@ti.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--843723315-1966970628-1443458151=:19891
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 24 Sep 2015, Lokesh Vutla wrote:

> On Thursday 27 August 2015 09:51 AM, Lokesh Vutla wrote:
> > On Thursday 23 July 2015 06:55 PM, Lokesh Vutla wrote:
> >> This series implements lock and unlock functions for RTC and hooks
> >> the same to DRA7 and AMx3xx hwmod.
> >> This is dependent on the patch https://patchwork.kernel.org/patch/6578=
281/,
> >> which is queued recently by Paul.
> > Gentle ping on this series.
> Do you have any comments on this series?

Looks pretty good.  I'm slightly concerned about the latency jitter impact=
=20
on -rt kernels for that local_irq_disable() section.  Looks like it could=
=20
hold off interrupts for ~(50 udelay =B5s) + 50*((RTC register read time) +=
=20
1).  But I'm not sure if preempt_enable/disable() is a good alternative=20
since a bunch of interrupt top halves could conceivably run after the RTC=
=20
goes non-busy and result in the RTC not being locked/unlocked. =20

Is there an RTC IP block register that the code can read, or a safe=20
sequence that the code can execute, after the RTC lock/unlock operation to=
=20
verify that the RTC has successfully been locked or unlocked?  If so then=
=20
it's probably worth converting the local_irq_disable/enable() to=20
preempt_disable/enable() and testing that, then retrying the lock/unlock=20
if it fails.


- Paul
--843723315-1966970628-1443458151=:19891
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--843723315-1966970628-1443458151=:19891--
