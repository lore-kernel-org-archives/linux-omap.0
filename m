From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: Re: [PATCH 0/1] Do a warm reboot instead of a cold reboot
Date: Tue, 3 Feb 2009 12:31:13 +0200
Message-ID: <20090203103113.GB4709@codecarver.research.nokia.com>
References: <1233594624-21615-1-git-send-email-peter.de-schrijver@nokia.com> <87hc3b4zob.fsf@trdhcp146196.ntc.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:28638 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751358AbZBCKbl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Feb 2009 05:31:41 -0500
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n13AVKZB009639
	for <linux-omap@vger.kernel.org>; Tue, 3 Feb 2009 04:31:39 -0600
Content-Disposition: inline
In-Reply-To: <87hc3b4zob.fsf@trdhcp146196.ntc.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hogander Jouni (Nokia-D/Tampere)" <jouni.hogander@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Jouni,

> "De-Schrijver Peter (Nokia-D/Helsinki)" <Peter.De-Schrijver@nokia.com>
> writes:
> 
> > This patch makes arch_reset do a warm reboot instead of a cold reboot. This
> > is necessary because otherwise the system does not reboot reliably when disabling
> > CLKEN in retention.
> >
> > Note : Unfortuately this breaks retention :( IVA2, PER and CORE don't go to
> >        retention after reboot.
> 
> I'm not sure if fixing the problem this way makes sense
> currently. This will mean that after reboot OMAP modules are not
> reset. This will cause excactly this kind of problems. If we had that
> code for reset all the modules on boot, situation might be different.
> 
> How about "resetting" also twl4030 in case of reboot. E.g. remove all
> the scripts from the twl4030?
> 

Even then we should be using warm reboot. The fact cold reboot works has
been more luck then anything else. How hard is it to fix the module
reset on boot ? And what does a OMAP watchdog reboot do ?

Cheers,

Peter.

-- 
goa is a state of mind
