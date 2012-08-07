From: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Subject: Re: [PATCH 1/6] OMAPDSS: DISPC: Remove cpu_is_xxxx checks
Date: Tue, 07 Aug 2012 17:52:59 +0530
Message-ID: <502108A3.9060903@ti.com>
References: <cover.1343912532.git.cmahapatra@ti.com>  <5344e530a125ef5c5dfeb00e54b7d32df6169aa9.1343912532.git.cmahapatra@ti.com> <1344336723.7216.44.camel@lappyti>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:57559 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753801Ab2HGMZM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Aug 2012 08:25:12 -0400
Received: by obqv19 with SMTP id v19so7465993obq.2
        for <linux-omap@vger.kernel.org>; Tue, 07 Aug 2012 05:25:10 -0700 (PDT)
In-Reply-To: <1344336723.7216.44.camel@lappyti>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Tuesday 07 August 2012 04:22 PM, Tomi Valkeinen wrote:
> Hi,
>
> On Tue, 2012-08-07 at 13:57 +0530, Chandrabhanu Mahapatra wrote:
>> The cpu_is checks have been removed from DISPC providing it a much generic and
>> cleaner interface. The OMAP version and revision specific functions are
>> initialized by dispc_ops structure in dss features.
> I think this needs some changes. I think our general approach to these
> version differences should be such that the component in question (dispc
> in this case) should ask from somewhere what the DSS version is, and
> then using that version, handle the different versions internally.
>
> What that means related to this patch is that we should keep all those
> functions static, and initialize the dispc_ops structure inside dispc.c.
>
> However, we don't have any such "DSS version" yet. I have previously
> wanted to move the cpu_is checks to one place (dss_features), but I
> think it's probably cleaner if we allow cpu_is checks in the other files
> also. However, there should be only one place in the file where those
> should be.
>
> So I think we should have something like this, called from
> omap_dispchw_probe():
>
> static void dispc_init_features(void)
> {
> 	if (cpu_is_foo())
> 		setup features for this omap;
> 	else if (...)
> 		...
> }
>
> This would setup the ops, or whatever is needed. This function would be
> the only place in dispc.c that contains cpu_is checks.
>
>  Tomi
>
Yes, this seems good to me. Its better to have all cpu_is checks of
dispc.c and dss.c in their probe functions and by the time
implementation of DSS version come to picture these can be move to dss
features or any other place appropriate. But how to handle OMAP revision
specific functions. Will Dss version handle that too, as like DSS1,
DSS1.1, DSS1.1.1, DSS2 say?

-- 
Chandrabhanu Mahapatra
Texas Instruments India Pvt. Ltd.

