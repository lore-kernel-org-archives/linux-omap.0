From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] cbus-retu: Acquire mutex on write operation
Date: Mon, 28 Feb 2011 10:33:17 +0200
Message-ID: <20110228083317.GH2459@legolas.emea.dhcp.ti.com>
References: <1298763273.21318.5.camel@marge>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:46945 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752268Ab1B1IdV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Feb 2011 03:33:21 -0500
Received: by mail-bw0-f53.google.com with SMTP id 12so6303202bwg.40
        for <linux-omap@vger.kernel.org>; Mon, 28 Feb 2011 00:33:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1298763273.21318.5.camel@marge>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michael Buesch <mb@bu3sch.de>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

On Sun, Feb 27, 2011 at 12:34:33AM +0100, Michael Buesch wrote:
> The mutex has to be acquired on register write to avoid interference
> with a simultaneous retu_set_clear_reg_bits operation.
> 
> Signed-off-by: Michael Buesch <mb@bu3sch.de>

good catch, please do the same for retu_read_reg()

-- 
balbi
