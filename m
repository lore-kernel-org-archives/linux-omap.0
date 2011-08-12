From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: How to handle named resources with DT?
Date: Fri, 12 Aug 2011 11:21:43 -0600
Message-ID: <CACxGe6s-2EAuvSqzn6yzDvCyVXa8vVVqG2X=1XFrUBnB=jsdxQ@mail.gmail.com>
References: <20110809205723.GE11568@ponder.secretlab.ca> <20110812030218.GP30552@yookeroo.fritz.box>
 <20110812084106.GC19467@legolas.emea.dhcp.ti.com> <201108121635.42953.arnd@arndb.de>
 <4E45422D.4050708@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:54411 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751068Ab1HLRWE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Aug 2011 13:22:04 -0400
Received: by vxi9 with SMTP id 9so2539577vxi.19
        for <linux-omap@vger.kernel.org>; Fri, 12 Aug 2011 10:22:03 -0700 (PDT)
In-Reply-To: <4E45422D.4050708@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Balbi, Felipe" <balbi@ti.com>, David Gibson <david@gibson.dropbear.id.au>, "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, "G, Manjunath Kondaiah" <manjugk@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Scott Wood <scottwood@freescale.com>, linux-omap <linux-omap@vger.kernel.org>

On Fri, Aug 12, 2011 at 9:09 AM, Cousson, Benoit <b-cousson@ti.com> wro=
te:
> On 8/12/2011 4:35 PM, Arnd Bergmann wrote:
>> It only make sense for drivers that support both device tree probing
>> and legacy probing of static platform devices.
>>
>> Note how almost all drivers use only platform_get_resource and not
>> platform_get_resource_byname:
>>
>> arnd@ocdc-kvm:~/linux-arm$ git grep -wl platform_get_resource | wc -=
l
>> 565
>> arnd@ocdc-kvm:~/linux-arm$ git grep -wl platform_get_resource_byname=
 | wc
>> -l
>> 41
>> arnd@ocdc-kvm:~/linux-arm$ git grep -wl platform_get_resource_byname=
 |
>> xargs grep -wL platform_get_resource | wc -l # both
>> 28
>> arnd@ocdc-kvm:~/linux-arm$ git grep -wl platform_get_resource_byname=
 |
>> xargs grep -wl platform_get_resource =A0| wc -l # only _byname
>> 13
>
> That's true, but this is mainly because most of the time there is onl=
y one
> irq, dma or mem resource, so the _byname is not useful.
> As soon as you start having multiple entries, relying on the order be=
come
> less readable and error prone. Then getting the resource by name beco=
me
> useful.
> There are probably a lot of API that are less used than this one, but=
 does
> that mean that we have to remove them?
>
> The extreme case (soon in mainline) in OMAP is that one:
>
> static struct omap_hwmod_addr_space omap44xx_aess_addrs[] =3D {
> =A0 =A0 =A0 =A0{
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =A0 =A0 =A0 =A0 =A0 =3D "dmem",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.pa_start =A0 =A0 =A0 =3D 0x40180000,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.pa_end =A0 =A0 =A0 =A0 =3D 0x4018ffff
> =A0 =A0 =A0 =A0},
> =A0 =A0 =A0 =A0{
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =A0 =A0 =A0 =A0 =A0 =3D "cmem",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.pa_start =A0 =A0 =A0 =3D 0x401a0000,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.pa_end =A0 =A0 =A0 =A0 =3D 0x401a1fff
> =A0 =A0 =A0 =A0},
> =A0 =A0 =A0 =A0{
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =A0 =A0 =A0 =A0 =A0 =3D "smem",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.pa_start =A0 =A0 =A0 =3D 0x401c0000,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.pa_end =A0 =A0 =A0 =A0 =3D 0x401c5fff
> =A0 =A0 =A0 =A0},
> =A0 =A0 =A0 =A0{
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =A0 =A0 =A0 =A0 =A0 =3D "pmem",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.pa_start =A0 =A0 =A0 =3D 0x401e0000,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.pa_end =A0 =A0 =A0 =A0 =3D 0x401e1fff
> =A0 =A0 =A0 =A0},
> =A0 =A0 =A0 =A0{
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =A0 =A0 =A0 =A0 =A0 =3D "reg",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.pa_start =A0 =A0 =A0 =3D 0x401f1000,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.pa_end =A0 =A0 =A0 =A0 =3D 0x401f13ff=
,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.flags =A0 =A0 =A0 =A0 =A0=3D ADDR_TYP=
E_RT
> =A0 =A0}
> };
>
> In that case, the driver knows exactly where is the relevant memory b=
uffer
> he has to use.
>
>> I think it's much easier to change the existing users of _byname ove=
r
>> to fixed indexes than to come up with a new scheme that is better.
>
> As you said previously, since we have to support both legacy probing =
and DT
> for some time, it will be easier for these drivers to rely on the sam=
e API.
>
> Considering that adding that new property is not a huge effort anyway=
 and
> _byname API is a standard API that any driver should be able to use i=
f
> needed, it still worth adding the DT support for named resources for =
my
> point of view.

The assumption being made here is that the current Linux
implementation detail dictates the binding design, but it does not.
Binding authors should certainly look at the Linux implementation for
inspiration, but established DT patterns still prevail if they are
suitable for describing the hardware. In this case the pattern is that
tuples in the reg property are strongly ordered and specified by the
driver binding.

So, I remain unconvinced that the 'reg' property binding is
insufficient.  I have no plans to merge support for fetching _byname
values from the device tree.

g.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
