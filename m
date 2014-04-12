From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 00/18] ARM: OMAP2+: CM/PRM cleanup set
Date: Sat, 12 Apr 2014 13:22:54 +0300
Message-ID: <534913FE.1020802@ti.com>
References: <1393949958-816-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45233 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755310AbaDLKXU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 12 Apr 2014 06:23:20 -0400
In-Reply-To: <1393949958-816-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, khilman@linaro.org
Cc: linux-arm-kernel@lists.infradead.org

On 03/04/2014 06:19 PM, Tero Kristo wrote:
> Hi,
>
> This set cleans up the CM/PRM codebase a bit, removing the need for direct
> CM/PRM register access macros outside CM/PRM drivers. This is done in
> preparation to isolate these drivers into its own driver directory.
> Currently my plan is to create a single PRCM driver, which will contain
> both, and as such, CM/PRM inter-access is not removed in this set.
>
> This set is built on top of the OMAP2 DT clock conversion set, but most
> of the patches can also be standalone if need be.
>
> Testing done:
> - omap2 : none (any feedback welcome)
> - omap3-beagle : boot, suspend-resume (RET), suspend-resume (OFF)
> - omap4-panda-es : boot, suspend-resume (RET)
>
> Branch also available here:
> tree: https://github.com/t-kristo/linux-pm.git
> branch: 3.14-rc4-cm-prm-cleanup
>
> -Tero
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

Hi,

This work is outdated and is preceded by the stuff here (for the 
interested parties):

https://github.com/t-kristo/linux-pm/tree/3.14-rc4-cm-prm-driver-wip

I'll be posting small sets of patches out of here once the pre-reqs for 
the WIP branch are covered.

-Tero

