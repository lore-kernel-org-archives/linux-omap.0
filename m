From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2 2/2] omap3sdp: clean regulator supply mapping in
 board file
Date: Thu, 3 Feb 2011 14:54:38 +0200
Message-ID: <20110203125438.GC28607@legolas.emea.dhcp.ti.com>
References: <1296737122-20765-1-git-send-email-rnayak@ti.com>
 <1296737122-20765-2-git-send-email-rnayak@ti.com>
 <1296737122-20765-3-git-send-email-rnayak@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:50204 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756306Ab1BCMyn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Feb 2011 07:54:43 -0500
Received: by mail-fx0-f50.google.com with SMTP id 14so1191583fxm.23
        for <linux-omap@vger.kernel.org>; Thu, 03 Feb 2011 04:54:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1296737122-20765-3-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org, balbi@ti.com

On Thu, Feb 03, 2011 at 06:15:22PM +0530, Rajendra Nayak wrote:
> clean the regulator supply mapping data in the 3430sdp
> board file (which is spread all over) by moving all
> of them together.
> Also use the REGULATOR_SUPPLY macro and remove instances
> of mapping dev pointers at run time.
> Additonally define all regulator_consumer_supply as
> array's and use ARRAY_SIZE macro to define
> num_consumer_supplies.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>

Reviewed-by: Felipe Balbi <balbi@ti.com>

-- 
balbi
