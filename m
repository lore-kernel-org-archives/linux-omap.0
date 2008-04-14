From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: NAND support for 3430sdp
Date: Mon, 14 Apr 2008 15:23:22 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D9130274290405C10F@dlee13.ent.ti.com>
References: <1ee641e10804110700p2d885919wc35961a67fd76a2f@mail.gmail.com> <1ee641e10804141308j39beb7bende8f4165c0e88bb4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from calf.ext.ti.com ([198.47.26.144]:47321 "EHLO calf.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751038AbYDNUX3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Apr 2008 16:23:29 -0400
Content-class: urn:content-classes:message
In-Reply-To: <1ee641e10804141308j39beb7bende8f4165c0e88bb4@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Simon Braunschmidt <sbraunschmidt.linuxlists@googlemail.com>, linux-omap@vger.kernel.org

Hi,

> The kernel snapshots
> 
> http://www.openlabrador.org/pub/kernel/
> and
> http://linux.omap.com/pub/kernel/3430sdp/
> 
> contain NAND flash support for 3430sdp, zoom and maybe others as it
seems.

Yes.  Those snapshots might be a bit stale but should work.  A good
amount of internal activity has been going on here.

> Will this be merged to mvista git in the near future?

Right now it is being effectively merged a bit at a time.  If you look
at archives you will see merges from TI people bringing in
functionality.

We generally have many streams of code running in parallel.
Customers/users have very different time lines and needs.  As such there
is some phase difference in what each tree has. We would love them to be
all in sync but that isn't the case.

> Does anyone know of a reason why not to integrate it?

There is no reason.  It's a function of people's time.

> I just stumbled over these kernels, does anyone know who provided them
> initially and why/how they differ in this aspect and maybe others from
> mvista git?

They have been generated/provided by TI.  They would have branched off
public git, then up merged with internal streams which have not yet been
absorbed, and new development happens where there are gaps.

Regards,
Richard W.
