From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH] ehci: fix ehci pin mux init
Date: Fri, 3 Jul 2009 13:47:15 +0300
Message-ID: <20090703104715.GA4323@nokia.com>
References: <1246617561-8644-1-git-send-email-ajay.gupta@ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:64525 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752045AbZGCKrt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Jul 2009 06:47:49 -0400
Content-Disposition: inline
In-Reply-To: <1246617561-8644-1-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Ajay Kumar Gupta <ajay.gupta@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>

On Fri, Jul 03, 2009 at 12:39:21PM +0200, ext Ajay Kumar Gupta wrote:
> EHCI pin mux init fucntion is still using old #ifdef
> which are not defined anymore.This causes pin mux init to
> always set TLL settings and thus EHCI PHY mode doesn't work.
> 
> Fixing this issue by using phy_mode parameter to initialize
> mux settings.
> 
> Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>

Acked-by: Felipe Balbi <felipe.balbi@nokia.com>

-- 
balbi
