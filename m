From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 3/3] OMAP: hwmod: Force a softreset during _setup
Date: Mon, 23 Aug 2010 15:57:19 +0200
Message-ID: <4C727E3F.7060502@ti.com>
References: <1280959968-23933-1-git-send-email-b-cousson@ti.com> <1280959968-23933-4-git-send-email-b-cousson@ti.com> <B85A65D85D7EB246BE421B3FB0FBB59301E81E9434@dbde02.ent.ti.com> <4C6BF591.1010007@ti.com> <B85A65D85D7EB246BE421B3FB0FBB59301E82ACD94@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47854 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751993Ab0HWN51 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Aug 2010 09:57:27 -0400
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301E82ACD94@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Basak, Partha" <p-basak2@ti.com>
Cc: "Nayak, Rajendra" <rnayak@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "paul@pwsan.com" <paul@pwsan.com>, "Guruswamy, Senthilvadivu" <svadivu@ti.com>

Hi Partha,

Here is a small patch that should fix that issue:
The approach is quite basic, I'm just enabling all the optional clocks 
if the flag is set.

Could you give it a try?

Thanks,
Benoit


---
 From 37cda332362d58e584cf3df190a9dceb9c9db8ab Mon Sep 17 00:00:00 2001
From: Benoit Cousson <b-cousson@ti.com>
Date: Mon, 23 Aug 2010 15:45:24 +0200
Subject: [PATCH] OMAP: hwmod: Fix softreset for modules with optional clocks

Some modules (like GPIO, DSS...) require optionals clock to be enabled
in order to complete the sofreset properly.
Add a HWMOD_CONTROL_OPT_CLKS_IN_RESET flag to force all optional clocks
to be enabled before reset. Disabled them once the reset is done.

Reported-by: Partha Basak <p-basak2@ti.com>
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
  arch/arm/mach-omap2/omap_hwmod.c |   53 
+++++++++++++++++++++++++++++++++----
  1 files changed, 47 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c 
b/arch/arm/mach-omap2/omap_hwmod.c
index 9bd99ad..5466c30 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -545,6 +545,36 @@ static int _disable_clocks(struct omap_hwmod *oh)
  	return 0;
  }

