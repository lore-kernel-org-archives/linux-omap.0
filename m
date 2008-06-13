From: "Azbell, Brandon" <b-azbell@ti.com>
Subject: RE: SDMA, RAM to RAM transfer issue
Date: Fri, 13 Jun 2008 15:02:55 -0500
Message-ID: <9E8AB4F8CD83E542A3EF3F7DD3E7C55F0547FCD3@dlee11.ent.ti.com>
References: <5b1a99070806121834o10ce0a6cxa2b8552d8e1a283c@mail.gmail.com> <9E8AB4F8CD83E542A3EF3F7DD3E7C55F0547F7E7@dlee11.ent.ti.com> <5b1a99070806130058u5a0840c6pd6dc0124fb7a34dc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41701 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752126AbYFMUDD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Jun 2008 16:03:03 -0400
Content-class: urn:content-classes:message
In-Reply-To: <5b1a99070806130058u5a0840c6pd6dc0124fb7a34dc@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Somnt <er.somnt@gmail.com>, linux-omap@vger.kernel.org

Somz,

	The parameter set looks fine and as you indicated, works fine
for the 1024 byte transfer.

	Regarding the 64-byte transfer, which was not represented in the
parameters you provided, I suspect that it is getting stuck in the L1
Cache, or possibly L2 Cache, but not actually getting to system memory
(DDR).  For the 1024 byte transfer, the cache controllers may be needing
to flush to make room and therefore it "appears" to be working.

	Do you perform a cache flush on the SRC buffer prior to
triggering the DMA?
	Also, do you perform a cache invalidate on the DST buffer prior
to reading the buffer and verifying the contents?

	You should perform this in order to ensure the new contents of
the SRC buffer make it to system memory (DDR) prior to the DMA transfer.

Brandon Azbell 

