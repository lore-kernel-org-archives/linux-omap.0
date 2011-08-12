From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: How to handle named resources with DT?
Date: Fri, 12 Aug 2011 17:09:33 +0200
Message-ID: <4E45422D.4050708@ti.com>
References: <20110809205723.GE11568@ponder.secretlab.ca> <20110812030218.GP30552@yookeroo.fritz.box> <20110812084106.GC19467@legolas.emea.dhcp.ti.com> <201108121635.42953.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57904 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751189Ab1HLPJx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 12 Aug 2011 11:09:53 -0400
In-Reply-To: <201108121635.42953.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Balbi, Felipe" <balbi@ti.com>, David Gibson <david@gibson.dropbear.id.au>, "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, "G, Manjunath Kondaiah" <manjugk@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Grant Likely <grant.likely@secretlab.ca>, Scott Wood <scottwood@freescale.com>, linux-omap <linux-omap@vger.kernel.org>

On 8/12/2011 4:35 PM, Arnd Bergmann wrote:
> On Friday 12 August 2011, Felipe Balbi wrote:
>> On Fri, Aug 12, 2011 at 01:02:18PM +1000, David Gibson wrote:
>>
>> the whole point of using *byname() is for the driver to not care about
>> the order of the resources. So if driver has to provided an ordered list
>> of names, what's the benefit ? Sounds really stupid to provide an
>> ordered list of names to an ordered list of resources, just to use
>> *byname() instead of just assuming the list of resources is already
>> ordered.
>
> It only make sense for drivers that support both device tree probing
> and legacy probing of static platform devices.
>
> Note how almost all drivers use only platform_get_resource and not
> platform_get_resource_byname:
>
> arnd@ocdc-kvm:~/linux-arm$ git grep -wl platform_get_resource | wc -l
> 565
> arnd@ocdc-kvm:~/linux-arm$ git grep -wl platform_get_resource_byname | wc -l
> 41
> arnd@ocdc-kvm:~/linux-arm$ git grep -wl platform_get_resource_byname | xargs grep -wL platform_get_resource | wc -l # both
> 28
> arnd@ocdc-kvm:~/linux-arm$ git grep -wl platform_get_resource_byname | xargs grep -wl platform_get_resource  | wc -l # only _byname
> 13

That's true, but this is mainly because most of the time there is only 
one irq, dma or mem resource, so the _byname is not useful.
As soon as you start having multiple entries, relying on the order 
become less readable and error prone. Then getting the resource by name 
become useful.
There are probably a lot of API that are less used than this one, but 
does that mean that we have to remove them?

The extreme case (soon in mainline) in OMAP is that one:

static struct omap_hwmod_addr_space omap44xx_aess_addrs[] = {
	{
		.name		= "dmem",
		.pa_start	= 0x40180000,
		.pa_end		= 0x4018ffff
	},
	{
		.name		= "cmem",
		.pa_start	= 0x401a0000,
		.pa_end		= 0x401a1fff
	},
	{
		.name		= "smem",
		.pa_start	= 0x401c0000,
		.pa_end		= 0x401c5fff
	},
	{
		.name		= "pmem",
		.pa_start	= 0x401e0000,
		.pa_end		= 0x401e1fff
	},
	{
		.name		= "reg",
		.pa_start	= 0x401f1000,
		.pa_end		= 0x401f13ff,
		.flags		= ADDR_TYPE_RT
     }
};

In that case, the driver knows exactly where is the relevant memory 
buffer he has to use.

> I think it's much easier to change the existing users of _byname over
> to fixed indexes than to come up with a new scheme that is better.

As you said previously, since we have to support both legacy probing and 
DT for some time, it will be easier for these drivers to rely on the 
same API.

Considering that adding that new property is not a huge effort anyway 
and _byname API is a standard API that any driver should be able to use 
if needed, it still worth adding the DT support for named resources for 
my point of view.
Moreover that seems much more consistent with the device tree format in 
general that does rely a lot on named properties for passing parameter 
to driver. That just my .2 cents.

Regards,
Benoit
