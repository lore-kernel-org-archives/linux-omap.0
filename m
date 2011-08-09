From: Scott Wood <scottwood@freescale.com>
Subject: Re: How to handle named resources with DT?
Date: Tue, 9 Aug 2011 16:52:27 -0500
Message-ID: <4E41AC1B.5040002@freescale.com>
References: <4E40FC88.5090403@ti.com> <20110809162907.GA630@manju-WNB7PBC4801-0006> <4E4166F0.9050401@ti.com> <CACxGe6tbEW1EZhqXy78EZVM_sQLH0Qbr7QOzbgbsKBRn1FtVrg@mail.gmail.com> <4E4172A8.3030101@ti.com> <4E417BD5.8080409@freescale.com> <20110809205723.GE11568@ponder.secretlab.ca> <4E41A1B9.1060400@ti.com> <20110809211747.GJ11568@ponder.secretlab.ca> <4E41AA43.1000506@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ch1ehsobe001.messaging.microsoft.com ([216.32.181.181]:11964
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751641Ab1HIVwf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Aug 2011 17:52:35 -0400
In-Reply-To: <4E41AA43.1000506@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, "G, Manjunath Kondaiah" <manjugk@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 08/09/2011 04:44 PM, Cousson, Benoit wrote:
> OK, so what about extending the reg attribute to be a reg node?
> 
> dev {
>     reg {
>         name = "foo_wrapper";
>         start = <0x10000>;
>         end = <0x200>;
>     }
>     reg {
>         name = "foo";
>         start = <0x20000>;
>         end = <0x200>;
>     }
> }
> 
> A little bit more verbose, but at least we can add any attribute we want.

A more standard way to do that would be something like:

dev {
	#address-cells = <1>;
	#size-cells = <1>;
	ranges;

	foo {
		reg = <0x10000 0x200>;
	};
	bar {
		reg = <0x20000 0x200>;
	};
};

...which is OK if you need the expressiveness of a full hierarchy (and
don't have some other meaning for child nodes of "dev"), but it seems
like it would be overkill for some places where named resources would be
useful.

-Scott

