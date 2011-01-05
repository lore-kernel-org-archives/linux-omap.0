From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFT/PATCH 05/10] cbus: retu: move to threaded IRQ and GENIRQ
Date: Wed, 5 Jan 2011 08:37:51 +0200
Message-ID: <20110105063751.GB2458@legolas.emea.dhcp.ti.com>
References: <1294040988-21191-1-git-send-email-balbi@ti.com>
 <1294040988-21191-6-git-send-email-balbi@ti.com>
 <20110104014002.GV7771@atomide.com>
 <20110104065229.GB2367@legolas.emea.dhcp.ti.com>
 <20110104074615.GC2656@legolas.emea.dhcp.ti.com>
 <20110104074756.GD2656@legolas.emea.dhcp.ti.com>
 <20110104191359.GH7771@atomide.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:52626 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751324Ab1AEGh4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Jan 2011 01:37:56 -0500
Received: by eyd9 with SMTP id 9so7534085eyd.36
        for <linux-omap@vger.kernel.org>; Tue, 04 Jan 2011 22:37:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110104191359.GH7771@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

Hi,

On Tue, Jan 04, 2011 at 11:14:00AM -0800, Tony Lindgren wrote:
> I think there's been some patches related to this to get rid
> of NR_IRQS? Might be worth taking a look at those first as it's
> a generic solution.

Yeah, one way would be to use Sparse IRQ numbering scheme and define
different bases for different IRQ chips. We could use for example,
something like:

IRQ	|	Chip
=====================
0-299	|	INTC
300-499	|	TWL4030
500-599	|	MENELAUS
600-799	|	RETU
800-999	|	TAHVO

and so on. But I'm not sure that's good enough (numbers are just from
the top of my head, didn't really check how many IRQs each one have).

The only problem I see is with INTC, what happens if we give it an
interval which ends up not being big enough for next OMAP versions ?

-- 
balbi
