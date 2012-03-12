From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCHv5 0/6] ARM: OMAP3+: IO daisy chain support fixes
Date: Mon, 12 Mar 2012 11:23:41 +0530
Message-ID: <4F5D8F65.7000205@ti.com>
References: <1331046702-2472-1-git-send-email-t-kristo@ti.com> <alpine.DEB.2.00.1203092102450.30879@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog127.obsmtp.com ([74.125.149.107]:59833 "EHLO
	psmtp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752218Ab2CLFxy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Mar 2012 01:53:54 -0400
Received: by ghbz2 with SMTP id z2so2612292ghb.34
        for <linux-omap@vger.kernel.org>; Sun, 11 Mar 2012 22:53:47 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1203092102450.30879@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org

On Saturday 10 March 2012 09:35 AM, Paul Walmsley wrote:
> The main outstanding question is whether the OMAP4 WUCLKOUT poll should be
> removed to match the v5 changes to the OMAP3 function.  Please let me
> know.   Any other testing or comments are of course welcome.

I think we should instead add it back in omap3 and keep the omap4 as is.

