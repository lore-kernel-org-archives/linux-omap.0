From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 6/9 v3] usb: musb: HWMOD database structures addition
 for OMAP2430
Date: Thu, 23 Sep 2010 09:21:54 +0300
Message-ID: <20100923062154.GC2563@legolas.emea.dhcp.ti.com>
References: <1285201795-26478-1-git-send-email-hemahk@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38111 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750731Ab0IWGWC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Sep 2010 02:22:02 -0400
Content-Disposition: inline
In-Reply-To: <1285201795-26478-1-git-send-email-hemahk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kalliguddi, Hema" <hemahk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "Balbi, Felipe" <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

On Wed, Sep 22, 2010 at 07:29:55PM -0500, Kalliguddi, Hema wrote:
>OMAP2430 hwmod data stuctures are populated with base address, L3 and L4
>interface clocks, IRQs,and sysconfig register details.
>
>Signed-off-by: Hema HK <hemahk@ti.com>
>Cc: Felipe Balbi <balbi@ti.com>
>Cc: Tony Lindgren <tony@atomide.com>
>Cc: Kevin Hilman <khilman@deeprootsystems.com>
>Cc: Cousson, Benoit <b-cousson@ti.com>
>Cc: Paul Walmsley <paul@pwsan.com>

looks like this should come before patch 5.

-- 
balbi
