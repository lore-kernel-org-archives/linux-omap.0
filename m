From: Felipe Balbi <balbi@ti.com>
Subject: Re: [patch-v2.6.39 6/7] OMAP4430: hwmod data: Adding USBOTG
Date: Thu, 17 Feb 2011 18:31:06 +0200
Message-ID: <20110217163106.GB13425@legolas.emea.dhcp.ti.com>
References: <1297946466-9565-1-git-send-email-balbi@ti.com>
 <1297946466-9565-7-git-send-email-balbi@ti.com>
 <4D5D25F9.8030907@ti.com>
 <20110217151527.GL22356@legolas.emea.dhcp.ti.com>
 <20110217151804.GM22356@legolas.emea.dhcp.ti.com>
 <4D5D3D0B.8090106@ti.com>
 <20110217152648.GO22356@legolas.emea.dhcp.ti.com>
 <20110217162157.GQ20795@atomide.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:41672 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755373Ab1BQQbO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Feb 2011 11:31:14 -0500
Received: by mail-bw0-f42.google.com with SMTP id 13so4117965bwz.15
        for <linux-omap@vger.kernel.org>; Thu, 17 Feb 2011 08:31:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110217162157.GQ20795@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, "Kalliguddi, Hema" <hemahk@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>

On Thu, Feb 17, 2011 at 08:21:57AM -0800, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [110217 07:25]:
> > 
> > Tony, what do you prefer ? Do we clear out the dependency, or you queue
> > all the patches I have manually ??
> 
> Let's apply Benoit's hwmod data patches first into omap-for-linus,
> then rebasing other patches to that should be trivial and I can
> pull in your patches.

ok, let me know and I'll rebase on top of omap-for-linus.

-- 
balbi
