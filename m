From: "Mahapatra, Chandrabhanu" <cmahapatra@ti.com>
Subject: Re: [PATCH V3 2/3] OMAPDSS: Cleanup DSSDBG with dynamic pr_debug function
Date: Fri, 28 Sep 2012 17:00:18 +0530
Message-ID: <CAF0AtAvfnnBzTgPtNBJhxXTp9dZfPQOnotNmCQ+Fz=tkHY65gA@mail.gmail.com>
References: <cover.1348636132.git.cmahapatra@ti.com>
	<cover.1348826106.git.cmahapatra@ti.com>
	<2fc91980de4af940ac59b26fd49da6498865db8b.1348826106.git.cmahapatra@ti.com>
	<1348831358.2437.14.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:50523 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753365Ab2I1LaU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Sep 2012 07:30:20 -0400
Received: by vcbfo13 with SMTP id fo13so3165158vcb.19
        for <linux-omap@vger.kernel.org>; Fri, 28 Sep 2012 04:30:18 -0700 (PDT)
In-Reply-To: <1348831358.2437.14.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Fri, Sep 28, 2012 at 4:52 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On Fri, 2012-09-28 at 15:53 +0530, Chandrabhanu Mahapatra wrote:
>> The printk in DSSDBG function definition is replaced with dynamic debug enabled
>> pr_debug(). The use of dynamic debugging provides more flexibility as each debug
>> statement can be enabled or disabled dynamically on basis of source filename,
>> line number, module name etc. by writing to a control file in debugfs
>> filesystem. For better understanding please refer to
>> Documentation/dynamic-debug-howto.txt.
>>
>> The DSSDBGF() differs from DSSDBG() by providing function name. However,
>> function name, line number, module name and thread ID can be printed through
>> dynamic debug by setting appropriate flags 'f','l','m' and 't' in the debugfs
>> control file. So, DSSDBGF instances are replaced with DSSDBG.
>>
>> Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
>> ---
>>  drivers/video/omap2/dss/apply.c |    8 ++++----
>>  drivers/video/omap2/dss/dsi.c   |   12 ++++++------
>>  drivers/video/omap2/dss/dss.h   |   34 ++++++++--------------------------
>>  3 files changed, 18 insertions(+), 36 deletions(-)
>>
>
>> -     DSSDBGF("%d", channel);
>> +     DSSDBG("Initial Config of Virtual Channel %d", channel);
>
> A Bit Too Much Capital Letters here for my taste =). Use just one at the
> beginning of the print, or none at all.
>
>>
>>       r = dsi_read_reg(dsidev, DSI_VC_CTRL(channel));
>>
>> @@ -2814,7 +2814,7 @@ static int dsi_vc_config_source(struct platform_device *dsidev, int channel,
>>       if (dsi->vc[channel].source == source)
>>               return 0;
>>
>> -     DSSDBGF("%d", channel);
>> +     DSSDBG("Source Config of Virtual Channel %d", channel);
>
> Here also.
>

Ok.

>>
>>       dsi_sync_vc(dsidev, channel);
>>
>> @@ -3572,7 +3572,7 @@ static int dsi_enter_ulps(struct platform_device *dsidev)
>>       int r, i;
>>       unsigned mask;
>>
>> -     DSSDBGF();
>> +     DSSDBG("Entering ULPS");
>>
>>       WARN_ON(!dsi_bus_is_locked(dsidev));
>>
>> @@ -4276,7 +4276,7 @@ int omapdss_dsi_set_clocks(struct omap_dss_device *dssdev,
>>       unsigned long pck;
>>       int r;
>>
>> -     DSSDBGF("ddr_clk %lu, lp_clk %lu", ddr_clk, lp_clk);
>> +     DSSDBG("Setting DSI clocks: ddr_clk %lu, lp_clk %lu", ddr_clk, lp_clk);
>>
>>       mutex_lock(&dsi->lock);
>>
>> diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
>> index ffbba7e..5ef4e17 100644
>> --- a/drivers/video/omap2/dss/dss.h
>> +++ b/drivers/video/omap2/dss/dss.h
>> @@ -25,38 +25,20 @@
>>
>>  #ifdef DEBUG
>>  extern bool dss_debug;
>> -#ifdef DSS_SUBSYS_NAME
>> -#define DSSDBG(format, ...) \
>> -     if (dss_debug) \
>> -             printk(KERN_DEBUG "omapdss " DSS_SUBSYS_NAME ": " format, \
>> -             ## __VA_ARGS__)
>> -#else
>> -#define DSSDBG(format, ...) \
>> -     if (dss_debug) \
>> -             printk(KERN_DEBUG "omapdss: " format, ## __VA_ARGS__)
>>  #endif
>>
>> -#ifdef DSS_SUBSYS_NAME
>> -#define DSSDBGF(format, ...) \
>> -     if (dss_debug) \
>> -             printk(KERN_DEBUG "omapdss " DSS_SUBSYS_NAME \
>> -                             ": %s(" format ")\n", \
>> -                             __func__, \
>> -                             ## __VA_ARGS__)
>> -#else
>> -#define DSSDBGF(format, ...) \
>> -     if (dss_debug) \
>> -             printk(KERN_DEBUG "omapdss: " \
>> -                             ": %s(" format ")\n", \
>> -                             __func__, \
>> -                             ## __VA_ARGS__)
>> +#ifdef pr_fmt
>> +#undef pr_fmt
>>  #endif
>>
>> -#else /* DEBUG */
>> -#define DSSDBG(format, ...)
>> -#define DSSDBGF(format, ...)
>> +#ifdef DSS_SUBSYS_NAME
>> +#define pr_fmt(fmt) DSS_SUBSYS_NAME ": " fmt
>> +#else
>> +#define pr_fmt(fmt) fmt
>>  #endif
>
> I think you could just do:
>
> #ifdef DSS_SUBSYS_NAME
> #ifdef pr_fmt
> #undef pr_fmt
> #endif
> #define pr_fmt(fmt) DSS_SUBSYS_NAME ": " fmt
> #endif
>
> For the case where there's no DSS_SUBSYS_NAME, there's no need to undef
> pr_fmt, only to redefine it again back to the original.
>
>  Tomi
>

Ok. But I thought it could be more clearer if the definition of pr_fmt
is more clearer in both the cases, when DSS_SUBSYS_NAME is defined and
when not.

-- 
Chandrabhanu Mahapatra
Texas Instruments India Pvt. Ltd.
