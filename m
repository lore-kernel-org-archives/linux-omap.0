From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC/PATCH 7/7] WIP: HACK/RFC: omap_device: begin to decouple
 platform_device from omap_device
Date: Mon, 1 Aug 2011 16:44:20 +0100
Message-ID: <CACxGe6t4tNeD-Pn6WFt1XOMC=_Q0cf4uD3kRkOckKH+S1JUJDA@mail.gmail.com>
References: <1311292338-11830-1-git-send-email-khilman@ti.com>
 <1311292338-11830-9-git-send-email-khilman@ti.com> <20110730120332.GA15539@n2100.arm.linux.org.uk>
 <20110731025807.GA24334@ponder.secretlab.ca> <20110731150540.GA3019@n2100.arm.linux.org.uk>
 <871ux5nnop.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f171.google.com ([209.85.215.171]:46724 "EHLO
	mail-ey0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752876Ab1HAPom convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Aug 2011 11:44:42 -0400
Received: by eye22 with SMTP id 22so4651967eye.2
        for <linux-omap@vger.kernel.org>; Mon, 01 Aug 2011 08:44:40 -0700 (PDT)
In-Reply-To: <871ux5nnop.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, "G. Manjunath Kondaiah" <manjugk@ti.com>, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

On Mon, Aug 1, 2011 at 4:42 PM, Kevin Hilman <khilman@ti.com> wrote:
> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
>
>> On Sat, Jul 30, 2011 at 08:58:07PM -0600, Grant Likely wrote:
>>> On Sat, Jul 30, 2011 at 01:03:32PM +0100, Russell King - ARM Linux =
wrote:
>>> > On Thu, Jul 21, 2011 at 04:52:18PM -0700, Kevin Hilman wrote:
>>> > > Rather than embedding a struct platform_device inside a struct
>>> > > omap_device, decouple them, leaving only a pointer to the
>>> > > platform_device inside the omap_device.
>>> > >
>>> > > This patch uses devres to allocate and attach the omap_device t=
o the
>>> > > struct device, so finding an omap_device from a struct device m=
eans
>>> > > using devres_find(), and the to_omap_device() helper function w=
as
>>> > > modified accordingly.
>>> > >
>>> > > RFC/Hack alert:
>>> > >
>>> > > Currently the driver core (drivers/base/dd.c) doesn't expect an=
y
>>> > > devres resources to exist before the driver's ->probe() is call=
ed. =A0In
>>> > > this patch, I just comment out the warning, but we'll need to
>>> > > understand why that limitation exists, and if it's a real limit=
ation.
>>> > > A first glance suggests that it's not really needed. =A0If this=
 is a
>>> > > true limitation, we'll need to find some way other than devres =
to
>>> > > attach an omap_device to a struct device.
>>> > >
>>> > > On OMAP, we will need an omap_device attached to a struct devic=
e
>>> > > before probe because device HW may be disabled in probe and dri=
vers
>>> > > are expected to use runtime PM in ->probe() to activate the har=
dware
>>> > > before access. =A0Because the runtime PM API calls use omap_dev=
ice (via
>>> > > our PM domain layer), we need omap_device attached to a
>>> > > platform_device before probe.
>>> >
>>> > This feels really wrong to overload devres with this. =A0devres p=
urpose is
>>> > to provide the device's _drivers_ with a way to allocate and free=
 resources
>>> > in such a way to avoid leaks on .remove or probe failure. =A0So I=
 think that
>>> > overloading it with something that has a different lifetime is co=
mpletely
>>> > wrong.
>>>
>>> I disagree; extending devres to also handle device lifetime scoped
>>> resources makes perfect sense. It is a clean extension, and struct =
device
>>> is really getting rather huge. =A0I certainly prefer re-scoping dev=
res
>>> to adding more elements to struct device.
>>
>> The point is you're asking something which is designed to have a wel=
l
>> defined lifetime of driver-bind...driver-unbind to do a lot more tha=
n
>> that - extending its lifetime conditional on some flag to the entire
>> device lifetime instead.
>>
>> Such extensions tend to be a disaster - and a recipe for confusion a=
s
>> people will no longer have a clear idea of the lifetime issues. =A0W=
e
>> already know that people absolutely struggle to understand lifed
>> objects - we see it time and time again where people directly kfree
>> stuff like platform devices without thinking about whether they're
>> still in use.
>>
>> So no, extending devres is a _big_ mistake and is far from clean.
>>
>> Not only that, but if most of the platform devices are omap devices,
>> (as it would be on OMAP), you'll consume more memory through having =
to
>> have the additional management structs for the omap_device stuff tha=
n
>> a simple pointer.
>>
>> As for struct device getting rather huge, last time I looked it cont=
ained
>> a load of stuff which was there whether or not a platform used it. =A0=
Eg,
>> you get 4 bytes wasted for an of_node whether you have DT support or=
 not.
>> If sizeof(struct device) really is a problem, then it needs the unus=
ed
>> stuff ifdef'd away. =A0So I don't buy the "its getting rather huge" =
argument.
>>
>>> > We could add a new member to struct dev_archdata or pdev_archdata=
 to carry
>>> > a pointer to this data, which I think would be a far cleaner (and=
 saner)
>>> > way to deal with this. =A0In much the same way as we already have=
 an of_node
>>> > member in struct device.
>>>
>>> Since this is just for omap_device, which by definition is arm-only=
, I
>>> don't have any strong objection to using pdev_archdata. If it was
>>> cross-architecture, then I'd argue strongly for the devres approach=
=2E
>>
>> Indeed, which is why I think putting it in the platform device archd=
ata
>> makes total sense, more sense than buggering up the clean devres lif=
etime
>> rules that we have today.
>
> OK, so I'll continue this approach using pdev_archdata, which would w=
ork
> fine for me. =A0It's currently empty, so I'll just add a 'void *' if =
it's
> OK with you Russell:
>
> diff --git a/arch/arm/include/asm/device.h b/arch/arm/include/asm/dev=
ice.h
> index 9f390ce..bb777cd 100644
> --- a/arch/arm/include/asm/device.h
> +++ b/arch/arm/include/asm/device.h
> @@ -13,6 +13,7 @@ struct dev_archdata {
> =A0};
>
> =A0struct pdev_archdata {
> + =A0 =A0 =A0 void *p;
> =A0};

struct omap_device *p;

Otherwise it is just asking for type safety problems.

g.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
