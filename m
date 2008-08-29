From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [patch 2.6.27-rc3-omap1] omap3 beagle: nand (mostly) cleanups
Date: Fri, 29 Aug 2008 18:56:58 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE896716203653CA11D@dlee02.ent.ti.com>
References: <200808291012.47332.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44806 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750722AbYH2X5I convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Aug 2008 19:57:08 -0400
In-Reply-To: <200808291012.47332.david-b@pacbell.net>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> From: David Brownell <dbrownell@users.sourceforge.net>
>
> Clean up the Beagle NAND config a bit:  use SZ_128K instead of
> an arithmetic expression for the NAND block size.  Set the
> NAND_BUSWIDTH_16 flag.  Make its init routine static.


Actually, this was talked about before a bit and the SZ_xyz flags were left out.

The point of telling the geometry in the addition was to be explicit about the number of sectors being used.

For x-loader you should use 4.  The size doesn't matter so much.  The ROM code will search for the 1 non-bad block sector in the first four sectors.

A porter of some of these things might try and use size thinking that was the requirement when that is not the whole story.  The geometry does matter here.

Regards,
Richard W.


