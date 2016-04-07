From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] of/platform: Allow secondary compatible match in
 of_dev_lookup
Date: Thu, 7 Apr 2016 13:21:00 +0300
Message-ID: <5706348C.1040709@ti.com>
References: <1459546504-32668-1-git-send-email-tony@atomide.com>
 <20160401214053.GQ9329@atomide.com>
 <CAL_Jsq+PcTD=duHmWgHyx_ywYbT10vEtcm=79x5o5wYSkgG63g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAL_Jsq+PcTD=duHmWgHyx_ywYbT10vEtcm=79x5o5wYSkgG63g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 04/07/2016 07:52 AM, Rob Herring wrote:
> On Fri, Apr 1, 2016 at 4:40 PM, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
>> * Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [160401 14:37]:
>>> We currently try to match of_dev_auxdata based on compatible,
>>> IO address, and device name. But in some cases we have multiple
>>> instances of drivers that can use the same auxdata.
>>>
>>> Let's add an additional secondary lookup for generic compatible
>>> match for auxdata if no device specific match is found. This does
>>> not change the existing matching, and still allows adding device
>>> specific auxdata.
>>>
>>> This simplifies things as specifying the IO address and device
>>> name is prone errors as it requires maintaining an in kernel
>>> database for each SoC.
>>
>> And here's what I can apply later on to get rid of some
>> ifdeffery.
>>
>> I'm also planning to move some of the legacy omap hwmod
>> functionality into proper device drivers, so can generic
>> pdata for that too.
> 
> Why can't the platform data be moved into the driver given that it
> appears to be only SoC family specific? Auxdata was somewhat intended
> to be temporary. It appears there is already some per compatible match
> data for these OMAP parts in the driver.
> 

Most probably this is required to pass some data from parent device to
children when parent dev instantiate children from DT, at least I've experimented with
this in mostly similar way (I've not added second pass and did break in the first
if !phys_addr, but Tony's patch is more correct).

For example,
- USB dwc3 platform/integration layer dev creates DWC3-core device (of_platform_populate())
- DWC3-core device creates xhci device
- USB dwc3 platform/integration layer dev can dynamically get rev info
  from HW and identify limitation/erratas/quirks which need to be applied to 
  to its children.
- DWC3-core can dynamically get rev info ...

I was not able to find any other proper way to pass this (platfrom)data to children, except
using Auxdata. And, as per Felipe Balbi, It was the major reason why now
DWC3-core device creates xhci device manually.

-- 
regards,
-grygorii
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
