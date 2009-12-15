From: Ranjith Lohithakshan <ranjithl@ti.com>
Subject: Re: [PATCH] AM35xx: Add AM35xx specific control module registers
Date: Tue, 15 Dec 2009 13:45:43 +0530
Message-ID: <4B2745AF.3070501@ti.com>
References: <1257269870-10356-1-git-send-email-ranjithl@ti.com> <alpine.DEB.2.00.0912141525060.12561@utopia.booyaka.com> <alpine.DEB.2.00.0912141531100.12561@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52988 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758584AbZLOIPu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Dec 2009 03:15:50 -0500
In-Reply-To: <alpine.DEB.2.00.0912141531100.12561@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Paul,

On Tue, 15-Dec-09 4:03 AM +0530, Paul Walmsley wrote:
> Hi Ranjith,
> 
> one other question.
> 
> On Mon, 14 Dec 2009, Paul Walmsley wrote:
> 
>> On Tue, 3 Nov 2009, Ranjith Lohithakshan wrote:
>>
>>> AM3517/05 has a few additional control module registers defined mainly
>>> to control the new IP's. This patch adds support for those new registers.
> 
> Are these registers 3517-specific, or are they common to both AM3517 and 
> 3505?  If the latter, than please use "AM35XX" or something similar as the 
> prefix for the macros below.
> 

Yes, these are common to 3517 & 3505. I will rename these to AM35XX,
incorporate your IPSS_CLK_CTRL comment and generate a v2 version of
this patch shortly.

- Ranjith
