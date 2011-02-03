From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 2/2] omap3sdp: clean regulator supply mapping in board
 file
Date: Thu, 3 Feb 2011 14:03:01 +0200
Message-ID: <20110203120301.GL23561@legolas.emea.dhcp.ti.com>
References: <1296732705-12818-1-git-send-email-rnayak@ti.com>
 <1296732705-12818-2-git-send-email-rnayak@ti.com>
 <1296732705-12818-3-git-send-email-rnayak@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:56974 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756331Ab1BCMDG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Feb 2011 07:03:06 -0500
Received: by fxm12 with SMTP id 12so1073856fxm.28
        for <linux-omap@vger.kernel.org>; Thu, 03 Feb 2011 04:03:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1296732705-12818-3-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org

On Thu, Feb 03, 2011 at 05:01:45PM +0530, Rajendra Nayak wrote:
> clean the regulator supply mapping data in the 3430sdp
> board file (which is spread all over) by moving all
> of them together.
> Also use the REGULATOR_SUPPLY macro and remove instances
> of mapping dev pointers at run time.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>

same comment is valid for this patch.

-- 
balbi
