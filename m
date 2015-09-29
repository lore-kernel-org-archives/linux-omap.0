From: Lokesh Vutla <a0131933@ti.com>
Subject: Re: [PATCH v3 0/3] ARM: OMAP2+: hwmod: RTC: Add lock and unlock hooks
Date: Tue, 29 Sep 2015 09:23:48 +0530
Message-ID: <560A0B4C.90206@ti.com>
References: <1437657946-10733-1-git-send-email-lokeshvutla@ti.com>
 <55DE9055.4090701@ti.com> <56037FEA.5070807@ti.com>
 <alpine.DEB.2.02.1509280822250.7947@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <alpine.DEB.2.02.1509280822250.7947@utopia.booyaka.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Lokesh Vutla <lokeshvutla@ti.com>, nsekhar@ti.com, t-kristo@ti.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Paul,

On Monday 28 September 2015 10:05 PM, Paul Walmsley wrote:
> On Thu, 24 Sep 2015, Lokesh Vutla wrote:
> =

>> On Thursday 27 August 2015 09:51 AM, Lokesh Vutla wrote:
>>> On Thursday 23 July 2015 06:55 PM, Lokesh Vutla wrote:
>>>> This series implements lock and unlock functions for RTC and hooks
>>>> the same to DRA7 and AMx3xx hwmod.
>>>> This is dependent on the patch https://patchwork.kernel.org/patch/6578=
281/,
>>>> which is queued recently by Paul.
>>> Gentle ping on this series.
>> Do you have any comments on this series?
> =

> Looks pretty good.  I'm slightly concerned about the latency jitter impac=
t =

> on -rt kernels for that local_irq_disable() section.  Looks like it could =

> hold off interrupts for ~(50 udelay =B5s) + 50*((RTC register read time) =
+ =

> 1).  But I'm not sure if preempt_enable/disable() is a good alternative =

> since a bunch of interrupt top halves could conceivably run after the RTC =

> goes non-busy and result in the RTC not being locked/unlocked. =

Agree.

> =

> Is there an RTC IP block register that the code can read, or a safe =

> sequence that the code can execute, after the RTC lock/unlock operation t=
o =

> verify that the RTC has successfully been locked or unlocked?  If so then =

> it's probably worth converting the local_irq_disable/enable() to =

> preempt_disable/enable() and testing that, then retrying the lock/unlock =

> if it fails.
I am afraid there is no such register to verify lock or unlock. Also
these KICK registers are Write only registers so can't read back the
value. Even the driver implement the same api's for writing into registers.

One thing I can think of is that to write a known pattern to scratch pad
register and read back the value to confirm if it is locked/unlocked.
But don't think this is a good approach.

Thanks and regards,
Lokesh
