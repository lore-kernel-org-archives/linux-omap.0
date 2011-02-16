From: Felipe Balbi <balbi@ti.com>
Subject: Re: OMAP3 & USB NFS root
Date: Wed, 16 Feb 2011 11:49:18 +0200
Message-ID: <20110216094918.GN2497@legolas.emea.dhcp.ti.com>
References: <1297691206.2951.8.camel@deskari>
 <20110214134842.GH2549@legolas.emea.dhcp.ti.com>
 <1297692039.2951.10.camel@deskari>
 <20110214140216.GJ2549@legolas.emea.dhcp.ti.com>
 <1297838666.2031.8.camel@deskari>
 <20110216080227.GB2497@legolas.emea.dhcp.ti.com>
 <20110216080543.GD2497@legolas.emea.dhcp.ti.com>
 <1297849461.5431.3.camel@deskari>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:44637 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754055Ab1BPJtW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Feb 2011 04:49:22 -0500
Received: by mail-bw0-f41.google.com with SMTP id 16so1385803bwz.14
        for <linux-omap@vger.kernel.org>; Wed, 16 Feb 2011 01:49:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1297849461.5431.3.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Wed, Feb 16, 2011 at 11:44:21AM +0200, Tomi Valkeinen wrote:
> Perhaps I'm missing some Kconfig option.

Yes, you have a problem on your Kconfig

<snip>

> CONFIG_USB_MUSB_HDRC=y
> CONFIG_USB_MUSB_TUSB6010=y
> # CONFIG_USB_MUSB_OMAP2PLUS is not set
> # CONFIG_USB_MUSB_AM35X is not set

Since you're running on Overo, you need to use CONFIG_USB_MUSB_OMAP2PLUS
instead of CONFIG_USB_MUSB_TUSB6010. We're still working to make those
work together. Lots of re-work needs to be done on the DMA part before
we can make all of them work together.

Fix that and it should work.

-- 
balbi
