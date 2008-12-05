From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: Re: [PATCH 1/1] Save sram context after changing MPU, DSP or core
	clocks
Date: Fri, 5 Dec 2008 13:16:34 +0200
Message-ID: <20081205111634.GA4652@codecarver.research.nokia.com>
References: <1227095127-7158-1-git-send-email-peter.de-schrijver@nokia.com> <1227095127-7158-2-git-send-email-peter.de-schrijver@nokia.com> <B71CE868F2BC2847B3F23C5A8EE39430DF9821@vaebe110.NOE.Nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:28904 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750852AbYLELQy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Dec 2008 06:16:54 -0500
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id mB5BGVMd014131
	for <linux-omap@vger.kernel.org>; Fri, 5 Dec 2008 13:16:50 +0200
Content-Disposition: inline
In-Reply-To: <B71CE868F2BC2847B3F23C5A8EE39430DF9821@vaebe110.NOE.Nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kristo Tero (Nokia-D/Tampere)" <Tero.Kristo@nokia.com>
Cc: linux-omap@vger.kernel.org

On Fri, Dec 05, 2008 at 11:49:03AM +0200, Kristo Tero (Nokia-D/Tampere) wrote:
> Hi Peter,
> 
> This patch causes linker error without CONFIG_PM option, should add
> #ifdef:s around the call to omap3_save_scratchpad_contents();
> 

That looks a bit ugly though :(

Cheers,

Peter

-- 
goa is a state of mind
