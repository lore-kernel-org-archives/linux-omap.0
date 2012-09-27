From: "Mahapatra, Chandrabhanu" <cmahapatra@ti.com>
Subject: Re: [PATCH V2 0/2] OMAPDSS: Enable dynamic debug printing
Date: Thu, 27 Sep 2012 16:20:21 +0530
Message-ID: <CAF0AtAvT-NnsREJWpRtYAGpYCS06O32tzQwWTDoFp+xepHyX8w@mail.gmail.com>
References: <1348552998-6596-1-git-send-email-cmahapatra@ti.com>
	<cover.1348636132.git.cmahapatra@ti.com>
	<1348669792.2376.51.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:53414 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755846Ab2I0KuW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 27 Sep 2012 06:50:22 -0400
Received: by pbbrp16 with SMTP id rp16so6103108pbb.1
        for <linux-omap@vger.kernel.org>; Thu, 27 Sep 2012 03:50:21 -0700 (PDT)
In-Reply-To: <1348669792.2376.51.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Wed, Sep 26, 2012 at 7:59 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:

> This doesn't work quite correctly. The problem is in dss.h, where we
> define DEBUG if CONFIG_OMAP2_DSS_DEBUG_SUPPORT is set. The thing is,
> DEBUG should be defined before including the kernel headers where the
> pr_debug etc are defined.
>
> So if you try the patches without dynamic debugging enabled, you won't
> get any debug outputs at all, even if CONFIG_OMAP2_DSS_DEBUG_SUPPORT is
> set.
>
> And for dynamic debug, the Kconfig help says:
>
> If a source file is compiled with DEBUG flag set, any
> pr_debug() calls in it are enabled by default, but can be
> disabled at runtime as below.  Note that DEBUG flag is
> turned on by many CONFIG_*DEBUG* options.
>
> So if we have CONFIG_OMAP2_DSS_DEBUG_SUPPORT set, all the pr_debugs
> should be enabled by default, which is not the case, again because DEBUG
> is defined too late.
>
> I think setting DEBUG in dss.h should be removed, and instead DEBUG
> should be set in the makefile if CONFIG_OMAP2_DSS_DEBUG_SUPPORT is set.
>
>  Tomi
>

Well the documentation lags in describing about the DEBUG flag. I
should have checked DYNAMIC_DEBUG in Kconfig and pr_debug definition
in printk.h file.

#if defined(CONFIG_DYNAMIC_DEBUG)
/* dynamic_pr_debug() uses pr_fmt() internally so we don't need it here */
#define pr_debug(fmt, ...) \
        dynamic_pr_debug(fmt, ##__VA_ARGS__)
#elif defined(DEBUG)
#define pr_debug(fmt, ...) \
        printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
#else
#define pr_debug(fmt, ...) \
        no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
#endif

As per the definition above pr_debug is dynamic with
CONFIG_DYNAMIC_DEBUG set or else with DEBUG set it is just a normal
kernel debug printk as you have mentioned.
I still don't get how even if DEBUG is set before DSSDBG() is defined
in dss.c pr_debug() fails to enable.
Well anyways, how to do the same in the Makefile? I tried adding
ccflags-$(CONFIG_OMAP2_DSS_DEBUG_SUPPORT) += -DEBUG
to makefile in dss directory but of no use.

-- 
Chandrabhanu Mahapatra
Texas Instruments India Pvt. Ltd.
