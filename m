From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] arm: omap4: panda: remove usb_nop_xceiv_register(v1)
Date: Wed, 2 Feb 2011 13:37:17 +0200
Message-ID: <20110202113717.GC5370@legolas.emea.dhcp.ti.com>
References: <1294236201-4114-1-git-send-email-tom.leiming@gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:44529 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753446Ab1BBLhZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Feb 2011 06:37:25 -0500
Received: by gxk5 with SMTP id 5so3015079gxk.28
        for <linux-omap@vger.kernel.org>; Wed, 02 Feb 2011 03:37:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1294236201-4114-1-git-send-email-tom.leiming@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tom.leiming@gmail.com
Cc: tony@atomide.com, khilman@deeprootsystems.com, linux-omap@vger.kernel.org, arm-kernel@lists.infradead.org

Tony,

On Wed, Jan 05, 2011 at 10:03:21PM +0800, tom.leiming@gmail.com wrote:
> From: Ming Lei <tom.leiming@gmail.com>
> 
> Panda uses both twl6030 otg phy(vbus, id) and internal
> phy(data lines, DP/DM), so removes usb_nop_xceiv_register to make
> twl6030 otg driver working since current otg code only supports
> one global transceiver. Otherwise, musb doesn't work without
> the remove.
> 
> Reviewd-by: Felipe Balbi <balbi@ti.com>
> Signed-off-by: Ming Lei <tom.leiming@gmail.com>

Care to queue this together with your fixes

-- 
balbi
