From: "Mahapatra, Chandrabhanu" <cmahapatra@ti.com>
Subject: Re: [PATCH V3 0/3] OMAPDSS: Enable dynamic debug printing
Date: Fri, 28 Sep 2012 17:41:21 +0530
Message-ID: <CAF0AtAsbBd_P7_=Swtre1MGrE_gW4JikYt3MaJ1kFO1ALzB36w@mail.gmail.com>
References: <cover.1348636132.git.cmahapatra@ti.com>
	<cover.1348826106.git.cmahapatra@ti.com>
	<1348832057.2437.24.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:47407 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757519Ab2I1MLX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Sep 2012 08:11:23 -0400
Received: by vcbfo13 with SMTP id fo13so3202364vcb.19
        for <linux-omap@vger.kernel.org>; Fri, 28 Sep 2012 05:11:21 -0700 (PDT)
In-Reply-To: <1348832057.2437.24.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Fri, Sep 28, 2012 at 5:04 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On Fri, 2012-09-28 at 15:53 +0530, Chandrabhanu Mahapatra wrote:
>> Hi everyone,
>> this patch series aims at cleaning up of DSS of printk()'s enabled with
>> dss_debug and replace them with generic dynamic debug printing.
>>
>> The 1st patch
>>  * moved DEBUG flag definition to Makefile
>> The 2nd patch
>>  * replaces printk() in DSSDBG definition with pr_debug()
>>  * removes DSSDBGF definition and replaces its instances with DSSDBG()
>> The 3rd patch
>>  * cleans up printk()'s in omap_dispc_unregister_isr() and
>>    _dsi_print_reset_status() with pr_debug()
>>  * removes dss_debug variable
>>
>> Changes from V1 to V2:
>>  * added debug messages to DSSDBG calls
>>  * added patch "OMAPDSS: Remove dss_debug variable"
>>
>> Changes from V2 to V3
>>  * added patch "OMAPDSS: Move definition of DEBUG flag to Makefile"
>>
>> All your comments and suggestions are welcome.
>
> There's one thing that's not quite nice about omapdss's debug print
> behavior after this series.
>
> CONFIG_OMAP2_DSS_DEBUG_SUPPORT is marked "default y", and it's also been
> safe to enable earlier as we had the dss_debug variable to prevent the
> debug prints. But after this series, the debug prints are enabled, and
> will spam the kernel log quite heavily.
>
> And that happens with both dynamic debugging enabled and disabled.

Yes, I had noticed that but I thought a better way to disable debug
prints is to disable both dynamic debugging (CONFIG_DYNAMIC_DEBUG) and
CONFIG_OMAP2_DSS_DEBUG_SUPPORT. May be CONFIG_OMAP2_DSS_DEBUG_SUPPORT
should have been false by default.

> How things should work:
>
> For kernels with dynamic debugging disabled: by default the dss debugs
> are not compiled, and the user needs to explicitly enable them in the
> kernel config.
>
> For kernels with dynamic debugging enabled: by default the dss debugs
> are compiled in, but not enabled. A Kconfig option can be set to make
> the debugs enabled by default.
>
> In addition to those, we have the debugfs files. Those should be usable
> regardless of the debug prints.
>
> So I suggest the following:
>
> - Remove CONFIG_OMAP2_DSS_DEBUG_SUPPORT. We can't re-use it, because it
> may be enabled in user's kernel configs.
> - Add new Kconfig option: CONFIG_OMAP2_DSS_DEBUG. This will set DEBUG in
> the makefile. This is off by default.
> - Add new Kconfig option: CONFIG_OMAP2_DSS_DEBUGFS. This will be use to
> decide if debugfs functionality is compiled in or not. This is off by
> default.
>
>  Tomi
>

Well, I had a different perception. If one needs to debug then both
debugfs and debug prints should be enabled. If one needs only debug
prints then CONFIG_DEBUG_FS can be disabled.
But above approach seems to provide more flexibilty.

-- 
Chandrabhanu Mahapatra
Texas Instruments India Pvt. Ltd.
