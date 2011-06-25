From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH] omap3: beagle: Use GPTIMERi 1 for clockevents
Date: Sun, 26 Jun 2011 00:21:52 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D6C2FE2@dbde02.ent.ti.com>
References: <1308932625-17632-1-git-send-email-premi@ti.com>
 <86CFE860-E18E-4B96-A753-11EB7C5C1C86@dominion.thruhere.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53832 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751617Ab1FYSwG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 25 Jun 2011 14:52:06 -0400
In-Reply-To: <86CFE860-E18E-4B96-A753-11EB7C5C1C86@dominion.thruhere.net>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <koen@dominion.thruhere.net>, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Paul Walmsley <paul@pwsan.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Koen Kooi
> Sent: Saturday, June 25, 2011 1:47 PM
> To: linux-omap@vger.kernel.org List
> Cc: linux-arm-kernel; Paul Walmsley
> Subject: Re: [PATCH] omap3: beagle: Use GPTIMERi 1 for clockevents
> 
> 
> Op 24 jun 2011, om 18:23 heeft Sanjeev Premi het volgende geschreven:
> 
> > The current selection of the GPTIMER on was result of
> > a hardware issue in early versions of the Beagleboards
> > (Ax and B1 thru B4). [1] [2]
> > 
> > Its been long since the hardware issue has been fixed.
> > This patch uses GPTIMER 1 for all newer board revisions
> > incl. Beagleboard XM.

[sp] I didn't include a reason - because the problem may not
     be reproducible on the public trees.

     During tests performed in internal development trees, the
     BogoMIPS calculations @ 1GHz wouldn't go beyond "830-850"
     range. While there was no such inconsistency on OMAP3EVM.

     After few days of debug GPTIMER12 came to be only difference.
     Tracing GPTIMER12 in the spec proved quite a challenge; the
     as timer is not included in the TRM and corresponding interrupt
     is marked reserved. Paul (in cc:) obviously had access to
     documents that we don't.

     This patch is merely trying to bring parity in use of GPTIMER
     across OMAP3 boards (AND use documented IP) - taking note of
     many Beagleboards where current code is necessary.

~sanjeev
