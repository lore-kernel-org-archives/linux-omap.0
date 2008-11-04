From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCHv2 1/2] musb: NAK timeout scheme on bulk reserved ep
Date: Tue, 4 Nov 2008 14:40:20 +0200
Message-ID: <20081104124020.GG28087@gandalf.research.nokia.com>
References: <1225800970-23936-1-git-send-email-ajay.gupta@ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:28034 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751520AbYKDMkk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Nov 2008 07:40:40 -0500
Content-Disposition: inline
In-Reply-To: <1225800970-23936-1-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Ajay Kumar Gupta <ajay.gupta@ti.com>
Cc: --to@india.ti.com, linux-omap@vger.kernel.org, david-b@pacbell.net, felipe.balbi@nokia.com, Ravi Babu <ravibabu@ti.com>, Swaminathan S <swami.iyer@ti.com>, Thomas Abraham <t-abraham@ti.com>

On Tue, Nov 04, 2008 at 05:46:10PM +0530, Ajay Kumar Gupta wrote:
> Fixes endpoint starvation issue when more than one bulk qhs
> are multiplexed on reserved bulk endpoint.NAK timeout interval
> is set for such qhs and next qh is scheduled when NAK timeout
> occurs.
> This scheme doesn't work for devices which are connected to a
> high to full speed tree as there is no NAK timeout interrupt
> at musb controller from such devices.

applied, thanks

-- 
balbi
