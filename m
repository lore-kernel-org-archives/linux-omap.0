From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv4 1/6] ARM: OMAP3 PM: correct enable/disable of daisy io
 chain
Date: Mon, 5 Mar 2012 19:59:40 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1203051953580.6649@utopia.booyaka.com>
References: <1330701475-22576-1-git-send-email-t-kristo@ti.com> <1330701475-22576-2-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:53798 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964921Ab2CFC7l (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Mar 2012 21:59:41 -0500
In-Reply-To: <1330701475-22576-2-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mohan V <mohanv@ti.com>, Vishwanath BS <vishwanath.bs@ti.com>, Tero Kristo <t-kristo@ti.com>, rnayak@ti.com
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org


cc'ing Nilesh, Rajendra

Hi

On Fri, 2 Mar 2012, Tero Kristo wrote:

> From: Mohan V <mohanv@ti.com>
> 
> Currently the enabling and disabling of IO Daisy chain is not
> according to the TRM. The below steps are followed to enable/
> disable the IO chain according to the "Sec 3.5.7.2.2
> I/O Wake-Up Mechanism" in OMAP3630 Public TRM[1].
> 
> Steps to enable IO chain:
> [a] Set PM_WKEN_WKUP.EN_IO bit
> [b] Set the PM_WKEN_WKUP.EN_IO_CHAIN bit
> [c] Poll for PM_WKST_WKUP.ST_IO_CHAIN.
> [d] When ST_IO_CHAIN bit set to 1, clear PM_WKEN_WKUP.EN_IO_CHAIN

Looking at the above TRM section, it doesn't mention clearing 
PM_WKEN_WKUP.EN_IO_CHAIN at all.  This only seems to be mentioned (in a 
rather unclear way) in the OMAP4430 TRM.

Since Tero and Rajendra are reporting that this series works, I assume 
that the conclusion is that this patch description just needs to be fixed.  
Could someone confirm that this is indeed the case -- that I/O wakeups are 
expected to work when EN_IO_CHAIN/WUCLK_CTRL is 0?

Is the I/O wakeup path from the pad to the PRCM wakeup line completely 
asynchronous?


- Paul
