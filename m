From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 1/3] ARM: OMAP2+: 32k-counter: Use hwmod lookup to	check
 presence of 32k timer
Date: Tue, 10 Apr 2012 05:42:54 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83184D9D2@DBDE01.ent.ti.com>
References: <CACVXFVMjSPhF_+CfbF2vD5ts+WtZGjofEWmknB0D1OpTM7geZw@mail.gmail.com>
 <CAMQu2gyEUhDyyng+_oC5NpXHzWMaTGsnCSTTZcMUi2pLV0z8RQ@mail.gmail.com>
 <87sjgmt211.fsf@ti.com>
 <79CD15C6BA57404B839C016229A409A8318461E8@DBDE01.ent.ti.com>
 <CAMQu2gxuFsovKTPK8wFOO8vMeiyMFnTqNDRZYgAcCsVWytpOTA@mail.gmail.com>
 <79CD15C6BA57404B839C016229A409A83184846A@DBDE01.ent.ti.com>
 <20120405095221.GC25053@n2100.arm.linux.org.uk>
 <79CD15C6BA57404B839C016229A409A831848621@DBDE01.ent.ti.com>
 <87hawxkgoi.fsf@ti.com>
 <79CD15C6BA57404B839C016229A409A831849432@DBDE01.ent.ti.com>
 <20120406180452.GB15734@atomide.com>
 <79CD15C6BA57404B839C016229A409A83184ABEF@DBDE01.ent.ti.com>
 <4F83440E.70502@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4F83440E.70502@ti.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Hunter, Jon" <jon-hunter@ti.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "Cousson,
 Benoit" <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Ming Lei <tom.leiming@gmail.com>, "Balbi, Felipe" <balbi@ti.com>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "Shilimkar,
 Santosh" <santosh.shilimkar@ti.com>, "johnstul@us.ibm.com" <johnstul@us.ibm.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "DebBarma,
 Tarun Kanti" <tarun.kanti@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Apr 10, 2012 at 01:48:22, Hunter, Jon wrote:
> Hi Vaibhav,
> 
> On 04/09/2012 01:19 AM, Hiremath, Vaibhav wrote:
> 
> [...]
> 
> > Let me summarize it here again,
> >
> > Currently, the timer code is using config option CONFIG_OMAP_32K_TIMER,
> > to choose between 32ksync counter and gptimer; it is compile time option.
> > If user wants to use gptimer for HR ticks, he must build the kernel without
> > CONFIG_OMAP_32K_TIMER option.
> >
> > AM335x family of devices doesn't have 32ksync_counter available, only option
> > here is to use gptimer for kernel clocksource and clockevents.
> >
> > So in order to support, multi-omap build including devices like AM335x, we
> > must get rid of this option CONFIG_OMAP_32K_TIMER, atleast from clocksource
> > registration perspective.
> >
> > So that means, we need to have some mechanism to handle or detect available
> > clocksource runtime. Options would be,
> >
> >   - Use HWMOD to detect availability of 32ksync_counter, else fallback
> >     to gptimer. [This was my original patch]
> >
> >     But this restricts the use of gptimer completely on omap architecture,
> >     where we have 32ksync counter module.
> 
> True, but we would always want to use the 32k timer if CONFIG_PM is 
> specified. So what I am saying is that if a device has a 32ksync timer 
> and CONFIG_PM is defined, we always want to use the 32ksync timer and a 
> gptimer should never be used.
> 
> So we should/must restrict the use of a gptimer is CONFIG_PM is enabled 
> for devices that have the 32ksync timer.
> 
> >   - So the next solution is to still keep compile time option, so that user
> >     will get to use gptimer atleast just changing the kernel config option.
> >
> >     But, still, this is going to be kernel rebuild.
> >
> >   - Next option came up was, register both the timers and override using
> >     kernel parameter.
> >
> >     This will work only if, both the timers run at same rate/frequency; since
> >     we have one more layer here setup_sched_clock(), which actually can be
> >     called only once.
> >
> >   - Next option suggested by Santosh, is to use kernel parameter as in parse
> >     it early, to make decision on if user wants to override default
> >     clocksource (32ksync)
> >
> >     This is something will work for us and solves all above issues.
> 
> What happens if PM is enabled? Can you still override the default? I 
> don't think this should be allowed for devices with a 32ksync timer.
> 

If user is overriding it explicitly, that itself means he knows what he
is doing here. I too much to ask for...and unnecessary thing or expectation
from SW.

Thanks,
Vaibhav
