From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP2+: OMAP44XX: Clock: Correct the clock identifiers
 for OMAP4460 and OMAP4430
Date: Fri, 25 Jan 2013 08:50:45 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1301250845310.471@utopia.booyaka.com>
References: <1358504498-31985-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:41699 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751218Ab3AYIuq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Jan 2013 03:50:46 -0500
In-Reply-To: <1358504498-31985-1-git-send-email-j-keerthy@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: J Keerthy <j-keerthy@ti.com>
Cc: linux-omap@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>, mturquette@linaro.org

Hi,

On Fri, 18 Jan 2013, J Keerthy wrote:

> The previous logic to detect the clocks for OMAP4460
> was to combine the clocks marked as CK_443X and CK_446X. This would be
> fine as long as OMAP4460 was a super set of OMAP4430 clock set.
> This is not the case as there are clocks which are specific to OMAP4430
> (for example bandgap_fclk) and some which are specific to OMAP4460(for example
> bandgap_ts_fclk). 
> The clock "bandgap_fclk" is specific for OMAP4430 and
> this was added as part of OMAP4460 clock set which should not be done.
> 
> Hence changing the convention.
> 
> CK_446X				--------> Clocks specific to OMAP4460
> CK_443X				--------> Clocks specific to OMAP4430
> CK_44XX (CK_446X | CK_443X)	--------> Common to both OMAP4460 and OMAP4430
> 
> Boot Tested on both Panda and Panda-es.
> 
> Signed-off-by: J Keerthy <j-keerthy@ti.com>
> Reviewed-by: Rajendra Nayak <rnayak@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Eduardo Valentin <eduardo.valentin@ti.com>

While I agree with this patch, my understanding is that Tony wishes to 
shift to list-based initialization for clocks, similar to how the hwmod 
initialization is done for OMAP3.  This will result in moving away from 
the CK_* flags.  There are some previous public mailing list messages on 
this topic that you can probably find by searching for CK_446X.
Now that we've switched to the common clock framework, it should be more 
practical to do this conversion, since we can refer to parent clocks by 
name rather than by pointer.  Could you please update your patch to take 
that approach instead?

- Paul
