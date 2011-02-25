From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH 0/3] OMAP2+: voltage: first pass at
 cleanup/reorganization
Date: Thu, 24 Feb 2011 22:03:28 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1102242201410.6198@utopia.booyaka.com>
References: <20110221020231.7598.14024.stgit@twilight.localdomain> <553cd99ec29ee91e4a4b324d0f4a0be7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42578 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750753Ab1BYFD2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Feb 2011 00:03:28 -0500
In-Reply-To: <553cd99ec29ee91e4a4b324d0f4a0be7@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Nishanth Menon <nm@ti.com>, Benoit Cousson <b-cousson@ti.com>, Mike Turquette <mturquette@ti.com>

Hi Rajendra,

On Thu, 24 Feb 2011, Rajendra Nayak wrote:

> I found these abort on my 4430SDP. The below changes I found
> are needed for it to bootup..
> I tested the 'integration-2.6.39' branch of
> git://git.pwsan.com/linux-integration and the patch is
> based on this branch.

Thanks very much for the patch, this looks right.  Do you mind if I fold 
it into the "OMAP2+: voltage: reorganize, split code from data" patch and 
credit you appropriately in the patch description?  (That way, there won't 
be any gaps between patches where OMAP4 won't work.)


- Paul
