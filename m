From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH-V3 2/4] arm:omap:am33xx: Update common OMAP machine
	specific sources
Date: Fri, 30 Sep 2011 10:09:03 -0700
Message-ID: <87ehyyj6ts.fsf@ti.com>
References: <hvaibhav@ti.com>
	<1316529142-27564-3-git-send-email-hvaibhav@ti.com>
	<87fwjjcfbt.fsf@ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB5930257840691@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB5930257840691@dbde02.ent.ti.com>
	(Sanjeev Premi's message of "Fri, 30 Sep 2011 17:39:27 +0530")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "paul@pwsan.com" <paul@pwsan.com>, "tony@atomide.com" <tony@atomide.com>, "Mohammed, Afzal" <afzal@ti.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

"Premi, Sanjeev" <premi@ti.com> writes:

>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org 
>> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Hilman, Kevin
>> Sent: Tuesday, September 27, 2011 12:16 AM
>> To: Hiremath, Vaibhav
>> Cc: linux-omap@vger.kernel.org; paul@pwsan.com; 
>> tony@atomide.com; linux-arm-kernel@lists.infradead.org; 
>> Mohammed, Afzal
>> Subject: Re: [PATCH-V3 2/4] arm:omap:am33xx: Update common 
>> OMAP machine specific sources
>> 
>> <hvaibhav@ti.com> writes:
>> 
>> > From: Afzal Mohammed <afzal@ti.com>
>> >
>> > This patch updates the common machine specific source files for
>> > support for AM33XX/AM335x with cpu type, macros for 
>> identification of
>> > AM33XX/AM335X device.
>> >
>> > Signed-off-by: Afzal Mohammed <afzal@ti.com>
>> > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
>> 
>> [...]
>> 
>> > @@ -3576,7 +3579,8 @@ int __init omap3xxx_clk_init(void)
>> >  	 * Lock DPLL5 -- here only until other device init code can
>> >  	 * handle this
>> >  	 */
>> > -	if (!cpu_is_ti816x() && (omap_rev() >= OMAP3430_REV_ES2_0))
>> > +	if (!cpu_is_ti816x() && !cpu_is_am33xx() &&
>> > +			(omap_rev() >= OMAP3430_REV_ES2_0))
>> >  		omap3_clk_lock_dpll5();
>> 
>> This is getting ugly.  
>> 
>> Instead of continuing to expand this if-list, I think it's time for a
>> new feature-flag for whether or not an SoC has DPLL5 instead.
>
> I agree that the code is really getting ugly here. But, isn't
> feature-flag going to be over-used with this and similar features?
>
> Just thinking ahead, for these possible cases:
> 1) An soc adds DPLL6.
> 2) An soc uses DPLL5, but mechanism to lock is different.

You're right.

> Wouldn't it be better to have a scheme like this:
> 1) Define a simple structure for DPLLs.
> 2) Initialize the unused DPLLs to be null/ -1 early
>    in arch/soc specific init.
> 3) The DPLL functions check for corresponding flag on
>    entry.

Actually, looking at this closer, I think the infrastructure is already
there to handle this cleanly.

Basically, dpll5 should not even be registered for SoCs where it doesn't
exist.  Then, any attempts to use DPLL5 would know it doesn't exist
because the call to clk_get() in omap3_clk_lock_dpll5() would fail.

I think the clock3xxx_data.c needs a bit more cleanup so that only
clocks that exist for a given SoC are registered.

Paul already did a similar cleanup for the powerdomain data files by
creating separate lists for common ones and unique ones.  Looks like we
need the same for the clock data.

Patches welcome.

Kevin
