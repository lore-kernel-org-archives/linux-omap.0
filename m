From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 1/9] ARM: OMAP4+: Use common scratchpad SAR RAM offsets
 for all architectures
Date: Thu, 28 Mar 2013 13:02:54 +0530
Message-ID: <5153F226.8060604@ti.com>
References: <1361373527-21695-1-git-send-email-santosh.shilimkar@ti.com> <1361373527-21695-2-git-send-email-santosh.shilimkar@ti.com> <87mwto7ki5.fsf@linaro.org> <51535B66.60307@ti.com> <20130327204930.GM10155@atomide.com> <51535C23.5000405@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41487 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756538Ab3C1HbA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Mar 2013 03:31:00 -0400
In-Reply-To: <51535C23.5000405@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@linaro.org>, linux-arm-kernel@lists.infradead.org, Tero Kristo <t-kristo@ti.com>

On Thursday 28 March 2013 02:22 AM, Santosh Shilimkar wrote:
> On Thursday 28 March 2013 02:19 AM, Tony Lindgren wrote:
>> * Santosh Shilimkar <santosh.shilimkar@ti.com> [130327 13:52]:
>>> On Thursday 28 March 2013 12:11 AM, Kevin Hilman wrote:
>>>> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>>>>
>>>>> From: Tero Kristo <t-kristo@ti.com>
>>>>>
>>>>> Simplifies code and also allows the re-use as is on OMAP5 devices.
>>>>
>>>> nit: changelog here is rather weak.  It claims "simplifies code" but
>>>> it's not obvious from the patch how changing a few #defines does that.
>>>>
>>> I agree. Basically the offset are chosen such a way that they can
>>> work on OMAP4 and OMAP5 instead of having two separate sets.
>>> Will expand the changelog to make it clear.
>>
>> You might want to mention also that the offsets are only used by
>> the kernel to save and restore registers from so people don't
>> think those are hardare registers and that the patch might break
>> some things.
>>
> Yeah. Will mention that.
> 
For record, patch with updated changelog end of email.

Regards,
Santosh

>From f98d5fe8079cc4830e4ce22585055822119da5c8 Mon Sep 17 00:00:00 2001
From: Tero Kristo <t-kristo@ti.com>
Date: Wed, 6 Feb 2013 18:39:20 +0530
Subject: [PATCH v2 1/9] ARM: OMAP4+: Use common scratchpad SAR RAM offsets
 for all architectures

Choose the common scratch pad offsets, so that same offsets can work for
OMAP4 and OMAP5 devices. It simplifies code and also allows the re-use as
is on OMAP5 devices. Note that these offsets are used by low power
code for various power state management. They are not hardware register
offsets.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/omap4-sar-layout.h |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/omap4-sar-layout.h b/arch/arm/mach-omap2/omap4-sar-layout.h
index e170fe8..6822d0a 100644
--- a/arch/arm/mach-omap2/omap4-sar-layout.h
+++ b/arch/arm/mach-omap2/omap4-sar-layout.h
@@ -20,13 +20,13 @@
 #define SAR_BANK4_OFFSET		0x3000
 
 /* Scratch pad memory offsets from SAR_BANK1 */
-#define SCU_OFFSET0				0xd00
-#define SCU_OFFSET1				0xd04
-#define OMAP_TYPE_OFFSET			0xd10
-#define L2X0_SAVE_OFFSET0			0xd14
-#define L2X0_SAVE_OFFSET1			0xd18
-#define L2X0_AUXCTRL_OFFSET			0xd1c
-#define L2X0_PREFETCH_CTRL_OFFSET		0xd20
+#define SCU_OFFSET0				0xfe4
+#define SCU_OFFSET1				0xfe8
+#define OMAP_TYPE_OFFSET			0xfec
+#define L2X0_SAVE_OFFSET0			0xff0
+#define L2X0_SAVE_OFFSET1			0xff4
+#define L2X0_AUXCTRL_OFFSET			0xff8
+#define L2X0_PREFETCH_CTRL_OFFSET		0xffc
 
 /* CPUx Wakeup Non-Secure Physical Address offsets in SAR_BANK3 */
 #define CPU0_WAKEUP_NS_PA_ADDR_OFFSET		0xa04
-- 
1.7.9.5


