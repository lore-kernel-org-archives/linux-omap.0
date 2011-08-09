From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: How to handle named resources with DT?
Date: Tue, 9 Aug 2011 18:57:20 +0200
Message-ID: <4E4166F0.9050401@ti.com>
References: <4E40FC88.5090403@ti.com>
	<20110809162907.GA630@manju-WNB7PBC4801-0006>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110809162907.GA630@manju-WNB7PBC4801-0006>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "Nayak, Rajendra" <rnayak@ti.com>, Grant Likely <grant.likely@secretlab.ca>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi Manju,

On 8/9/2011 6:29 PM, G, Manjunath Kondaiah wrote:
> Hi Benoit,
>
> On Tue, Aug 09, 2011 at 11:23:20AM +0200, Cousson, Benoit wrote:
>> Hi Grant,
>>
>> Trying to bind hwmod informations with DT, I'm facing a little limitation.
>> A bunch of drivers are using the platform_get_resource_byname, so
>> the name for the resource is needed.
>>
>> The name is used so far for IORESOURCE_MEM, IORESOURCE_IRQ and
>> IORESOURCE_DMA types of resources.
>
> IORESOURCE_MEM and IORESOURCE_IRQ's are fetched from dt blob and
> it will be part of pdev.

Yes, but without the proper name in the resource structure. It will be 
then impossible to use the platform_get_resource_byname function that is 
currently used by a bunch of drivers.

> For IORESOURCE_DMA, you can have property
> "dma-channel" in dtsi file and fetch dma-channel in driver probe
> through "of_property_read_u32()" api.

That will not be enough to get the name. So maybe something like:
	dmas = <12>, "rx_req", <13>, "tx_req";
will be doable.
The issue is that the name is optional so managing the multiple entries 
might be tricky.

BTW, it's strange that a default support does not exist for dma request 
(and not channel).
The mechanism is similar to irq line, and quite standard to many SoC 
AFAIK. Or maybe I missed it.

> BTW, this is not required for omap since dt-hwmod binding will fetch
> pdev pointer from hwmod database and it will be used "as is" without
> any modification which inturn does not break any existing pm
> functionality.

Well for the moment... but I have some long term plan as well:-)

Thanks,
Benoit
