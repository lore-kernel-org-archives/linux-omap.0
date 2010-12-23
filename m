From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: Re: Last OMAP4 hwmod data cleanup for 2.6.38
Date: Thu, 23 Dec 2010 21:33:19 +0530
Message-ID: <20101223160319.GB1863@GLPP-machine>
References: <4D135677.1080200@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:50438 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752829Ab0LWQCU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Dec 2010 11:02:20 -0500
Received: by mail-gw0-f49.google.com with SMTP id 20so3144621gwj.8
        for <linux-omap@vger.kernel.org>; Thu, 23 Dec 2010 08:02:19 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D135677.1080200@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Paul Walmsley <paul@pwsan.com>, kevin Hilman <khilman@deeprootsystems.com>

On Thu, Dec 23, 2010 at 03:02:31PM +0100, Cousson, Benoit wrote:
> Hi Tony,
> 
> The merge of both SDMA series from Manju and SR series from Thara
> changed the expected order of the hwmod data structures for OMAP4.
> In order to have a clean base for 2.6.38, and to avoid starting
> 2.6.39 with a cleanup patch again, I'd like to fix that right now.
> Even if, I do agree, this is not a big deal.
> 
> I squeezed the 3 original small fixes I did (SDMA, SR and alignment)
> into one to avoid overloading your mailbox 2 days before Xmas.
> 
> The patch will be available here, based on omap-for-linus.
> git://gitorious.org/omap-pm/linux.git for_2.6.38/hwmod_fixes
> 
> It should not affect any functionality, and it is boot tested on
> OMAP4430/sdp.

Boot tested on SDP4430 and all DMA tests passes as expected.

Tested-by: G, Manjunath Kondaiah <manjugk@ti.com>

-Manjunath
