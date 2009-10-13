From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: Re: Broken cpuidle on PM branch?
Date: Tue, 13 Oct 2009 16:31:51 +0300
Message-ID: <20091013133151.GA8028@esdhcp037198.research.nokia.com>
References: <20091012192347.GI32041@smtp.gmail.com>
Reply-To: eduardo.valentin@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:58153 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752247AbZJMNdY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Oct 2009 09:33:24 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx06.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n9DDVqnf003315
	for <linux-omap@vger.kernel.org>; Tue, 13 Oct 2009 16:31:54 +0300
Content-Disposition: inline
In-Reply-To: <20091012192347.GI32041@smtp.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello Amit,

On Mon, Oct 12, 2009 at 09:23:47PM +0200, ext Amit Kucheria wrote:
> Hi,
> 
> I am testing twl4030 script optimisations on the current PM branch. But I am
> seeing the board (RX51) freeze when CPU_IDLE is enabled in the config.
> 
> Is it known to work on other boards?

I'm actually seeing this same behavior. But the board actually does not
freeze. If you keep a key pressed of send a sysrq through serial line
then you eventually get it back.

It seams to be something related to serial driver and wakeup ?


> 
> Regards,
> Amit
> -- 
> -------------------------------------------------------------------------
> Amit Kucheria,				 Kernel Developer, Verdurent
> -------------------------------------------------------------------------
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Eduardo Valentin
