From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 02/13] gpio/omap: Adapt GPIO driver to DT
Date: Wed, 28 Sep 2011 16:32:47 -0500
Message-ID: <4E83927F.1060309@freescale.com>
References: <1317055821-20652-1-git-send-email-b-cousson@ti.com> <1317055821-20652-3-git-send-email-b-cousson@ti.com> <4E8161C7.7020404@ti.com> <4E82D7B3.6080909@ti.com> <4E836612.2010709@freescale.com> <4E838A41.8010408@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from am1ehsobe002.messaging.microsoft.com ([213.199.154.205]:50984
	"EHLO AM1EHSOBE002.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754913Ab1I1Vc5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Sep 2011 17:32:57 -0400
In-Reply-To: <4E838A41.8010408@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Nayak, Rajendra" <rnayak@ti.com>, "Hilman, Kevin" <khilman@ti.com>, "tony@atomide.com" <tony@atomide.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Varadarajan, Charulatha" <charu@ti.com>

On 09/28/2011 03:57 PM, Cousson, Benoit wrote:
> On 9/28/2011 8:23 PM, Scott Wood wrote:
>> What does "the id" mean, in relation to the actual hardware?
> 
> It's true that the description is not super meaningful...
> This is the HW instance number. We have 6 gpios, named gpio1 to gpio6,
> but the pin numbering is global, meaning from 1 to 192, sine only the
> global number is referenced in the pinmuxing control, we have to
> maintain the order to ensure the right number.

I'd either have one node that handles all the banks (with multiple "reg"
resources in the order that they should be mapped to the numberspace),
or avoid using that global numberspace and reference things by
bank/offset (with the bank identified by alias or phandle).

> I still do not know how to use that with the way gpio binding is
> working. Because in theory each gpio controller should be referenced
> with the local number, not the global one. And converting that global
> number from HW spec to a gpio instance + local number seems to me very
> error prone.

You could say the same thing about a chip whose manual is written
assuming a global IRQ numberspace with a certain encoding scheme.

Or in the other direction, Freescale's manuals split up MPIC interrupts
into external/internal/MSI, while they really just map to different
regions of the openpic (hardware standard that Freescale's MPIC is an
instance of) interrupt space.  The device trees use the raw openpic
interrupt numbers.

There's certainly potential for confusion, but at least the device tree
representation is internally consistent and doesn't make assumptions
about the overall system.

-Scott

