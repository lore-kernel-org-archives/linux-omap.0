From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
Subject: Re: [RFC] OMAP: I2C: Use correct bit for CLOCKACTIVITY
Date: Thu, 05 Mar 2009 10:54:30 +0200
Message-ID: <1236243270.29572.49.camel@eenurkka-desktop>
References: <12362344552581-git-send-email-ext-eero.nurkkala@nokia.com>
	 <alpine.DEB.2.00.0903050113021.26353@utopia.booyaka.com>
	 <1236242774.29572.45.camel@eenurkka-desktop>
Reply-To: ext-eero.nurkkala@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:50286 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751646AbZCEI5Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Mar 2009 03:57:25 -0500
In-Reply-To: <1236242774.29572.45.camel@eenurkka-desktop>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "r-woodruff2@ti.com" <r-woodruff2@ti.com>

On Thu, 2009-03-05 at 10:46 +0200, Eero Nurkkala wrote:
> 
> How about McBSP? Same TRM.. I2C, Table 18-5 tells exactly the opposite
> for I2C than what's said in Table 18-44: I2C_SYSC!!
> 
> Please, Richard?
> 
> - Eero

To answer to myself, I am 100% certain the McBSP FCLK is the
bit 8. I should have sent a patch about that already..

Kind of worried as could they really change that much?
>From page to page and block to block and within a block...=)

- Eero

