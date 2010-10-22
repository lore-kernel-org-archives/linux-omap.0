From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 2/5] arm: omap: counter-32k: convert to pm_runtime API
Date: Fri, 22 Oct 2010 09:31:03 +0300
Message-ID: <20101022063103.GB3958@legolas.emea.dhcp.ti.com>
References: <1287480136-2046-1-git-send-email-balbi@ti.com>
 <1287480136-2046-3-git-send-email-balbi@ti.com>
 <87k4lbzbfg.fsf@deeprootsystems.com>
 <20101021190623.GV3958@legolas.emea.dhcp.ti.com>
 <87zku7s3kk.fsf@deeprootsystems.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35134 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751594Ab0JVGbH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Oct 2010 02:31:07 -0400
Content-Disposition: inline
In-Reply-To: <87zku7s3kk.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Thu, Oct 21, 2010 at 03:17:47PM -0500, Kevin Hilman wrote:
>You're right, I wasn't as picky about this before, but will be going
>forward.  You're the lucky first victim. :)

someone has to be stoned first. Hmm, that does sound ambiguous.

>Replacing clk_disable() with put_sync() is the correct functional
>replacement, since clk_disable is immediate, ans so is put_sync.
>However, since we have the option of a delayed disable now with runtime
>PM, I think we should use it.

makes sense. I'll work on it during next week.

-- 
balbi
