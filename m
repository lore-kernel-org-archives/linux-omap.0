From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: vdds_dsi doesn't exist on all omap3430 arch chip
Date: Thu, 04 Mar 2010 12:37:20 +0200
Message-ID: <1267699040.2406.115.camel@tubuntu.research.nokia.com>
References: <4B8F8B76.9050807@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:19579 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751127Ab0CDKh6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Mar 2010 05:37:58 -0500
In-Reply-To: <4B8F8B76.9050807@windriver.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext stanley.miao" <stanley.miao@windriver.com>
Cc: "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Thu, 2010-03-04 at 11:29 +0100, ext stanley.miao wrote:
> Hi, Tomi,
> 
> The commit below:
> http://www.gitorious.org/linux-omap-dss2/linux/commit/ec70668fa99b2dd0d305fbdb451a728f2e2a4c58
> doesn't apply to ti_omap_am3517. There is no "vdds_dsi" on am3517.

DSS hardware seems to require vdds_dsi power on OMAP3 chips. You need to
add it to the board file's regulator configuration. Or do you mean that
on am3517 there's no power connected to OMAP's vdds_dsi line?

 Tomi


