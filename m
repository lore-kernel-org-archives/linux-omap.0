From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] of: Add generic device tree DMA helpers
Date: Thu, 15 Mar 2012 21:55:37 +0000
Message-ID: <20120315215537.GB2842@n2100.arm.linux.org.uk>
References: <4F22DEF2.5000807@ti.com> <4F621939.9040906@ti.com> <20120315195753.GA2842@n2100.arm.linux.org.uk> <201203152041.53754.arnd@arndb.de> <4F626180.2010902@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:55759 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753709Ab2COV4S (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Mar 2012 17:56:18 -0400
Content-Disposition: inline
In-Reply-To: <4F626180.2010902@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, Nicolas Ferre <nicolas.ferre@atmel.com>, grant.likely@secretlab.ca, rob.herring@calxeda.com, devicetree-discuss@lists.ozlabs.org, Stephen Warren <swarren@nvidia.com>, linux-omap@vger.kernel.org, Thierry Reding <thierry.reding@avionic-design.de>

On Thu, Mar 15, 2012 at 10:39:12PM +0100, Cousson, Benoit wrote:
> On 3/15/2012 9:41 PM, Arnd Bergmann wrote:
>> On Thursday 15 March 2012, Russell King - ARM Linux wrote:
>>> On Thu, Mar 15, 2012 at 05:30:49PM +0100, Cousson, Benoit wrote:
>>>> This was done like IRQ on purpose, because an Interrupt ReQuest line and
>>>> a DMA Request line are really similar for the HW point of view at IP
>>>> level.
>>>
>>> I'm not sure about that at all levels.  Sure, at hardware level they're
>>> the same, but I think the flat numeric namespace for IRQs has been
>>> proven to be a problem when there's multiple IRQ controllers in the
>>> system.
>>
>> In the DT bindings, both IRQ and the suggested DMA are not flat number
>> spaces, but instead can be of arbitrarly length defined by the controller.
>>
>>> As far as I'm concerned for DMA stuff, there is currently no real solution
>>> for a DT representation; TI have asked me to take over the conversion of
>>> OMAP DMA support to the DMA engine API, and I'm not yet convinced that
>>> the existing numbering system is the right solution - especially as
>>> there's several overlapping numberspaces for OMAP DMA numbers which
>>> are SoC specific.
>>
>> The numbers definitely need to become local to each of the controllers, but
>> that is the case pretty much automatically using the proposed binding,
>> because each dma request identifier starts with the phandle of the
>> controller.
>
> Indeed, and in the case of the OMAP SDMA controller, it can handle up to  
> 127 DMA request lines numbered from 0 to 126... So a local number seems  
> to be a good representation... especially for a number. I'm not sure to  
> understand the issue with this binding.
>
> And AFAIK, there is the only one general purpose DMA controller in OMAP  
> so far. The other ones are private to some IPs like MMC or USB, so they  
> do not need necessarily need any DT representation.
> But anyway, since the controller phandle is mandatory, it will be able  
> to handle even several instances of this DMA controller without any 
> issue.

Thank you both for missing my point.

#define OMAP24XX_DMA_SHA1MD5_RX         13      /* S_DMA_12 */
#define OMAP34XX_DMA_SHA2MD5_RX         13      /* S_DMA_12 */

#define OMAP242X_DMA_EXT_DMAREQ2        14      /* S_DMA_13 */
#define OMAP243X_DMA_EXT_DMAREQ3        14      /* S_DMA_13 */

#define OMAP242X_DMA_EXT_DMAREQ3        15      /* S_DMA_14 */
#define OMAP24XX_DMA_SPI3_TX0           15      /* S_DMA_14 */

#define OMAP242X_DMA_EXT_DMAREQ4        16      /* S_DMA_15 */
#define OMAP24XX_DMA_SPI3_RX0           16      /* S_DMA_15 */

#define OMAP242X_DMA_EAC_BT_DL_RD       25      /* S_DMA_24 */
#define OMAP243X_DMA_EXT_DMAREQ4        25      /* S_DMA_24 */
#define OMAP34XX_DMA_I2C3_TX            25      /* S_DMA_24 */

Notice the overlap between the different SoCs for the same number on the
same DMA controller.

This shouldn't cause problems when all users are within the SoC specific
file, but those EXT ones would probably be platform specific, and so you
immediately have a dependence between the platform and the SoC there.

That dependence can be completely eliminated by other matching schemes
which are supportable via the DMA engine API.
