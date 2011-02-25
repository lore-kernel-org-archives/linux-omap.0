From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 5/5 v2] usb: musb: OMAP4430: Save/restore the context
Date: Fri, 25 Feb 2011 15:32:54 +0200
Message-ID: <20110225133254.GK4190@legolas.emea.dhcp.ti.com>
References: <1298640246-21181-1-git-send-email-hemahk@ti.com>
 <1298640246-21181-6-git-send-email-hemahk@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:52080 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753792Ab1BYNdC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Feb 2011 08:33:02 -0500
Content-Disposition: inline
In-Reply-To: <1298640246-21181-6-git-send-email-hemahk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hema HK <hemahk@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>

On Fri, Feb 25, 2011 at 06:54:06PM +0530, Hema HK wrote:
> Add the context save restore for the control module register
> used for OMAP4430 musb with UTMI embedded PHY interface.
> 
> Signed-off-by: Hema HK <hemahk@ti.com>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Paul Walmsley <paul@pwsan.com>

$SUBJECT is mis-leading. It's not related to MUSB, it's related to the
Internal PHY on OMAP4 ;-)

-- 
balbi
