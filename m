From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: Re: [PATCH 04/09] OMAP PM srf implementation
Date: Tue, 15 Jul 2008 15:31:38 +0300
Message-ID: <20080715123138.GA4421@codecarver.research.nokia.com>
References: <030b01c8e0ef$46c859c0$68bf18ac@ent.ti.com> <20080714132909.GA4639@codecarver.research.nokia.com> <025001c8e5c1$93e534e0$68bf18ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:53184 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756280AbYGOMb7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Jul 2008 08:31:59 -0400
Content-Disposition: inline
In-Reply-To: <025001c8e5c1$93e534e0$68bf18ac@ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org

Hi Rajendra,

> 
> Yes, I probably was using an older omap-pm-noop patch from Paul. 
> I did not refresh it since, the later one sent was again not the final one.
> I though I would refresh it once the final version is posted.
> 
> Paul,
> Would you be posting another version of this with changes as suggested 
> by Jouni? 
> 

Rereading the mails about this function, it seems to me as the original
proposal was to use struct bus_type *, but then Paul proposed to use the
agent_id.

Cheers,

Peter.

-- 
goa is a state of mind
