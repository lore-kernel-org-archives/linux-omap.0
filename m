From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: Re: FW: [PATCH 00/05] 34XX cpu idle patches - core off
Date: Mon, 30 Jun 2008 17:47:50 +0300
Message-ID: <20080630144749.GF4379@codecarver.research.nokia.com>
References: <008101c8d091$27d64bd0$68bf18ac@ent.ti.com> <20080619114823.GB4953@codecarver.research.nokia.com> <001d01c8d203$5cac7500$68bf18ac@ent.ti.com> <20080619120507.GC4953@codecarver.research.nokia.com> <001e01c8d205$a89ed4b0$68bf18ac@ent.ti.com> <20080623144018.GC4468@codecarver.research.nokia.com> <008201c8d84d$0577d540$68bf18ac@ent.ti.com> <20080630104345.GC4379@codecarver.research.nokia.com> <13B9B4C6EF24D648824FF11BE8967162035BB6ED25@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:26513 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751128AbYF3OsG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Jun 2008 10:48:06 -0400
Content-Disposition: inline
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162035BB6ED25@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Woodruff, Richard" <r-woodruff2@ti.com>
Cc: "Nayak, Rajendra" <rnayak@ti.com>, "igor.stoppa@nokia.com" <igor.stoppa@nokia.com>, "Sawant, Anand" <sawant@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> If by responsiveness it is meant slowness of output (tx path) that' likely good news.  It means your hitting interconnect clock stop often and thus getting into first large active mode savings state.  This is the biggest step power drop for active states.  If your UART looks good you probably are not hitting target states enough from idle.
> 
> The UART's TX logic is not currently hooked into the wake up mechanism from clockstop (domain INACTIVE but ON, only RX an external IO events).  As such to get good speed you need go to no-idle if there is TX work queued else you won't see TX interrupt events until the next wake up period, likely from GPTIMER0 at dynamic tick rate.
> 
> * Expect to loose the 1st character on debug console as a wake up event.  Unless you use RTS/CTS (configured as wakeups) as an early wake up path, you will lose the start bit when the system restarts.  For things like bluetooth or other the protocol should re-transmit.
> 
> If you mean your not waking that's something else.
> 

AFAIC it's not waking. Even when using keyboard autorepeat to send
spaces or enter, nothing happens.

Cheers,

Peter.



-- 
goa is a state of mind
