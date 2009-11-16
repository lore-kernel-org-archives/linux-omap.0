From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] omap3: ehci: Add regulator framework
Date: Mon, 16 Nov 2009 15:13:38 +0000
Message-ID: <20091116151338.GB20513@opensource.wolfsonmicro.com>
References: <1258274748-28053-1-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:45072 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752731AbZKPPNd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Nov 2009 10:13:33 -0500
Content-Disposition: inline
In-Reply-To: <1258274748-28053-1-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ajay Kumar Gupta <ajay.gupta@ti.com>
Cc: linux-omap@vger.kernel.org, felipe.balbi@nokia.com

On Sun, Nov 15, 2009 at 02:15:48PM +0530, Ajay Kumar Gupta wrote:
> Adding regulator framework in EHCI driver.
> 
> OMAP3 has three HS USB ports so it can have three different regulator
> for each PHY connected to each port.
> 
> Currently these regulators are assumed to be optional and driver doesn't
> fail but continue with the initialization if it doesn't get any regulators.
> 
> Regulator supply names has to be mapped in board files as 'hsusbN' where
> 'N' is port number and can be {0, 1 ,2}.
> 
> Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>

This looks OK from a regulator API point of view.
