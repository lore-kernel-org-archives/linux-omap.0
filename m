From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH 08/28] ARM: OMAP: CM-T35: Kconfig option for the display
 options
Date: Tue, 02 Apr 2013 14:20:53 +0300
Message-ID: <515ABF15.9070400@compulab.co.il>
References: <1364474962-20439-1-git-send-email-tomi.valkeinen@ti.com> <1364474962-20439-9-git-send-email-tomi.valkeinen@ti.com> <51546B2C.2030101@compulab.co.il> <51547790.7010108@ti.com> <5157FF21.9000702@compulab.co.il> <515A91CA.7060801@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:53438 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751621Ab3DBLVE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 2 Apr 2013 07:21:04 -0400
In-Reply-To: <515A91CA.7060801@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>, Mike Rapoport <mike@compulab.co.il>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 04/02/13 11:07, Tomi Valkeinen wrote:
> On 2013-03-31 12:17, Igor Grinberg wrote:
>>
>>
>> On 03/28/13 19:02, Tomi Valkeinen wrote:
>>> On 2013-03-28 18:09, Igor Grinberg wrote:
>>>> On 03/28/13 14:49, Tomi Valkeinen wrote:
>>>>> Boards with multiple display options for the same video bus have all the
>>>>> possible linux display devices present at the same time. Only one of
>>>>> those devices should be used at a time, as the video bus cannot be
>>>>> shared.
>>>>
>>>> Yes, only one can be used at a time, but you can switch at runtime...
>>
>>> Yep. But the panel drivers need to know about this, and they cannot do
>>> more or less anything in the driver probe function, which I think should
>>> be the place to reserve resources and do initialization. With the
>>> current model that would lead to multiple drivers trying to acquire the
>>> same resources.
>>
>> Yep, this is a problem, but it only means that probably
>> the platform device framework is not suitable for this.
>>
>> What about having some kind of display manager which will have a private
>> list of registered devices and will instantiate only those that are marked
>> active?
>> This also might be useful with DT.
> 
> We can't have a generic manager that handles instantiating the devices,
> as we don't know what device they are. They could be platform devices,
> i2c, anything. There could even be a single device that creates multiple
> displays.

Unless, the registered device node is descriptive enough,
or the device node can "instantiate itself".
We use the "ops" structures all over the kernel.

What about the capebus? Can it help with abstracting such things?

> 
>>>>> This model is hacky, and will be changed in the forthcoming DSS patches
>>>>> to a model where only one display device can be present on a single
>>>>> video bus.
>>>>
>>>> What do you mean by "present"?
>>>> Is it active? or registered? or compiled in?
>>
>>> I mean that only one device can be registered. Well, nothing strictly
>>> prevents having multiple devices registered, but if the devices have
>>> matching drivers, the drivers would acquire the same resources. Possibly
>>> the same gpios, but at least the same video bus.
>>
>> Well, I think, we should follow/extend the already existing EDID concept...
>> Instantiate a display device only when one has been "plugged in".
>> By "plugged in" I mean enabled - made active.
> 
> This brings the complication that we need a way to make the display
> active even if the display device doesn't exist. So we need to know
> about the display even if it's not there.

Yes, well, I mean that the process of making the display active can
involve registering the display device, no?
And yes, it does bring the complication, but I don't really see a way we
can avoid such complications and yet support the modern hardware.


- -- 
Regards,
Igor.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRWr8VAAoJEBDE8YO64Efa5sgP/ArPjYtGakOnWkbFah5ClnPH
sOMDwnTEW76rLpXzPE63dTBIImiBhKpaKNKK3pxdPH7uhZ5qr1usi/s/W59MPrYA
7lsZnkdsJLk/piFKk1IdB9Q+ke7qftCEmVTrv9fXtYrojZ9NHH1yGqmjQIINyzUm
hGTbplKUldfMSh9z+XszUcGgBkkZQgMd435eJKOYw9Bny56u0ekOfPIo5pHTJioc
F4gQybWQ41hpBVWe8OkYH8tN9hOnujbdgQ+K4K5JYizJV0NYnGgxESvescieAINn
0INEYhiyD97Fcr6sFFjOSqkLTZoBaXFLDl0EPWqasImf5sCLapmtkqfpMRlUjoiW
MiVv6XACE5AmFicivjPowDn01HurH0Q8aXXhvhtSEu8oLePN3gH5PW9P6VIjAUbM
85OT+VkPfWIUupw2aeygy+ePoBpjj4NtZWzhpxzdDi/k5HkrZvSh3uGernCbAsYj
/JV4wZRQQVml7j65uYRLmnKx+tMbBnd/QU96OLdSOdGaNor+bY0x0zDcy4DAKuw3
/W0HPGMr6dctBOb26ofYn97jxjLAcULKTWffykxktNyB1ODzN2NdEUnUv6rtq4Bv
6EA7EaK1dehM2TV4eVNiCxxvv88Kk58uJqzuxvx2BHGtDkbygJGxkBZ41/MNWQOT
3UMYsUEKecOie5cT+JtG
=IrRQ
-----END PGP SIGNATURE-----
