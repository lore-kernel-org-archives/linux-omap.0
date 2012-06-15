From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v5 02/14] ARM: OMAP2+: gpmc: Adapt to HWMOD
Date: Thu, 14 Jun 2012 18:20:57 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1206141819130.25628@utopia.booyaka.com>
References: <cover.1339419492.git.afzal@ti.com> <fb739c3c5383806f78cee3666f7c74d61bed6427.1339419492.git.afzal@ti.com> <4FD64D6D.3020401@ti.com> <C8443D0743D26F4388EA172BF4E2A7A93E997DD6@DBDE01.ent.ti.com> <4FD77EF1.8000600@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9987B2@DBDE01.ent.ti.com> <4FD8A906.8080202@ti.com> <C8443D0743D26F4388EA172BF4E2A7A93E9994A6@DBDE01.ent.ti.com> <4FDA4EE6.1070106@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:54061 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751871Ab2FOAU5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Jun 2012 20:20:57 -0400
In-Reply-To: <4FDA4EE6.1070106@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: "Mohammed, Afzal" <afzal@ti.com>, "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, 14 Jun 2012, Jon Hunter wrote:

> What does make this a bit more difficult is the function
> gpmc_round_ns_to_ticks(). It appears to convert nanoseconds to ticks and
> back to nanoseconds. I am guessing to account for some rounding error. I
> am curious what impact this function is having on the timing. Ideally
> this should be handle in gpmc_cs_set_timings().

I don't have the code in front of me at the moment, nor my old GPMC timing 
spreadsheet, so this comment may be superfluous.  But since kernel 
arithmetic needs to be in integers, it might be necessary to do some of 
the timing calculations in picosecond units to avoid roundoff issues.


- Paul
