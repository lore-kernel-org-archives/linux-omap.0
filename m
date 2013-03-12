From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH V3 1/2] ARM: dts: OMAP2+: Add SDMA controller bindings
 and nodes
Date: Tue, 12 Mar 2013 16:43:56 -0500
Message-ID: <513FA19C.60904@ti.com>
References: <1361903244-19837-1-git-send-email-jon-hunter@ti.com> <1361903244-19837-2-git-send-email-jon-hunter@ti.com> <513F0AE3.6030408@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34745 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932761Ab3CLVoP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 12 Mar 2013 17:44:15 -0400
In-Reply-To: <513F0AE3.6030408@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Tony Lindgren <tony@atomide.com>, Vinod Koul <vinod.koul@intel.com>, Russell King <linux@arm.linux.org.uk>, device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Sebastien Guiriec <s-guiriec@ti.com>

Salut Benoit!

On 03/12/2013 06:00 AM, Benoit Cousson wrote:
> + Seb G.
> 
> Hi Jon,
> 
> How to you plan to merge that series?

Good question ... my thinking was that you or Tony would take 1/2 and
once that is queued then I would ask Tony to ack 2/2 and Vinod take that
patch.

By the way, I have accumulated several DT patches which I sent out
altogether [1] (at least for my own sanity if no one elses ;-) and I
have included the below patch with it. I was hoping that may be I could
create a branch for you to pull. If you would rather cherry-pick the
various patches and merge yourself then I can separate them too.

> Seb's just posted a McBSP adaptation to SDMA binding, so I'll have to
> take this one before being able to merge any other SDMA driver
> adaptation patches.
> 
> I'm fine to take that one, if you are OK, to avoid merge conflict in DTS
> later.

Fine with me and that would be preferred. I don't see any downside in
taking this one and then having Vinod take the other later.

> On 02/26/2013 07:27 PM, Jon Hunter wrote:
>> Add SDMA controller binding for OMAP2+ devices and populate DMA client
>> information for SPI and MMC periperhal on OMAP3+ devices. Please note
> 
> typo-------------------------------^

Thanks! Will fix.

>> that OMAP24xx devices do not have SPI and MMC bindings available yet and
>> so DMA client information is not populated.
>>
>> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
>> Reviewed-by: Felipe Balbi <balbi@ti.com>
>> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> Tested-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> ---
>>  .../devicetree/bindings/dma/omap-sdma.txt          |   51 ++++++++++++++++++++
> 
> That's a detail, but the bindings should be introduced along with the
> driver DT adaptation since it does represent its "interface".

Ok, I can add that to patch 2/2 instead.

>>  arch/arm/boot/dts/omap2.dtsi                       |   12 +++++
>>  arch/arm/boot/dts/omap3.dtsi                       |   40 +++++++++++++++
>>  arch/arm/boot/dts/omap4.dtsi                       |   41 ++++++++++++++++
>>  arch/arm/boot/dts/omap5.dtsi                       |   41 ++++++++++++++++
>>  5 files changed, 185 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/dma/omap-sdma.txt
>>
>> diff --git a/Documentation/devicetree/bindings/dma/omap-sdma.txt b/Documentation/devicetree/bindings/dma/omap-sdma.txt
>> new file mode 100644
>> index 0000000..22aab28
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/dma/omap-sdma.txt
>> @@ -0,0 +1,51 @@
>> +* TI OMAP SDMA controller
>> +
>> +Required properties:
>> +- compatible:		Should be set to one of the following:
>> +
>> +			ti,omap2420-sdma (omap2420)
>> +			ti,omap2430-sdma (omap2430)
>> +			ti,omap3430-sdma (omap3430)
>> +			ti,omap3630-sdma (omap3630)
>> +			ti,omap4430-sdma (omap4430 & omap4460 & omap543x)
>> +
>> +- reg: 			Contains DMA registers location and length.
>> +- interrupts: 		Contains DMA interrupt information.
>> +- #dma-cells: 		Must be 1.
>> +- #dma-channels:	Contains total number of programmable DMA channels.
>> +- #dma-requests:	Contains total number of DMA requests.
>> +
>> +Example:
>> +
>> +	sdma: dma-controller@4A056000 {
>> +		compatible = "ti,omap-sdma";
>> +		reg = <0x4A056000 0x1000>;
> 
> 
> Nit: you do have several hexa values in upper case, here and in some dts
> as well.

Yes will fix that too.

Cheers
Jon

[1]
http://www.mail-archive.com/devicetree-discuss@lists.ozlabs.org/msg28050.html

