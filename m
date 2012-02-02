From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [RFC PATCH 1/2] of: Add generic device tree DMA helpers
Date: Thu, 2 Feb 2012 08:45:39 +0000
Message-ID: <20120202084539.GC1275@n2100.arm.linux.org.uk>
References: <4F22DEF2.5000807@ti.com>
 <20120128180602.GC2501@ponder.secretlab.ca>
 <20120131230928.GA8394@n2100.arm.linux.org.uk> <4F2918F6.9040100@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4F2918F6.9040100-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>
Cc: "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Feb 01, 2012 at 11:50:30AM +0100, Cousson, Benoit wrote:
> Hi Russell,
>
> On 2/1/2012 12:09 AM, Russell King - ARM Linux wrote:
>> On Sat, Jan 28, 2012 at 11:06:02AM -0700, Grant Likely wrote:
>>> This makes the assumption that dma specifiers will only ever be 1
>>> cell.  I think to be generally useful, the full dma specifier needs to
>>> be either handed to the dma controller to get a cookie or passed back
>>> to the caller in its entirety.
>>
>> More to the point, who says that the DMA specifier is even an integer?
>> When people are using DMA engines, it (probably) isn't an integer at
>> all.  Several platforms I know of use strings for this.
>>
>> Some platforms can even select between two or more DMA engines for
>> handling the same peripheral - I believe Samsung do this depending
>> on their individual workloads.
>>
>> However, the opaque DMA engine API for requesting a channel doesn't
>> lend itself well to DT, as the match data and match function are
>> entirely left to the individual DMA engine driver and/or platform
>> itself.
>>
>> As far as creating another linear number space for DMA stuff, I'd
>> really suggest against that - you're going to need some additional
>> code in place to manage that numberspace.  If you at least use a two-
>> paid cookie, eg 'dma controller phandle + request signal' then that
>> makes all the stuff we're starting to see with the IRQ subsystem,
>> IRQ domains etc become completely unnecessary.
>>
>> I guess what I'm saying is ignore the flat number space, and go
>> straight to some kind of 'dma domains' solution from the start.
>
> Fully agree, and this is exactly the idea of this DMA binding: First  
> argument is always a DMA controller phandle and then you can add 0, 1 or  
> more cells to define extra specifiers dependent of the DMA controller  
> driver expectation. The one cell Grant was referring was just the extra  
> specifier that is needed for a simple DMA engine like the SDMA we have  
> inside OMAP. But the whole idea is to have a flexible enough mechanism  
> to allow any kind of specifier.
>
> No more global linear number space like for IRQ!

How does this work when you're stuffing a number into a struct resource
as a plain DMA number?  That looks very much like a linear number space,
as you don't have a way to associate that number with anything else.
