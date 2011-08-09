From: Matt Porter <mporter@ti.com>
Subject: Re: How to handle named resources with DT?
Date: Tue, 9 Aug 2011 13:52:42 -0400
Message-ID: <3AA3546C-161A-40C0-8D36-73337B528D24@ti.com>
References: <4E40FC88.5090403@ti.com>
	<20110809162907.GA630@manju-WNB7PBC4801-0006>
	<4E4166F0.9050401@ti.com>
	<CACxGe6tbEW1EZhqXy78EZVM_sQLH0Qbr7QOzbgbsKBRn1FtVrg@mail.gmail.com>
	<4E4172A8.3030101@ti.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4E4172A8.3030101@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, "G,
	Manjunath Kondaiah" <manjugk@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "Nayak, Rajendra" <rnayak@ti.com>, Grant Likely <grant.likely@secretlab.ca>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Aug 9, 2011, at 1:47 PM, Cousson, Benoit wrote:

> On 8/9/2011 7:23 PM, Grant Likely wrote:
>> On Tue, Aug 9, 2011 at 10:57 AM, Cousson, Benoit<b-cousson@ti.com>  wrote:
>>> Hi Manju,
>>> 
>>> On 8/9/2011 6:29 PM, G, Manjunath Kondaiah wrote:
>>>> 
>>>> Hi Benoit,
>>>> 
>>>> On Tue, Aug 09, 2011 at 11:23:20AM +0200, Cousson, Benoit wrote:
>>>>> 
>>>>> Hi Grant,
>>>>> 
>>>>> Trying to bind hwmod informations with DT, I'm facing a little
>>>>> limitation.
>>>>> A bunch of drivers are using the platform_get_resource_byname, so
>>>>> the name for the resource is needed.
>>>>> 
>>>>> The name is used so far for IORESOURCE_MEM, IORESOURCE_IRQ and
>>>>> IORESOURCE_DMA types of resources.
>>>> 
>>>> IORESOURCE_MEM and IORESOURCE_IRQ's are fetched from dt blob and
>>>> it will be part of pdev.
>>> 
>>> Yes, but without the proper name in the resource structure. It will be then
>>> impossible to use the platform_get_resource_byname function that is
>>> currently used by a bunch of drivers.
>> 
>> There is no analogous mechanism for _byname in the device tree.  The
>> DT binding for a device must explicitly state what order the register
>> ranges are in.  The driver will need to be adapted.
> 
> That seems to be a small regression for my point of view. Relying on the order is not super safe. This is not very readable either. That's for that exact reason that we changed our drivers to use platform_get_resource_byname. That's probably the reason why that API is there as well.

That's exactly what the reasoning was for adding it.

http://linux.derkeiler.com/Mailing-Lists/Kernel/2004-12/1944.html

-Matt
