From: "Menon, Nishanth" <nm@ti.com>
Subject: RE: ioremap bug? (was RE: DSPBRIDGE: segmentation fault after
 reloading dspbridge several times due to a memory leak.)
Date: Thu, 12 Mar 2009 11:53:01 -0500
Message-ID: <7A436F7769CA33409C6B44B358BFFF0CFF51DF69@dlee02.ent.ti.com>
References: <496565EC904933469F292DDA3F1663E60287CA6EC4@dlee06.ent.ti.com>
 <7A436F7769CA33409C6B44B358BFFF0CFF51DF41@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49571 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754571AbZCLQxN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 12:53:13 -0400
In-Reply-To: <7A436F7769CA33409C6B44B358BFFF0CFF51DF41@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>, "Guzman Lugo, Fernando" <x0095840@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Woodruff, Richard" <r-woodruff2@ti.com>, "Lakhani, Amish" <amish@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>, Ameya Palande <ameya.palande@nokia.com>


> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Menon, Nishanth
> Sent: Thursday, March 12, 2009 6:40 PM
> To: Guzman Lugo, Fernando; linux-omap@vger.kernel.org
> Cc: Kanigeri, Hari; Woodruff, Richard; Lakhani, Amish; Gupta, Ramesh;
> Ameya Palande
> Subject: ioremap bug? (was RE: DSPBRIDGE: segmentation fault after
> reloading dspbridge several times due to a memory leak.)
> > console output where you can see the address increasing.
> 
> I duplicated this with the following dummy driver which ioremaps as per
> the same allocations that the bridge driver would have done:
> 
> #include <linux/kernel.h>
> #include <linux/module.h>
> #include <linux/slab.h>
> #include <linux/mm.h>
> #include <linux/dma-mapping.h>
> 
> #define BASE 0x87000000
> #define SIZE 0x600000
> 
Just an update (thanks to Fernando in pointing this out)
0x87000000, 0x600000, fails with same error
0x88000000, 0x600000, fails with same error
0x87000000, 0x700000 - went thru 300 odd iterations without error!! 

Mebbe this sequence is triggering a bug?

Regards,
Nishanth Menon
