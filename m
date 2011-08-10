From: Paul Walmsley <paul@pwsan.com>
Subject: Re: How to handle named resources with DT?
Date: Wed, 10 Aug 2011 01:11:58 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1108100104150.12674@utopia.booyaka.com>
References: <4E4166F0.9050401@ti.com> <CACxGe6tbEW1EZhqXy78EZVM_sQLH0Qbr7QOzbgbsKBRn1FtVrg@mail.gmail.com> <4E4172A8.3030101@ti.com> <4E417BD5.8080409@freescale.com> <20110809205723.GE11568@ponder.secretlab.ca> <4E41A1B9.1060400@ti.com>
 <20110809211747.GJ11568@ponder.secretlab.ca> <4E41AA43.1000506@ti.com> <20110809214905.GK11568@ponder.secretlab.ca> <4E41AC5C.20301@ti.com> <20110810015214.GD23511@yookeroo.fritz.box>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41741 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751251Ab1HJHL7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Aug 2011 03:11:59 -0400
In-Reply-To: <20110810015214.GD23511@yookeroo.fritz.box>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Gibson <david@gibson.dropbear.id.au>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, Grant Likely <grant.likely@secretlab.ca>, "Hilman, Kevin" <khilman@ti.com>, "G, Manjunath Kondaiah" <manjugk@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Scott Wood <scottwood@freescale.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, 10 Aug 2011, David Gibson wrote:

> Of course, the problem with reg-names is that it will be ignored by
> older OSes, and so 'reg' must still be in the correct order.

Most ARM SoC Linux ports aren't using DT now, so there isn't really an 
older OS case here.  Might as well try to get something implemented in a 
clean way while there's still some chance for it.

A more persuasive case could probably be made about DT bootloader-related 
issues.  Those would have to be converted to use reg-names, also.


- Paul
