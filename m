From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [REVIEW PATCH 04/14] OMAP: CAM: Add ISP Front end
Date: Mon, 15 Dec 2008 19:24:32 +0200
Message-ID: <20081215172432.GG23324@frodo>
References: <A24693684029E5489D1D202277BE894415E6E198@dlee02.ent.ti.com> <20081215161240.GQ10664@atomide.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:46187 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754848AbYLORYk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Dec 2008 12:24:40 -0500
Content-Disposition: inline
In-Reply-To: <20081215161240.GQ10664@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "video4linux-list@redhat.com" <video4linux-list@redhat.com>, Sakari Ailus <sakari.ailus@nokia.com>, "Tuukka.O Toivonen" <tuukka.o.toivonen@nokia.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "Nagalla, Hari" <hnagalla@ti.com>

On Mon, Dec 15, 2008 at 08:12:41AM -0800, Tony Lindgren wrote:
> You should not need cpu_is_omapXXXX() macros in the drivers. Please
> set up the configuration in platform_data.
> 
> Also, please pass the IORESOURCE from platform_data, and then ioremap
> it in the driver. That way you can use __raw_read/write instead of
> __omap_read/write.

just one reminder. IORESOURCE_* goes via struct resource. Then you use
res = platform_get_resource(pdev, IORESOURCE_MEM, 0); and ioremap()
afterwards.

Similar should be done for the IRQ, but using IORESOURCE_IRQ and
platform_get_irq(pdev, 0);

-- 
balbi
