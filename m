From: Tony Lindgren <tony@atomide.com>
Subject: Re: Conflict in irqs.h
Date: Fri, 11 Dec 2009 17:13:42 -0800
Message-ID: <20091212011342.GK24013@atomide.com>
References: <2256F256009DAA4CBE661E9F41EAC84B88A174F9@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:53679 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759208AbZLLBNi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Dec 2009 20:13:38 -0500
Content-Disposition: inline
In-Reply-To: <2256F256009DAA4CBE661E9F41EAC84B88A174F9@dlee01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Candelaria Villareal, Jorge" <x0107209@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Candelaria Villareal, Jorge <x0107209@ti.com> [091211 17:08]:
> Hi,
> 
> I am trying to get some patches pushed upstream. These patches are for OMAP4 McPDM driver and concern both linux-omap and alsa trees IMO. One of the patches (attached) modifies irqs.h to add McPDM irq number. The problem is irqs.h file is in a different path and the patches apply differently in each tree.
> 
> I was planning on sending the set to both alsa and linux-omap list, but there will be a conflict for your linux-omap tree. Is there a procedure to follow in these cases?
> 
> I have also considered sending two different sets of patches individually: one to you and the other to Mark Brown. 
> 
> Can you advice?

Do all the patches against the current mainline kernel,
other trees will eventually sync against that. If it's
a patch against some code not yet in mainline, please
do it against current omap-for-linus branch in the 
linux-omap tree.

Regards,

Tony
