From: "Azbell, Brandon" <b-azbell@ti.com>
Subject: RE: SDMA, RAM to RAM transfer issue
Date: Thu, 12 Jun 2008 21:12:03 -0500
Message-ID: <9E8AB4F8CD83E542A3EF3F7DD3E7C55F0547F7E7@dlee11.ent.ti.com>
References: <5b1a99070806121834o10ce0a6cxa2b8552d8e1a283c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from calf.ext.ti.com ([198.47.26.144]:42205 "EHLO calf.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754468AbYFMCMK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Jun 2008 22:12:10 -0400
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by calf.ext.ti.com (8.13.7/8.13.7) with ESMTP id m5D2C46D006479
	for <linux-omap@vger.kernel.org>; Thu, 12 Jun 2008 21:12:09 -0500
Received: from dlee70.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id m5D2C4YT006283
	for <linux-omap@vger.kernel.org>; Thu, 12 Jun 2008 21:12:04 -0500 (CDT)
Content-class: urn:content-classes:message
In-Reply-To: <5b1a99070806121834o10ce0a6cxa2b8552d8e1a283c@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Somz,

	I'm not sure I quite comprehend the two transfers you mention.

	Regardless, please send your System DMA parameters for the
transfer.

	Did you perform a cache invalidate of the DEST buffer to ensure
you are seeing new data when performing a read by the CPU from DEST to
verify the transfer?

	A cache flush would be probably needed on SRC buffer if you had
just initialized SRC with data.  This would ensure the contents in SRC
are actually out in physical memory.

Brandon Azbell 

-----Original Message-----
From: linux-omap-owner@vger.kernel.org
[mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Somnt
Sent: Thursday, June 12, 2008 8:35 PM
To: linux-omap@vger.kernel.org
Subject: SDMA, RAM to RAM transfer issue

Hi! All

I am new to OMAP3430,
I am trying to do DMA transfer from one Memory location to another on
RAM.
First Scenario is
I am Allocating 1024bytes (KMALLOC) for both SRC & DEST
and after taking physical address (__pa) of allocated addresses I am
passing it to DMA tarnsfer.

in this case first 64bytes are not reflecting transfer in destination
(DST), rest are fine.

Second case:
I am doing everything else same but allocated size of memory is
X=(64+1024) bytes,
and passed address to DMA is X+64,
in this case eveything is fine, Transfer is complete for 1024bytes.

any body can please shed some light, what is wrong in my approach?
or why in first case tarnsffer is not reflected in first 64 bytes?
is it memory addressing issue or DMA setting issue.
I have tried with different channel but result is same.
Address returned by Kmalloc is on 32/64 byte boundary.

A quick reply will be appreciable!

with wishes
Somz
-
end
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
