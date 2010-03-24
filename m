From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH v3] arm: omap1/2/3/4: convert clocksource to a
 platform_driver
Date: Wed, 24 Mar 2010 08:54:42 +0200
Message-ID: <20100324065442.GB7534@nokia.com>
References: <1269346981-30147-1-git-send-email-felipe.balbi@nokia.com>
 <1269350966-9311-1-git-send-email-felipe.balbi@nokia.com>
 <87iq8mc3oc.fsf@deeprootsystems.com>
 <20100324063428.GA7534@nokia.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:20132 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753204Ab0CXGzS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Mar 2010 02:55:18 -0400
Content-Disposition: inline
In-Reply-To: <20100324063428.GA7534@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>
Cc: ext Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

Hi,

On Wed, Mar 24, 2010 at 07:34:28AM +0100, Balbi Felipe (Nokia-D/Helsinki) wrote:
>all add back the credits, missed that sorry but I believe the gp timer
>part is subject to another patch, no ? Otherwise this will start to
>become one huge unreviewable patch.

and btw, why don't we just register all clocksources and let kernel 
select the best one for us ?

-- 
balbi
