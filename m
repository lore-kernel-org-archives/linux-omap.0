From: "J, KEERTHY" <j-keerthy@ti.com>
Subject: RE: [PATCH] ARM: OMAP2+: OMAP44XX: Clock: Correct the clock
 identifiers for OMAP4460 and OMAP4430
Date: Mon, 28 Jan 2013 10:59:37 +0000
Message-ID: <DC88CAD03C0052499C1907B327FC63229B6C4A@DBDE01.ent.ti.com>
References: <1358504498-31985-1-git-send-email-j-keerthy@ti.com>
 <alpine.DEB.2.00.1301250845310.471@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52241 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754864Ab3A1K7m convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Jan 2013 05:59:42 -0500
In-Reply-To: <alpine.DEB.2.00.1301250845310.471@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Valentin, Eduardo" <eduardo.valentin@ti.com>, "mturquette@linaro.org" <mturquette@linaro.org>

Hi Paul,

-----Original Message-----
From: Paul Walmsley [mailto:paul@pwsan.com] 
Sent: Friday, January 25, 2013 2:21 PM
To: J, KEERTHY
Cc: linux-omap@vger.kernel.org; Valentin, Eduardo; mturquette@linaro.org
Subject: Re: [PATCH] ARM: OMAP2+: OMAP44XX: Clock: Correct the clock identifiers for OMAP4460 and OMAP4430

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

Thanks for your feedback. I am in the process of removing all the
CK_* flags and making separate lists instead. I am not
Able to figure out where/how exactly the flag "CK_TI816X"
Is getting used. Which family of processors are chosen
Using this flag? Which clock nodes are selected using
This flag?

- Paul

Regards,
Keerthy
