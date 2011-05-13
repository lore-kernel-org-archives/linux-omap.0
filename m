From: Archit Taneja <archit@ti.com>
Subject: Re: DSS2: Simultaneous DSI and DPI panels
Date: Fri, 13 May 2011 16:14:52 +0530
Message-ID: <4DCD0BA4.2050904@ti.com>
References: <BANLkTi=1XZyu6hQq7RLxcjQ0WZ8neGbNcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54739 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753372Ab1EMKkH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 May 2011 06:40:07 -0400
In-Reply-To: <BANLkTi=1XZyu6hQq7RLxcjQ0WZ8neGbNcQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Juha Kuikka <juha.kuikka@gmail.com>
Cc: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

Hi,

On Friday 13 May 2011 12:46 AM, Juha Kuikka wrote:
> Hello,
>
> I was wondering if it would be possible to run DPI and DSI interfaces
> simultaneously with OMAP3 (DM3730).
>
> Limitations:
> - DSI would have to be in video mode (data to DSI phy through video
> port with H/VSYNC signaling, OMAP_DSS_PARALLELMODE_BYPASS)
> - DSI PLL would need to be used for clock source
> - Both the DPI and DSI panels would have to accept identical clocking
> (PCLK, blanking intervals etc).
> - Data lane # must match.
> - And of course same data would go to both
>
> I realize the current SW does not support this, but I'm more wondering
> if it is possible from the HW point of view because it seems to me
> that data out from DISPC is pretty much identical in both cases.

I don't think this is possible on OMAP3, there is one LCD manager in 
OMAP3 which can either feed pixels to DPI or DSI.

The only way you could run 2 panels is by routing LCD manager's content 
to DPI, and use DSI's capability to do a system DMA directly and send 
the data to the panel(bypassing DISPC), I don't think the system DMA 
method will work with a video mode panel, only command mode panels will 
do here.

Archit
>
>   - Juha
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

