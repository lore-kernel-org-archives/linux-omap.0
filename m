From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCHv3 3/17] dmtimer: add omap2420 hwmod database
Date: Mon, 11 Oct 2010 08:19:05 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1010110811400.16871@utopia.booyaka.com>
References: <1285059116-26366-1-git-send-email-tarun.kanti@ti.com> <4CA4FC22.9030806@ti.com> <alpine.DEB.2.00.1010011623020.22941@utopia.booyaka.com> <4CA98739.9040309@ti.com> <5A47E75E594F054BAF48C5E4FC4B92AB035E840680@dbde02.ent.ti.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB035E970C49@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49512 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754673Ab0JKOTH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Oct 2010 10:19:07 -0400
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB035E970C49@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "Hilman, Kevin" <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gopinath, Thara" <thara@ti.com>, "Basak, Partha" <p-basak2@ti.com>, Tony Lindgren <tony@atomide.com>

On Mon, 11 Oct 2010, DebBarma, Tarun Kanti wrote:

> In the present implementation there is inconsistency in the clock source 
> names for the different platforms, viz. OMAP2, OMAP3 and OMAP4 as shown 
> below. Therefore, I will have to modify the names so that they all have 
> common name across the platforms for the same type of clock. In this 
> regard I am proposing to modify the clock source names similar to OMAP4. 
> Of course we also have to look around to see if there are other modules 
> who are using the clock and make the necessary changes.

Please look again at the links that I sent you.  All you need to change 
are the clkdev alias names for those clocks for that particular platform 
device name, "timer" or whatever it will be called.  That won't affect any 
other modules, since they will have different platform device names.  The 
struct clk.name fields will stay the same.


- Paul
