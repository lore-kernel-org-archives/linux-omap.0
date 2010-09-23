From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 03/10] OMAP3: PM: move device-specific special cases from
	PM core into CPUidle
Date: Thu, 23 Sep 2010 16:47:31 -0700
Message-ID: <87eickowdo.fsf@deeprootsystems.com>
References: <1284594946-28963-1-git-send-email-khilman@deeprootsystems.com>
	<1284594946-28963-4-git-send-email-khilman@deeprootsystems.com>
	<alpine.DEB.2.00.1009210147180.17727@utopia.booyaka.com>
	<878w2vkp65.fsf@deeprootsystems.com>
	<alpine.DEB.2.00.1009231709000.10678@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <alpine.DEB.2.00.1009231709000.10678@utopia.booyaka.com> (Paul
	Walmsley's message of "Thu, 23 Sep 2010 17:25:26 -0600 (MDT)")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tero Kristo <tero.kristo@nokia.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Paul Walmsley <paul@pwsan.com> writes:

> Hi Kevin
>
> On Tue, 21 Sep 2010, Kevin Hilman wrote:
>
>> Paul Walmsley <paul@pwsan.com> writes:
>> 
>> > On Wed, 15 Sep 2010, Kevin Hilman wrote:
>> >
>> >> In an effort to simplify the core idle path, move any device-specific
>> >> special case handling from the core PM idle path into the CPUidle
>> >> pre-idle checking path.
>> >
>> > As with the original patch, I don't quite understand the improvement 
>> > here.  In particular, this part:
>> >
>> >> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
>> >> index 3d3d035..0923b82 100644
>> >> --- a/arch/arm/mach-omap2/cpuidle34xx.c
>> >> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
>> >> @@ -233,14 +234,54 @@ static int omap3_enter_idle_bm(struct cpuidle_device *dev,
>> >>  			       struct cpuidle_state *state)
>> >>  {
>> >>  	struct cpuidle_state *new_state = next_valid_state(dev, state);
>> >> +	u32 core_next_state, per_next_state = 0, per_saved_state = 0;
>> >> +	u32 cam_state;
>> >> +	struct omap3_processor_cx *cx;
>> >> +	int ret;
>> >>  
>> >>  	if ((state->flags & CPUIDLE_FLAG_CHECK_BM) && omap3_idle_bm_check()) {
>> >>  		BUG_ON(!dev->safe_state);
>> >>  		new_state = dev->safe_state;
>> >> +		goto select_state;
>> >> +	}
>> >> +
>> >> +	cx = cpuidle_get_statedata(state);
>> >> +	core_next_state = cx->core_state;
>> >> +
>> >> +	/*
>> >> +	 * Prevent idle completely if CAM is active.
>> >> +	 * CAM does not have wakeup capability in OMAP3.
>> >> +	 */
>> >> +	cam_state = pwrdm_read_pwrst(cam_pd);
>> >> +	if (cam_state == PWRDM_POWER_ON) {
>> >> +		new_state = dev->safe_state;
>> >> +		goto select_state;
>> >>  	}
>> >>  
>> >> +	/*
>> >> +	 * Prevent PER off if CORE is not in retention or off as this
>> >> +	 * would disable PER wakeups completely.
>> >> +	 */
>> >> +	per_next_state = per_saved_state = pwrdm_read_next_pwrst(per_pd);
>> >> +	if ((per_next_state == PWRDM_POWER_OFF) &&
>> >> +	    (core_next_state > PWRDM_POWER_RET)) {
>> >> +		per_next_state = PWRDM_POWER_RET;
>> >> +		pwrdm_set_next_pwrst(per_pd, per_next_state);
>> >> +	}
>> >> +
>> >> +	/* Are we changing PER target state? */
>> >> +	if (per_next_state != per_saved_state)
>> >> +		pwrdm_set_next_pwrst(per_pd, per_next_state);
>> >
>> > In this case, the PER / CORE constraints don't have anything to do with 
>> > the MPU or CPUIdle, so they don't seem to belong in the CPUIdle code.  The 
>> > extra comments are certainly nice -- they make it more clear as to what is 
>> > going on here -- but maybe those can just be added to pm34xx.c ?
>> 
>> CPUidle currently manages MPU and CORE powerdomains, so the CORE
>> constraints seem to make perfect sense here (at least to me.)
>
> I do mean CORE also -- basically, anything that is not the CPU.  IMHO 
> CPUIdle shouldn't manage CORE directly since it's not part of the CPU.  
> Also since OMAPs have other processors (e.g., DSP, DMA, etc) that can use 
> the CORE independently of the CPU's power state, it doesn't make sense for 
> that code to live inside CPUIdle -- probably it should live in some type 
> of SystemIdle, CORE powerdomain idle or L3 idle.  Again IMHO, the C states 
> should only represent the MPU's idle state.
>
>> The question is probably more about the PER constraints.
>> 
>> The basic goal of this is to streamline the core idle (omap_sram_idle())
>> to be the minimum streamline idle, and to move all the constraint
>> checking and activity checking to higher layers (like CPUidle.)
>> Specifically, I'm working towards moving the device-specific idle
>> constraints out of the core idle path (omap_sram_idle()) and move them
>> into higher layers where we're checking for activity etc.
>> 
>> This is just a baby step towards moving the device-idle out of CPUidle
>> completely to a place where it can be managed by the driver themeselves
>> using runtime PM or by using constraints instead of these hard-coded
>> hacks.
>
> I agree completely with the goal; it's the implementation that I don't 
> like ;-)  But if you agree with the basic idea, that CORE / PER / 
> whatever-idle should ultimately go elsewhere, since I don't have time to 
> come up with a constructive alternative at the moment, would you be 
> willing to just drop a FIXME comment in that code, near the CAM and the 
> PER / CORE stuff, that mentions that that code should ultimately be 
> segmented out into its own idle code?

Absolutely...  will do.

Kevin
