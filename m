From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] cbus-tahvo-usb: Initialize the used clock
Date: Thu, 10 Mar 2011 11:00:37 +0200
Message-ID: <20110310090036.GB2279@legolas.emea.dhcp.ti.com>
References: <1299694442.1911.16.camel@marge>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:46381 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751456Ab1CJJAm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Mar 2011 04:00:42 -0500
Received: by ewy19 with SMTP id 19so512068ewy.31
        for <linux-omap@vger.kernel.org>; Thu, 10 Mar 2011 01:00:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1299694442.1911.16.camel@marge>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michael Buesch <mb@bu3sch.de>
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, linux-omap <linux-omap@vger.kernel.org>

On Wed, Mar 09, 2011 at 07:14:02PM +0100, Michael Buesch wrote:
> usb_l4_ick is used by the USB. Request and enable it.
> Without this, all register accesses just return garbage
> due to the device not being clocked.
> 
> This also cleans up the error path of the probe function
> while we're at it.
> 
> Signed-off-by: Michael Buesch <mb@bu3sch.de>

looks good.

Acked-by: Felipe Balbi <balbi@ti.com>

-- 
balbi
