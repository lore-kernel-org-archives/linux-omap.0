From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 5/6] OMAP3+: Update DPLL Fint range for OMAP36xx and
 OMAP4xxx devices
Date: Thu, 6 Oct 2011 19:40:58 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1110061938210.4611@utopia.booyaka.com>
References: <1316195322-15062-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:32938 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752908Ab1JGBk7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Oct 2011 21:40:59 -0400
In-Reply-To: <1316195322-15062-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, mturquette@ti.com

On Fri, 16 Sep 2011, Jon Hunter wrote:

> From: Jon Hunter <jon-hunter@ti.com>
> 
> The OMAP36xx and OMAP4xxx DPLLs have a different internal reference
> clock frequency (fint) operating range than OMAP3430. Update the
> dpll_test_fint() function to check for the correct frequency ranges
> for OMAP36xx and OMAP4xxx.
> 
> For OMAP36xx and OMAP4xxx devices, DPLLs fint range is 0.5MHz to
> 2.5MHz for j-type DPLLs and otherwise it is 32KHz to 52MHz for all
> other DPLLs.
> 
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>

This looks okay to me for now - queued for 3.2.  Ideally we would move the 
Fint DPLL data to the struct dpll_data, but this would be a fairly 
significant undertaking, since we don't have a clean way to use different 
dpll_data for different OMAP3 variants.  Something good to keep in mind 
for the common clock conversion.


thanks, 

- Paul
