From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 1/2] Revert "omap: Fix compile for early_param and
 omap_smc1"
Date: Thu, 4 Mar 2010 09:50:22 +0200
Message-ID: <20100304075022.GJ15954@nokia.com>
References: <1267688416-5998-1-git-send-email-felipe.balbi@nokia.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:48787 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753651Ab0CDHvM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Mar 2010 02:51:12 -0500
Content-Disposition: inline
In-Reply-To: <1267688416-5998-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

On Thu, Mar 04, 2010 at 08:40:15AM +0100, Balbi Felipe (Nokia-D/Helsinki) wrote:
>From: Felipe Balbi <felipe.balbi@nokia.com>
>
>This reverts commit a91741262f0ae82d651c7270bc1354016c5bb9dd.
>
>Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>

I reverted too much... __early_param() doesn't work.

-- 
balbi
