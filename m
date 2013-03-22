From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [RFC 0/8]: omap4: clk: move clock data under drivers/clk
Date: Fri, 22 Mar 2013 10:58:37 +0530
Message-ID: <514BEC05.3050105@ti.com>
References: <1363887347-4686-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51781 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932680Ab3CVF2x (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Mar 2013 01:28:53 -0400
In-Reply-To: <1363887347-4686-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, khilman@linaro.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

Tero,

On Thursday 21 March 2013 11:05 PM, Tero Kristo wrote:
> Hi,
> 
> This is an RFC version of the clock data move under drivers/clk.
> Tested under 3.8 and boots fine, but don't try this out unless
> you are experimental sort (I quickly tried with 3.9-rc3 and it failed to
> boot with that.)
> 
> The approach taken here has minimal impact on the clock data
> and should make it easy to transfer clock data for omap2 / omap3 and
> omap5 also. omap4 was only done as a proof of concept.
> 
> Any comments appreciated.

I strangely only see the cover letter delivered to me and no
patches. Do you have a branch with the patches which you can
share?

regards,
Rajendra
 
> 
> -Tero
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

