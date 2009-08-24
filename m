From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 1/5] ARM: OMAP2/3/4: Split OMAP2_IO_ADDRESS to L3 and L4
Date: Mon, 24 Aug 2009 09:47:38 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BA29C290@dbde02.ent.ti.com>
References: <1251034495-10107-1-git-send-email-santosh.shilimkar@ti.com>
 <FCCFB4CDC6E5564B9182F639FC35608702F996E313@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59701 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751342AbZHXERt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Aug 2009 00:17:49 -0400
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608702F996E313@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>, "tony@atomide.com" <tony@atomide.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

 >-----Original Message-----
> >From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of
> >Shilimkar, Santosh
> >Sent: Sunday, August 23, 2009 8:35 AM
> >To: tony@atomide.com; khilman@deeprootsystems.com
> >Cc: linux-omap@vger.kernel.org; Shilimkar, Santosh
> >Subject: [PATCH 1/5] ARM: OMAP2/3/4: Split OMAP2_IO_ADDRESS to L3 and L4
> 
> That sure is a big cleanup patch and would take patience to complete!!
> 
> >
> >This patch splits OMAP2_IO_ADDRESS to OMAP2_L3_IO_ADDRESS and
> >OMAP2_L4_IO_ADDRESS to reclaim more IO space.
> 
> There is no reclaim of space with this patch. Its done with [2/5]

Yes comment is valid. I wanted to put - "This patch splits OMAP2_IO_ADDRESS to OMAP2_L3_IO_ADDRESS and OMAP2_L4_IO_ADDRESS to enable freeing up of more IO space.

> This patch only changes the macro definitions but the offsets are still
> the same as in old code.
> So the description needs to be more explicit as to why you introduced
> L3/L4 macro split.
> 
> Another suggestion to minimize the so intrusive code change: As per the
> wiki approach: [1]
> Lot of code will remain un-touched if you re-used the existing IO_OFFSET
> macro as follows ---
> ---
> #define L3_IO_OFFSET		0x90000000
> #define __L3_IO_ADDRESS(pa)	((pa) + L3_IO_OFFSET)/* Works for L3 */
> #define __OMAP2_L3_IO_ADDRESS(pa)	((pa) + L3_IO_OFFSET)/* Works for L3
> */
> #define l3_io_v2p(va)		((va) - L3_IO_OFFSET)/* Works for L3 */
> 
> #define IO_OFFSET		0xb2000000
> #define __IO_ADDRESS(pa)	((pa) + IO_OFFSET)/* Works for L4  */
> #define __OMAP2_IO_ADDRESS(pa)	((pa) + IO_OFFSET)/* Works for L4 */
> #define io_v2p(va)		((va) - IO_OFFSET)/* Works for L4*/
> ---
> 
> This way you don't have to introduce new L4 macro at all => much lesser
> code impact.
Initially I thought about this but later preferred to split it. The only change what you are suggesting is instead of calling "OMAP2_L4_IO_ADDRESS", we keep that as "OMAP2_IO_ADDRESS". But the idea was to differentiate between various IO accesses because at some point of time all these has to be removed in favor of ioremap() + read*()/write*() one by one and that time this would be beneficial.