+static void _enable_optional_clocks(struct omap_hwmod *oh)
+{
+	struct omap_hwmod_opt_clk *oc;
+	int i;
+
+	pr_debug("omap_hwmod: %s: enabling optional clocks\n", oh->name);
+
+	for (i = oh->opt_clks_cnt, oc = oh->opt_clks; i > 0; i--, oc++)
+		if (oc->_clk) {
+			pr_debug("omap_hwmod: enable %s:%s\n", oc->role,
+				   oc->_clk->name);
+			clk_enable(oc->_clk);
+		}
+}
+
+static void _disable_optional_clocks(struct omap_hwmod *oh)
+{
+	struct omap_hwmod_opt_clk *oc;
+	int i;
+
+	pr_debug("omap_hwmod: %s: disabling optional clocks\n", oh->name);
+
+	for (i = oh->opt_clks_cnt, oc = oh->opt_clks; i > 0; i--, oc++)
+		if (oc->_clk) {
+			pr_debug("omap_hwmod: disable %s:%s\n", oc->role,
+				   oc->_clk->name);
+			clk_disable(oc->_clk);
+		}
+}
+
  /**
   * _find_mpu_port_index - find hwmod OCP slave port ID intended for 
MPU use
   * @oh: struct omap_hwmod *
@@ -845,8 +875,9 @@ static int _wait_target_ready(struct omap_hwmod *oh)
   */
  static int _reset(struct omap_hwmod *oh)
  {
-	u32 r, v;
+	u32 v;
  	int c = 0;
+	int ret = 0;

  	if (!oh->class->sysc ||
  	    !(oh->class->sysc->sysc_flags & SYSC_HAS_SOFTRESET) ||
@@ -860,12 +891,16 @@ static int _reset(struct omap_hwmod *oh)
  		return -EINVAL;
  	}

-	pr_debug("omap_hwmod: %s: resetting\n", oh->name);
+	/* For some modules, all optionnal clocks need to be enabled as well */
+	if (oh->flags & HWMOD_CONTROL_OPT_CLKS_IN_RESET)
+		_enable_optional_clocks(oh);
+
+	pr_debug("omap_hwmod: %s: resetting\n", oh->name);

  	v = oh->_sysc_cache;
-	r = _set_softreset(oh, &v);
-	if (r)
-		return r;
+	ret = _set_softreset(oh, &v);
+	if (ret)
+		goto dis_opt_clks;
  	_write_sysconfig(v, oh);

  	omap_test_timeout((omap_hwmod_readl(oh, oh->class->sysc->syss_offs) &
@@ -883,7 +918,13 @@ static int _reset(struct omap_hwmod *oh)
  	 * _wait_target_ready() or _reset()
  	 */

-	return (c == MAX_MODULE_RESET_WAIT) ? -ETIMEDOUT : 0;
+	ret = (c == MAX_MODULE_RESET_WAIT) ? -ETIMEDOUT : 0;
+
+dis_opt_clks:
+	if (oh->flags & HWMOD_CONTROL_OPT_CLKS_IN_RESET)
+		_disable_optional_clocks(oh);
+
+	return ret;
  }

  /**
-- 
1.6.0.4


On 8/19/2010 1:57 PM, Basak, Partha wrote:
>> From: Cousson, Benoit
>> Sent: Wednesday, August 18, 2010 8:31 PM
>>
>> Hi Partha,
>>
>> On 8/17/2010 2:46 PM, Basak, Partha wrote:
>>>
>>>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>>>> owner@vger.kernel.org] On Behalf Of Cousson, Benoit
>>>> Sent: Thursday, August 05, 2010 3:43 AM
>>>>
>>>> Force the softreset of every IPs during the _setup phase.
>>>> IPs that cannot support softreset or that should not
>>>> be reset must set the HWMOD_INIT_NO_RESET flag in the
>>>> hwmod struct.
>>>>
>>>> Signed-off-by: Benoit Cousson<b-cousson@ti.com>
>>>> Cc: Paul Walmsley<paul@pwsan.com>
>>>> Cc: Kevin Hilman<khilman@deeprootsystems.com>
>>>> ---
>>>>    arch/arm/mach-omap2/omap_hwmod.c |   17 ++++++++---------
>>>>    1 files changed, 8 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-
>>>> omap2/omap_hwmod.c
>>>> index 53b08e3..91ad9c6 100644
>>>> --- a/arch/arm/mach-omap2/omap_hwmod.c
>>>> +++ b/arch/arm/mach-omap2/omap_hwmod.c
>>>> @@ -856,8 +856,8 @@ static int _reset(struct omap_hwmod *oh)
>>>>
>>>>    	/* clocks must be on for this operation */
>>>>    	if (oh->_state != _HWMOD_STATE_ENABLED) {
>>>> -		WARN(1, "omap_hwmod: %s: reset can only be entered from "
>>>> -		     "enabled state\n", oh->name);
>>>> +		pr_warning("omap_hwmod: %s: reset can only be entered from "
>>>> +			   "enabled state\n", oh->name);
>>>>    		return -EINVAL;
>>>>    	}
>>>>
>>>> @@ -874,8 +874,8 @@ static int _reset(struct omap_hwmod *oh)
>>>>    			  MAX_MODULE_RESET_WAIT, c);
>>>>
>>>>    	if (c == MAX_MODULE_RESET_WAIT)
>>>> -		WARN(1, "omap_hwmod: %s: failed to reset in %d usec\n",
>>>> -		     oh->name, MAX_MODULE_RESET_WAIT);
>>>> +		pr_warning("omap_hwmod: %s: failed to reset in %d usec\n",
>>>> +			   oh->name, MAX_MODULE_RESET_WAIT);
>>>
>>> http://focus.ti.com/pdfs/wtbu/SWPU177B_FinalEPDF_12_04_2009.pdf
>>>
>>> This is leading to the above warning for DSS on OMAP3430/3630. Referring
>> to the reference manual (7.5.1 Display Subsystem Reset), successful reset
>> of DSS would need PRCM.CM_FCLKEN_DSS[2] EN_TV bit set to 1. For DSS, even
>> though TV clock is an optional clock, this is mandatory for successful DSS
>> reset. We could ignore this warning, or possibly WA it.
>>> One way could be:
>>>
>>> 1. In the database, have HWMOD_INIT_NO_RESET flag set so that _setup()
>> skips reset.
>>>
>>> 2. After omap device build of DSS is done, lookup the opt-clock and
>> enable it (using clock framework).
>>>
>>>
>>> 4. Then do DSS reset again calling omap_device_reset().
>>>
>>> All IPs that potentially have any special soft-reset sequence will need
>> customized handling. Should we keep the framework light and handle such
>> special cases in the drivers? In that case, the framework need not throw
>> up a warning. Please comment.
>>
>> If the softreset is not mandatory for an IP like DSS, you just have to
>> set this HWMOD_INIT_NO_RESET flag.
>> There is no need to use the softreset for every IP, the PRCM already
>> resets every IPs each time the power domain is powered on.
>> softreset is useful if you need to recover from an HW error.
>>
>
> I agree, however without doing soft-reset, we have observed DSI malfunction. Senthil can provide more details. As DSS needs TV_clk for successful reset, I doubt whether PRCM can reset DSS once we merely turn on the DSS power domain.
> So, it really depends on the IP in question. If it is necessary, we will do a omap_device_reset()in the driver. Correct?
>
>> Regards,
>> Benoit

