From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 1/3] i2c: lp5521: remove dead code
Date: Mon, 6 Oct 2008 13:02:10 +0300
Message-ID: <20081006100210.GI7437@gandalf.research.nokia.com>
References: <1223284291-7675-1-git-send-email-felipe.balbi@nokia.com> <1223284291-7675-2-git-send-email-felipe.balbi@nokia.com> <20081006094722.GA23994@intune.research.nokia.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:48420 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752209AbYJFKCa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Oct 2008 06:02:30 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m96A29R5017804
	for <linux-omap@vger.kernel.org>; Mon, 6 Oct 2008 13:02:27 +0300
Content-Disposition: inline
In-Reply-To: <20081006094722.GA23994@intune.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Stone <daniel.stone@nokia.com>
Cc: ext Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org, Mathias Nyman <mathias.nyman@nokia.com>

On Mon, Oct 06, 2008 at 12:47:22PM +0300, Daniel Stone wrote:
> On Mon, Oct 06, 2008 at 12:11:29PM +0300, ext Felipe Balbi wrote:
> > That LED_CONNECTED_WRONG was never defined so removing.
> > If someone needs those hooks, add back via proper
> > platform_data instead of nasty ifdefery.
> > 
> > Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> 
> Signed-off-by: Daniel Stone <daniel.stone@nokia.com>
> 
> IIRC, LED_CONNECTED_WRONG was only for early hardware builds of the
> N810.

yeah and it's really weird to keep that since it was a bad hw mistake
:-p

-- 
balbi
