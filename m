From: Felipe Balbi <balbi@ti.com>
Subject: Re: Nokia n810 LCD (MIPID/blizzard) on 2.6.38
Date: Tue, 1 Mar 2011 11:20:57 +0200
Message-ID: <20110301092057.GA2942@legolas.emea.dhcp.ti.com>
References: <1298925943.16391.19.camel@marge>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:52143 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753313Ab1CAJVB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Mar 2011 04:21:01 -0500
Received: by mail-bw0-f50.google.com with SMTP id 2so4009314bwz.9
        for <linux-omap@vger.kernel.org>; Tue, 01 Mar 2011 01:21:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1298925943.16391.19.camel@marge>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michael Buesch <mb@bu3sch.de>
Cc: linux-omap <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, Varadarajan Charulatha <charu@ti.com>

On Mon, Feb 28, 2011 at 09:45:43PM +0100, Michael Buesch wrote:
> The n810 LCD does not work on the 2.6.38(-rc6) kernel
> due to changes in the OMAP GPIO-hwmod code.
> 
> The hwmod code performs a soft-reset on the GPIO
> module. The first GPIO module carries the MIPID
> "nreset" line, which is toggled due to the hwmod soft reset.
> This resets Blizzard and breaks it, because
> it assumes the LCD was left in the state that the
> bootloader initialized it to:

so that's the bug which needs to be fixed. Unfortunately I don't have
any documentation available anymore. Maybe someone from Nokia would fix
that ?

> I'm wondering if a better fix suitable for the mainline
> kernel inclusion could be found.
> Any ideas?

Don't depend on the bootloader :-)

-- 
balbi
