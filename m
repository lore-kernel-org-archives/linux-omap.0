From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: Re: FW: [PATCH 00/05] 34XX cpu idle patches - core off
Date: Mon, 30 Jun 2008 13:43:45 +0300
Message-ID: <20080630104345.GC4379@codecarver.research.nokia.com>
References: <008101c8d091$27d64bd0$68bf18ac@ent.ti.com> <20080619114823.GB4953@codecarver.research.nokia.com> <001d01c8d203$5cac7500$68bf18ac@ent.ti.com> <20080619120507.GC4953@codecarver.research.nokia.com> <001e01c8d205$a89ed4b0$68bf18ac@ent.ti.com> <20080623144018.GC4468@codecarver.research.nokia.com> <008201c8d84d$0577d540$68bf18ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:31983 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753790AbYF3Kod (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Jun 2008 06:44:33 -0400
Content-Disposition: inline
In-Reply-To: <008201c8d84d$0577d540$68bf18ac@ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Rajendra Nayak <rnayak@ti.com>
Cc: igor.stoppa@nokia.com, sawant@ti.com, linux-omap@vger.kernel.org

Hi Rajendra,

> 
> The patches still require some amount of cleaning, once Jouni posts his next set of workaround patches 
> taking care of the sleep dependecy for PER, I will rework/clean these patches and then send it to the 
> linux-omap list.
> 
> I am still seeing some issues with debug uart responsiveness which I am looking into. Need to see if the wakeup
> is configured properly.
> 

That's what I'm seeing here as well. OMAP goes to off mode but UART
wakeup seems to be broken. 

Thanks,

Peter.
