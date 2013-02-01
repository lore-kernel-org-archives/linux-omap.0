From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: DT GPMC SRAM and NOR flash support ?
Date: Fri, 1 Feb 2013 11:12:06 -0600
Message-ID: <510BF766.5090608@ti.com>
References: <510BF3D3.3000304@mimc.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52931 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756373Ab3BARMJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Feb 2013 12:12:09 -0500
In-Reply-To: <510BF3D3.3000304@mimc.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Jackson <mpfj-list@mimc.co.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Mark,

On 02/01/2013 10:56 AM, Mark Jackson wrote:
> There's plenty of DT support going in for NAND flash, but is there any work going on to support NOR
> flash ?

What board and device are you working that is using NOR? I have a
OMAP2420 H4 with NOR that I have been doing a bit of maintenance for but
I don't spend much time on it. Eventually it will have to be done but it
is always good to know if there is a pressing need.

> And how about SRAM chips or other memory mapped devices ?

Not sure about SRAM (trying to think if I have a board with SRAM even),
but definitely, boards using the GPMC to interface to ethernet chips
need to be added.

Cheers
Jon
