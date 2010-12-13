From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v2 4/8] OMAP4: clock data: Add missing fields in iva_hsd_byp_clk_mux_ck
Date: Mon, 13 Dec 2010 14:14:10 +0100
Message-ID: <4D061C22.9020405@ti.com>
References: <1291932820-11163-1-git-send-email-b-cousson@ti.com> <1291932820-11163-5-git-send-email-b-cousson@ti.com> <alpine.DEB.2.00.1012101732320.13430@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59285 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757588Ab0LMNOT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 13 Dec 2010 08:14:19 -0500
In-Reply-To: <alpine.DEB.2.00.1012101732320.13430@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Bergsagel, Jonathan" <jbergsagel@ti.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Nayak, Rajendra" <rnayak@ti.com>

Hi Paul,

On 12/11/2010 1:34 AM, Paul Walmsley wrote:
> On Thu, 9 Dec 2010, Benoit Cousson wrote:
>
>> From: Jonathan Bergsagel<jbergsagel@ti.com>
>>
>> Add register address, mask and link to the clksel structure that
>> were missing in the IVA DPLL mux clock node.
>>
>> Signed-off-by: Jonathan Bergsagel<jbergsagel@ti.com>
>> Signed-off-by: Benoit Cousson<b-cousson@ti.com>
>
> This patch results in a checkpatch warning:
>
> ---
>
> WARNING: please, no space before tabs
> #23: FILE: arch/arm/mach-omap2/clock44xx_data.c:639:
> +^I.clksel ^I= iva_hsd_byp_clk_mux_sel,$
>
> total: 0 errors, 1 warnings, 0 checks, 13 lines checked
>
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
>
> ---
>
> I've fixed it in the copy in my local branch, but next time, please run
> checkpatch.pl and fix any problems before submitting.

Oops, that's my mistake. the original patch was good, and I messed it up 
during the merge conflict resolution.
And then on top of that I completely missed this warning due to the 
important number of "line over 80 characters" warnings in this series.
I have now a "filter for dummies" to remove that and avoid missing real 
warnings in the future.

Thanks,
Benoit
