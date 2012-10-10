From: Omar Ramirez Luna <omar.luna@linaro.org>
Subject: Re: Issue with _are_all_hardreset_lines_asserted()
Date: Tue, 9 Oct 2012 21:21:10 -0500
Message-ID: <CALLhW=6oQHgYhZRPX2UvxS7ehrB+NoC01oYQnBkgriwVcAaoOw@mail.gmail.com>
References: <506D8C0E.8010600@ti.com>
	<alpine.DEB.2.00.1210090503470.5736@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:58613 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751607Ab2JJCVL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Oct 2012 22:21:11 -0400
Received: by mail-vc0-f174.google.com with SMTP id fo13so55583vcb.19
        for <linux-omap@vger.kernel.org>; Tue, 09 Oct 2012 19:21:10 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1210090503470.5736@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Archit Taneja <a0393947@ti.com>, hvaibhav@ti.com, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Rajendra Nayak <rnayak@ti.com>

Hi,

On 9 October 2012 00:38, Paul Walmsley <paul@pwsan.com> wrote:
> cc Vaibhav due to the AM33xx change
>
> Hi
>
> On Thu, 4 Oct 2012, Archit Taneja wrote:
>
>> I was trying out the linux-next kernel, and I noticed that DSS MODULEMODE bits
>> are never cleared.
>>
>> In _omap4_disable_module(), there is a check:
>>
>>       ...
>>
>>       if (!_are_all_hardreset_lines_asserted(oh))
>>               return 0;
>>
>>       /* MODULEMODE bits cleared here */
>>       ...
>>       ...
>>       ...
>>
>> The function _are_all_hardreset_lines_asserted() returns false if
>> 'oh->rst_lines_cnt == 0', so we bail out from _omap4_disable_module() before
>> clearing the MODULEMODE bits.
>>
>> Is this correct behavior? This would prevent all hwmods who have rst_lines_cnt
>> as 0 to not get their MODULEMODE bits cleared.
>
> You're right, that looks bogus.  What do you think about the following
> patch?

I was a little busy creating the patch but seems like Paul beat me to
it, yes it was a wrong case on disable_module.

> From: Paul Walmsley <paul@pwsan.com>
> Date: Mon, 8 Oct 2012 23:08:15 -0600
> Subject: [PATCH] ARM: OMAP4/AM335x: hwmod: fix disable_module regression in
>  hardreset handling
>
> Commit eb05f691290e99ee0bd1672317d6add789523c1e ("ARM: OMAP: hwmod:
> partially un-reset hwmods might not be properly enabled") added code
> to skip the IP block disable sequence if any hardreset lines were left
> unasserted.  But this did not handle the case when no hardreset lines
> were associated with a module, which is the general case.  In that
> situation, the IP block would be skipped, which is likely to cause PM
> regressions.
>
> So, modify _omap4_disable_module() and _am33xx_disable_module() to
> only bail out early if there are any hardreset lines asserted.  And
> move the AM33xx test above the actual module disable code to ensure
> that the behavior is consistent.

I think that on _omap4_disable_module() we want to check if the module
is deasserted rather than if it is asserted.

E.g.: If you have 2 hwmods for the same module (ipu with reset "cpu0"
and mmu_ipu with reset "mmu") controlled by different drivers,
depending on which one is idled first, the other one will cause L3
aborts given that the module is already disabled. So, if ipu is idled
and disabled first, then all tear down operations on iommu will cause
L3 aborts.

I created the following:

From: Omar Ramirez Luna <omar.luna@linaro.org>
Subject: [PATCH] ARM: OMAP: hwmod: allow hwmods without reset lines to be
 disabled

_are_all_hardreset_lines_asserted treats hwmods without reset lines
as always deasserted, this is correct for: _enable, _idle and
_shutdown paths, however for _omap4_disable_module it might not
result in the correct behavior, given that:

  - hwmod without reset line can be safely disabled.
  - hwmod with 1 or more reset lines, must be completely asserted
    before disabled or be left to integration code to handle it.

Create a function to check for any hwmod to be partially out of
hardreset and bail of _omap4_disable_module if this is the case.
Hwmods without reset lines can skip these check and continue.

Reported-by: Archit Taneja <a0393947@ti.com>
Signed-off-by: Omar Ramirez Luna <omar.luna@linaro.org>
---
 arch/arm/mach-omap2/omap_hwmod.c |   30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 299ca28..f9d9bfb 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1698,6 +1698,29 @@ static bool
_are_all_hardreset_lines_asserted(struct omap_hwmod *oh)
 }

 /**
+ * _are_any_hardreset_lines_deasserted - true if part of @oh isn't hard-reset
+ * @oh: struct omap_hwmod *
+ *
+ * If any hardreset line associated with @oh is deasserted, then return true.
+ * Otherwise, if no hardreset lines associated with @oh are deasserted,
+ * then return false. This function is used to avoid SOC's disable_module to
+ * be called while the @oh is still deasserted.
+ *
+ * Check for oh->rst_lines_cnt is left to the caller, since a return value
+ * could mean that a hwmod with no reset lines is deasserted.
+ */
+static bool _are_any_hardreset_lines_deasserted(struct omap_hwmod *oh)
+{
+	int i;
+
+	for (i = 0; i < oh->rst_lines_cnt; i++)
+		if (_read_hardreset(oh, oh->rst_lines[i].name) == 0)
+			return true;
+
+	return false;
+}
+
+/**
  * _omap4_disable_module - enable CLKCTRL modulemode on OMAP4
  * @oh: struct omap_hwmod *
  *
@@ -1713,9 +1736,12 @@ static int _omap4_disable_module(struct omap_hwmod *oh)

 	/*
 	 * Since integration code might still be doing something, only
-	 * disable if all lines are under hardreset.
+	 * disable if all lines are under hardreset. Explicitly check for
+	 * reset lines before the call, otherwise the abscence of a reset
+	 * line is assumed as a deasserted hwmod and won't execute the
+	 * disable sequence.
 	 */
-	if (!_are_all_hardreset_lines_asserted(oh))
+	if (oh->rst_lines_cnt && _are_any_hardreset_lines_deasserted(oh))
 		return 0;

 	pr_debug("omap_hwmod: %s: %s\n", oh->name, __func__);
-- 
1.7.9.5
