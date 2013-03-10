From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 05/15] ARM: OMAP5: PM: Enables ES2 PM mode by default
Date: Sun, 10 Mar 2013 23:37:58 +0530
Message-ID: <513CCBFE.3000700@ti.com>
References: <1362139864-9233-1-git-send-email-santosh.shilimkar@ti.com> <1362139864-9233-6-git-send-email-santosh.shilimkar@ti.com> <20130301193745.GA22626@kahuna> <51319273.5090703@ti.com> <20130304182921.GC14860@kahuna>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51633 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751562Ab3CJSGV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 10 Mar 2013 14:06:21 -0400
In-Reply-To: <20130304182921.GC14860@kahuna>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, linux-arm-kernel@lists.infradead.org

On Monday 04 March 2013 11:59 PM, Nishanth Menon wrote:
> On 11:17-20130302, Santosh Shilimkar wrote:
>> On Saturday 02 March 2013 01:07 AM, Nishanth Menon wrote:
>>> On 17:40-20130301, Santosh Shilimkar wrote:
>>>> Enables MPUSS ES2 power management mode using ES2_PM_MODE in
>>>> AMBA_IF_MODE register.
>>>>

[..]

>>>> diff --git a/arch/arm/mach-omap2/omap-wakeupgen.h b/arch/arm/mach-omap2/omap-wakeupgen.h
>>>> index b0fd16f..b3c8ecc 100644
>>>> --- a/arch/arm/mach-omap2/omap-wakeupgen.h
>>>> +++ b/arch/arm/mach-omap2/omap-wakeupgen.h
>>>> @@ -27,6 +27,7 @@
>>>>  #define OMAP_WKG_ENB_E_1			0x420
>>>>  #define OMAP_AUX_CORE_BOOT_0			0x800
>>>>  #define OMAP_AUX_CORE_BOOT_1			0x804
>>>> +#define OMAP_AMBA_IF_MODE			0x80c
>>>>  #define OMAP_PTMSYNCREQ_MASK			0xc00
>>>>  #define OMAP_PTMSYNCREQ_EN			0xc04
>>>>  #define OMAP_TIMESTAMPCYCLELO			0xc08
>>>
>>> Curious, I see OMAP5_AMBA_IF_MODE_OFFSET in
>>> arch/arm/mach-omap2/omap4-sar-layout.h
>>> if we dont save new modified contents there, Wont restore logic just
>>> reset it back to 0?
>>>
>> It is already restored in the wakeup-gen restore code.
> I apologize, I do not see it in:
> https://github.com/SantoshShilimkar/linux/blob/testing/3.10/omap5-int-rebuild/arch/arm/mach-omap2/omap-wakeupgen.c
> I might have expected an save of val to sar offset to ensure this is
> done, but since you indicate this is in wakeupgen restore logic, which I
> presume is done by ROM, we might expect an write to sar_base +
> OMAP5_AMBA_IF_MODE_OFFSET with the val for it to function?
> 
Arr.. Looks like I missed the hunk while updating the patches. Will
fix the appropriate patch which updates the wakeupgen SAR offsets.

Regards,
Santosh
