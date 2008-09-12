From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH]Enable 4-bit in HSMMC1 and HSMMC2 platform data
Date: Fri, 12 Sep 2008 11:04:54 +0300
Message-ID: <20080912080454.GA9387@gandalf.research.nokia.com>
References: <62710.192.168.10.89.1218608010.squirrel@dbdmail.itg.ti.com> <20080910235646.GV21163@atomide.com> <20080911084828.GC26078@flint.arm.linux.org.uk> <20080911091309.GD26078@flint.arm.linux.org.uk> <20080911173333.GI21163@atomide.com> <20080911181312.GC4986@flint.arm.linux.org.uk> <5e088bd90809111418w3efb3538gd4cd497e6d10c367@mail.gmail.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:20643 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752281AbYILIFW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Sep 2008 04:05:22 -0400
Content-Disposition: inline
In-Reply-To: <5e088bd90809111418w3efb3538gd4cd497e6d10c367@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Steve Sakoman <sakoman@gmail.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Madhusudhan Chikkature <madhu.cr@ti.com>, linux-omap@vger.kernel.org

On Thu, Sep 11, 2008 at 02:18:38PM -0700, ext Steve Sakoman wrote:
> On Thu, Sep 11, 2008 at 11:13 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> 
> > Is there anything else that the MMC stuff is missing at present?
> 
> Not an answer to your question, but perhaps an expansion of it (or
> maybe even a demonstration of my ignorance, not sure which)   :-)
> 
> Has anyone successfully used the omap mmc infrastructure to support an
> SDIO device (say for example the libertas_sdio driver)?

I used a sdio gps with my n800. Had to break the slot cover though :-p

-- 
balbi
