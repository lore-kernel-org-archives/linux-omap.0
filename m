From: Scott Wood <scottwood@freescale.com>
Subject: Re: How to handle named resources with DT?
Date: Wed, 10 Aug 2011 10:18:35 -0500
Message-ID: <4E42A14B.9050308@freescale.com>
References: <4E4166F0.9050401@ti.com> <CACxGe6tbEW1EZhqXy78EZVM_sQLH0Qbr7QOzbgbsKBRn1FtVrg@mail.gmail.com> <4E4172A8.3030101@ti.com> <4E417BD5.8080409@freescale.com> <20110809205723.GE11568@ponder.secretlab.ca> <4E41A1B9.1060400@ti.com> <20110809211747.GJ11568@ponder.secretlab.ca> <4E41AA43.1000506@ti.com> <20110809214905.GK11568@ponder.secretlab.ca> <4E41AC5C.20301@ti.com> <20110810015214.GD23511@yookeroo.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from am1ehsobe001.messaging.microsoft.com ([213.199.154.204]:51178
	"EHLO AM1EHSOBE001.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752511Ab1HJPSm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 10 Aug 2011 11:18:42 -0400
In-Reply-To: <20110810015214.GD23511@yookeroo.fritz.box>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Gibson <david@gibson.dropbear.id.au>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, Grant Likely <grant.likely@secretlab.ca>, "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, "G, Manjunath Kondaiah" <manjugk@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 08/09/2011 08:52 PM, David Gibson wrote:
> Of course, the problem with reg-names is that it will be ignored by
> older OSes, and so 'reg' must still be in the correct order.  In which
> case you could argue it's more sensible to just have a static place to
> name mapping in the Linux driver.

I think the intent was just to use this for some new bindings -- not to
change existing ones.

-Scott

