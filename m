From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] omap4: usb: explicitly configure MUSB pads
Date: Wed, 16 Feb 2011 12:26:12 +0200
Message-ID: <20110216102612.GQ2497@legolas.emea.dhcp.ti.com>
References: <1297851135-25952-1-git-send-email-gadiyar@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:41075 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755126Ab1BPK0k (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Feb 2011 05:26:40 -0500
Received: by bwz14 with SMTP id 14so1371335bwz.16
        for <linux-omap@vger.kernel.org>; Wed, 16 Feb 2011 02:26:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1297851135-25952-1-git-send-email-gadiyar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anand Gadiyar <gadiyar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>

On Wed, Feb 16, 2011 at 03:42:15PM +0530, Anand Gadiyar wrote:
> Use the mux framework APIs to explicitly configure
> the MUSB pads. The MUSB controller in OMAP4 can use
> either the old ULPI interface, or the new internal PHY.
> Configure the pads accordingly.
> 
> Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>

applied to musb-next, will send a pull request for Tony by friday.

-- 
balbi
