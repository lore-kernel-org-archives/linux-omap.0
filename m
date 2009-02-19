From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 0/5] [RESEND] lm8323 patches
Date: Thu, 19 Feb 2009 22:32:52 +0200
Message-ID: <20090219203251.GG20723@frodo>
References: <1235046583-29696-1-git-send-email-me@felipebalbi.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:40214 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751770AbZBSUc5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Feb 2009 15:32:57 -0500
Content-Disposition: inline
In-Reply-To: <1235046583-29696-1-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com

On Thu, Feb 19, 2009 at 02:29:38PM +0200, Felipe Balbi wrote:
> Hi Tony,
> 
> the final version is already going to mainline via linux-input,
> you might wanna apply these to l-o to avoid conflicts later.

mainline had a few comments to this driver which will come as an extra
cleanup patch since there's no functionality change, only style changes
so far.

These should be safe to apply.

-- 
balbi
