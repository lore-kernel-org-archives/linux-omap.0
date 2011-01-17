From: Jamie Iles <jamie@jamieiles.com>
Subject: Re: [RFC+CFT] Use word operations in bitops
Date: Mon, 17 Jan 2011 11:03:08 +0000
Message-ID: <20110117110308.GC2622@pulham.picochip.com>
References: <20110116121911.GB27542@n2100.arm.linux.org.uk>
 <20110116181551.GB21795@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:57701 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750900Ab1AQLDL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Jan 2011 06:03:11 -0500
Received: by wyb28 with SMTP id 28so4968033wyb.19
        for <linux-omap@vger.kernel.org>; Mon, 17 Jan 2011 03:03:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110116181551.GB21795@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Sun, Jan 16, 2011 at 06:15:51PM +0000, Russell King - ARM Linux wrote:
> Revised patch - the previous one was slightly buggered for BE.  We also
> don't need to touch the findbit operations at all, so that part has been
> dropped.
> 
> This includes a patch by Akinobu Mita ("arm: introduce little-endian
> bitops", v4).

Oops, I hit reply to the wrong patch before.  Sorry!

Tested-by: Jamie Iles <jamie@jamieiles.com>

Jamie
