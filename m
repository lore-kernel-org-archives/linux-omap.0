From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
Subject: Re: [RFC] OMAP: I2C: Use correct bit for CLOCKACTIVITY
Date: Thu, 05 Mar 2009 10:46:14 +0200
Message-ID: <1236242774.29572.45.camel@eenurkka-desktop>
References: <12362344552581-git-send-email-ext-eero.nurkkala@nokia.com>
	 <alpine.DEB.2.00.0903050113021.26353@utopia.booyaka.com>
Reply-To: ext-eero.nurkkala@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:63314 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750972AbZCEItG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Mar 2009 03:49:06 -0500
In-Reply-To: <alpine.DEB.2.00.0903050113021.26353@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "r-woodruff2@ti.com" <r-woodruff2@ti.com>

On Thu, 2009-03-05 at 09:42 +0100, ext Paul Walmsley wrote:
> Hello Eero,
> Hmm.  Looking at the 34xx Rev O TRM register tables, it looks like most 
> modules use bit 9 to indicate that FCLK should be kept on and bit 8 to 
> indicate that the ICLK should be kept on?  DSI, DISPC, SR, DMA4 are some 
> examples.

How about McBSP? Same TRM.. I2C, Table 18-5 tells exactly the opposite
for I2C than what's said in Table 18-44: I2C_SYSC!!

Please, Richard?

- Eero

