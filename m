From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] cbus-tahvo-usb: Fix struct tahvo_usb memory leak on
 exit
Date: Thu, 10 Mar 2011 10:56:33 +0200
Message-ID: <20110310085632.GA2279@legolas.emea.dhcp.ti.com>
References: <1299694140.1911.11.camel@marge>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:55585 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751403Ab1CJI4k (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Mar 2011 03:56:40 -0500
Received: by ewy5 with SMTP id 5so381331ewy.6
        for <linux-omap@vger.kernel.org>; Thu, 10 Mar 2011 00:56:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1299694140.1911.11.camel@marge>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michael Buesch <mb@bu3sch.de>
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, linux-omap <linux-omap@vger.kernel.org>

On Wed, Mar 09, 2011 at 07:09:00PM +0100, Michael Buesch wrote:
> The struct tahvo_usb must be free'd on remove.
> 
> Signed-off-by: Michael Buesch <mb@bu3sch.de>

Acked-by: Felipe Balbi <balbi@ti.com>

-- 
balbi
