From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/3] OMAP: McBSP: Swap CLKS source definition
Date: Tue, 5 Oct 2010 09:11:21 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1010050910520.13816@utopia.booyaka.com>
References: <1286281775-27692-1-git-send-email-jhnikula@gmail.com> <1286281775-27692-2-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:57842 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753800Ab0JEPLW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Oct 2010 11:11:22 -0400
In-Reply-To: <1286281775-27692-2-git-send-email-jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Tue, 5 Oct 2010, Jarkko Nikula wrote:

> This is just a readability and debugging improvement. As selection bit in
> DEVCONF register is cleared when using 96 MHz PRCM source and set when using
> external CLKS pin, change definitions to be sync with these.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> Cc: Paul Walmsley <paul@pwsan.com>

Acked-by: Paul Walmsley <paul@pwsan.com>


- Paul
