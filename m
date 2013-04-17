From: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 3/5] gpio/omap: Add DT support to GPIO driver
Date: Wed, 17 Apr 2013 08:25:05 -0500
Message-ID: <516EA2B1.3070201@ti.com>
References: <1329321854-24490-1-git-send-email-b-cousson@ti.com>
 <CACRpkdYXVLgCz1Tyu-Ls2V2OTc4R3cGNJhfQJB6Hiz_K9dkZYQ@mail.gmail.com>
 <5155C902.7080207@wwwdotorg.org>
 <CACRpkdYbs4-uudpRUY8e+7icYYkZrfM0kReP3pLL5DMiURJ4dg@mail.gmail.com>
 <5165CB9D.1090202@wwwdotorg.org>
 <CACRpkdYirFNqmGhA4K9CL4ve4NYhs8Rd3SFt1iwW9vHBkrcz8g@mail.gmail.com>
 <51671D7B.5060303@wwwdotorg.org>
 <CACRpkdbf32Ef77GmXk9id9+RRjcDRTr7S+F4nznoeZU8y=BT_Q@mail.gmail.com>
 <51673D70.3010503@wwwdotorg.org>
 <CAAwP0s0e2x33jZQhFRY+Hoo61SFqYKRgWk=1mL2+DNxSDJHz+A@mail.gmail.com>
 <CACRpkda4h+qXTvsirPAS7E7sjXhMLE62q=VDy53W8UchsYjbNg@mail.gmail.com>
 <516C31C3.9040505@wwwdotorg.org> <516C7C43.3040105@wwwdotorg.org>
 <516C8760.2050500@ti.com> <516D9B05.1000501@wwwdotorg.org>
 <516DA60A.5070000@ti.com> <516DCCA8.3070108@wwwdotorg.org>
 <516DDB4D.9020500@ti.com>
 <CAAwP0s0-VNUoeSKaGbvoDeD7m7kZRdp5rCJ7iVpFoFAaQtXcmQ@mail.gmail.com>
 <516E022F.5050708@ti.com>
 <CAAwP0s2M2pnSydyDvh_rejFO=w8bCo4WE5PkxrYuk0HQDixc-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <CAAwP0s2M2pnSydyDvh_rejFO=w8bCo4WE5PkxrYuk0HQDixc-Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Javier Martinez Canillas <martinez.javier-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


On 04/17/2013 02:55 AM, Javier Martinez Canillas wrote:

...

> There are so many patches flying around in this thread that I missed it :-)
> 
> Sorry about that...

No problem.

>> I was trying to see if we could find a common solution that everyone
>> could use as it seems that ideally we should all be requesting the gpio.
>>
>> Cheers
>> Jon
>>
>> [1] http://marc.info/?l=linux-arm-kernel&m=136606204823845&w=1
> 
> btw, I shared the latest patch with only build testing it, but today I
> gave a try and I found a problem with this approach. The .xlate
> function is being called twice for each GPIO-IRQ so the first time
> gpio_request_one() succeeds but the second time it fails returning
> -EBUSY.

I tried it and I did not see that. I don't see the below warning either.

> This raises a warning on drivers/of/platform.c
> (WARN_ON(of_irq_to_resource_table(np, res, num_irq) != num_irq)):
> 
>     0.285308] ------------[ cut here ]------------
> [    0.285369] WARNING: at drivers/of/platform.c:171
> of_device_alloc+0x154/0x168()
> [    0.285430] Modules linked in:
> [    0.285491] [<c001a944>] (unwind_backtrace+0x0/0xf0) from
> [<c0041edc>] (warn_slowpath_common+0x4c/0x68)
> [    0.285552] [<c0041edc>] (warn_slowpath_common+0x4c/0x68) from
> [<c0041f14>] (warn_slowpath_null+0x1c/0x24)
> [    0.285614] [<c0041f14>] (warn_slowpath_null+0x1c/0x24) from
> [<c041ac3c>] (of_device_alloc+0x154/0x168)
> [    0.285675] [<c041ac3c>] (of_device_alloc+0x154/0x168) from
> [<c041ac84>] (of_platform_device_create_pdata+0x34/0x80)
> [    0.285736] [<c041ac84>]
> (of_platform_device_create_pdata+0x34/0x80) from [<c0027364>]
> (gpmc_probe_generic_child+0x180/0x240)
> [    0.285827] [<c0027364>] (gpmc_probe_generic_child+0x180/0x240)
> from [<c00278d8>] (gpmc_probe+0x4b4/0x614)
> [    0.285888] [<c00278d8>] (gpmc_probe+0x4b4/0x614) from [<c0325514>]
> (platform_drv_probe+0x18/0x1c)
> [    0.285949] [<c0325514>] (platform_drv_probe+0x18/0x1c) from
> [<c0324354>] (driver_probe_device+0x108/0x21c)

Any chance you have still have some additional code in your dts to
request the gpio? I recall you made some hacks to make this work before.

> I probably won't have time to dig further on this until later this
> week but I wanted to share with you in case you know why is being
> calling twice and if you thought about a solution.

Care to post your dts file?

> It works if I don't check the return gpio_request_one() (or better if
> we don't return on omap_gpio_irq_domain_xlate) but of course is not
> the right solution.

Yes we need to check the return value.

Cheers
Jon
