From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH v3 1/3] omap: opp: add OMAP3 OPP table data and common
 init
Date: Tue, 16 Nov 2010 14:20:26 +0100
Message-ID: <20101116142026.4f4740d2@surf>
References: <[PATCH 0/3 v2] omap: opp: Add opp data>
	<1289849261-29767-2-git-send-email-nm@ti.com>
	<20101116122128.5c6cc050@surf>
	<4CE2710A.3010804@ti.com>
	<20101116134220.1bb818c0@surf>
	<4CE282CC.6070105@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:55579 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753066Ab0KPNUf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Nov 2010 08:20:35 -0500
In-Reply-To: <4CE282CC.6070105@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony <tony@atomide.com>

Hello,

On Tue, 16 Nov 2010 07:10:36 -0600
Nishanth Menon <nm@ti.com> wrote:

> I feel you may have misunderstood the code, we DONOT oblige all boards 
> to *have* to call omapX_init_opp. It is a device_initcall - so for the 
> boards that dont call it, device_initcall will trigger and initialzie 
> it. the hooks for the customization of the OPPs is in OPP layer itself.

This is exactly what I have understood.

> the need we satisfy is this: if you need to support two sets of boards:
> a) boards that are happy with the defaults - most of the boards - dont 
> do anything in the board file. (device_init_call with auto register the 
> defaults)
> b) boards that need customization - these guys need to call 
> omapX_init_opp(to register the defaults) before customizing the defaults.
> 
> Does this explain the code and reason for the logic? if you do have a 
> better mechanism, lets know.

Yes, it explains the code and reason for the logic, but still doesn't
make it pretty :-)

> > would prevent you from having no OPP table (the case where a NULL OPP
> > table is passed is tested *before* in omapX_init_opp()).
> HUH?? NULL table to a static function - what code are you talking 
> about?? why are you so behind BUG_ON, when there are valid reasons for 
> reentry into code.

In the current design, yes, there are indeed valid reasons for reentry
into the omapX_init_opp() function, and that's exactly the point I'm
critizicing here.

Regards!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
