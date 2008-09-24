From: "Arun KS" <arunks@mistralsolutions.com>
Subject: Re: [PATCH] Temporary fix to boot OMAP1 based boards
Date: Wed, 24 Sep 2008 12:35:05 +0530
Message-ID: <dfeb90390809240005xadef43dhb78c8ae214baab64@mail.gmail.com>
References: <dfeb90390809230823l7c37d15au49c5726c7510718c@mail.gmail.com>
	 <20080924.065137.142952786.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.235]:28387 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752034AbYIXHFG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Sep 2008 03:05:06 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2568313rvb.1
        for <linux-omap@vger.kernel.org>; Wed, 24 Sep 2008 00:05:06 -0700 (PDT)
In-Reply-To: <20080924.065137.142952786.Hiroshi.DOYU@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: Paul Walmsley <paul@booyaka.com>, linux-omap@vger.kernel.org

On Wed, Sep 24, 2008 at 9:21 AM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com> wrote:
> Hi,
>
> How about introducing a new typedef in order to accommodate the
> different size of enable_regs without ifdefs?
>
> I think that this is apparently the case categorized into (a) in
> 'CodyingStyle'.

I am not sure which is the right way to do. Is this what you meant?


arch/arm/plat-omap/include/mach/clock.h |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/include/mach/clock.h
b/arch/arm/plat-omap/include/mach/clock.h
index f26ad8c..122532e 100644
--- a/arch/arm/plat-omap/include/mach/clock.h
+++ b/arch/arm/plat-omap/include/mach/clock.h
@@ -59,6 +59,12 @@ struct dpll_data {

 #endif

+#if defined(CONFIG_ARCH_OMAP1)
+typedef	void __iomem *reg_t;
+#elif
+typedef	u16	reg_t;
+#endif
+
 struct clk {
 	struct list_head	node;
 	struct module		*owner;
@@ -67,7 +73,7 @@ struct clk {
 	struct clk		*parent;
 	unsigned long		rate;
 	__u32			flags;
-	u16			enable_reg;
+	reg_t			enable_reg;
 	__u8			enable_bit;
 	__s8			usecount;
 	u8			idlest_bit;

Regards
Arun
>
>     Hiroshi DOYU
>
> From: "ext Arun KS" <arunks@mistralsolutions.com>
> Subject: [PATCH] Temporary fix to boot OMAP1 based boards
> Date: Tue, 23 Sep 2008 20:53:09 +0530
>
>> This patch is a temporary fix for a kernel panic causing at omap1_clk_init
>>
>> Signed-off-by: Arun KS <arunks@mistralsolutions.com>
>> ---
>>  arch/arm/plat-omap/include/mach/clock.h |    4 ++++
>>  1 files changed, 4 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/plat-omap/include/mach/clock.h
>> b/arch/arm/plat-omap/include/mach/clock.h
>> index f26ad8c..b9c471e 100644
>> --- a/arch/arm/plat-omap/include/mach/clock.h
>> +++ b/arch/arm/plat-omap/include/mach/clock.h
>> @@ -67,7 +67,11 @@ struct clk {
>>       struct clk              *parent;
>>       unsigned long           rate;
>>       __u32                   flags;
>> +#if defined(CONFIG_ARCH_OMAP1)
>> +     void __iomem            *enable_reg;
>> +#elif
>>       u16                     enable_reg;
>> +#endif
>>       __u8                    enable_bit;
>>       __s8                    usecount;
>>       u8                      idlest_bit;
>> --
>> 1.5.3.4
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
