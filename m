From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH/PM] arm: omap: musb: proper error checking
Date: Wed, 19 May 2010 12:09:58 +0300
Message-ID: <20100519090958.GM12879@nokia.com>
References: <1274251376-6111-1-git-send-email-felipe.balbi@nokia.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:27918 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751931Ab0ESJMS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 May 2010 05:12:18 -0400
Content-Disposition: inline
In-Reply-To: <1274251376-6111-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Wed, May 19, 2010 at 08:42:56AM +0200, Balbi Felipe (Nokia-D/Helsinki) wrote:
>From: Felipe Balbi <felipe.balbi@nokia.com>
>
>We need to clk_put() and iounmap() to fully release
>the resources.
>
>Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
>---
>
>applies on top of the linux-omap/pm

I'll add more patches, Kevin don't take this yet.

-- 
balbi

DefectiveByDesign.org
