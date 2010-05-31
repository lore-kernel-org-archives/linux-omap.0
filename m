From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH] ARM: OMAP: Fix board data to support device only, host
 only and OTG roles.
Date: Mon, 31 May 2010 12:56:37 +0300
Message-ID: <20100531095637.GF16504@nokia.com>
References: <AANLkTim7r5zq-G8iF1fxHQ9ohqfoOiuUkkMXfRYxkBQu@mail.gmail.com>
 <987022.25256.qm@web180303.mail.gq1.yahoo.com>
 <AANLkTin-Ud-BdQ3lcydqZx7Tb1YoBq05XCONeYqxWhZm@mail.gmail.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:52460 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755985Ab0EaJ5Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 31 May 2010 05:57:24 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTin-Ud-BdQ3lcydqZx7Tb1YoBq05XCONeYqxWhZm@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Grazvydas Ignotas <notasas@gmail.com>
Cc: David Brownell <david-b@pacbell.net>, Steve Sakoman <sakoman@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Maulik Mankad <x0082077@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, Tony Lindgren <tony@atomide.com>

On Mon, May 31, 2010 at 11:44:05AM +0200, ext Grazvydas Ignotas wrote:
>If a board is configured as host and driver is set to only support
>peripheral it is perfectly fine for the driver not to allow that. But
>why is the driver refusing OTG board setting if it's compiled to only
>support host/peripheral? If I apply [1], it works perfectly fine for
>me. What's wrong with degrading OTG to host/peripheral, did you really
>mean to NAK [1], David? Why can't I compile musb in a
>periperal/host-only mode if I have OTG connector?

otg depends on usb suspend, which depends on runtime pm (I guess), 
without suspend, host negotiation protocol will never work which is 
required on OTG.

I believe that was Dave's reasoning.

-- 
balbi

DefectiveByDesign.org
