From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v3 4/5] OMAP: mailbox: send message in process context
Date: Fri, 19 Nov 2010 10:34:07 +0200
Message-ID: <20101119083407.GJ6446@legolas.emea.dhcp.ti.com>
References: <1290107742-16760-1-git-send-email-h-kanigeri2@ti.com>
 <1290107742-16760-5-git-send-email-h-kanigeri2@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44470 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750887Ab0KSIeD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Nov 2010 03:34:03 -0500
Content-Disposition: inline
In-Reply-To: <1290107742-16760-5-git-send-email-h-kanigeri2@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hari Kanigeri <h-kanigeri2@ti.com>
Cc: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, linux omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>

Hi,

On Thu, Nov 18, 2010 at 01:15:41PM -0600, Hari Kanigeri wrote:
>Schedule the Tasklet to send only when mailbox fifo is full and there are
>pending messages in kifo, else send the message directly in the Process
		     ^kfifo

-- 
balbi
