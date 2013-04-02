From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH 00/28] OMAP: DSS related board file changes
Date: Tue, 02 Apr 2013 11:40:17 +0300
Message-ID: <515A9971.80703@compulab.co.il>
References: <1364474962-20439-1-git-send-email-tomi.valkeinen@ti.com> <51546259.3000704@compulab.co.il> <51547462.3070803@ti.com> <5157F625.5070509@compulab.co.il> <515A9059.4020203@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:43803 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757101Ab3DBIkX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 2 Apr 2013 04:40:23 -0400
In-Reply-To: <515A9059.4020203@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>, Dmitry Lifshitz <lifshitz@compulab.co.il>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 04/02/13 11:01, Tomi Valkeinen wrote:
> On 2013-03-31 11:39, Igor Grinberg wrote:
>> On 03/28/13 18:48, Tomi Valkeinen wrote:
>>> On 2013-03-28 17:31, Igor Grinberg wrote:
>>>> On 03/28/13 14:48, Tomi Valkeinen wrote:
>>>>> So here are the DSS related board file changes for 3.10.
>>>>>
>>>>> First there are a bunch of patches adding the Kconfig options so that only one
>>>>> display device is created for a single video bus. Only Overo had more than two
>>>>> displays on the same bus, but unfortunately there were multiple boards with a
>>>>> setup that puts an LCD and DVI output on the same video bus.
>>>>
>>>> Hmmm, so basically, if one could switch the display at runtime...
>>>> This cannot be done anymore...
>>>> This sounds like feature removal, no?
>>>> I know several of our clients who used this feature
>>>> (at least for evaluation purposes).
>>
>>> At some point in time it was possible to have multiple displays for the
>>> same bus, and switch them at runtime.
>>
>>> Sometime later it was changed so that the board file adds all the
>>> displays, but only one (per bus) is actually added to the list of
>>> panels, but you could still set the default display in the kernel args,
>>> and thus you could select which display gets added.
>>
>> Yeah, I remember we had to hack this to have the functionality back...
> 
> Ok. You could've informed me so that I knew it's needed =). I've
> received no complaints about it, so I thought nobody is even using it.

Yeah, I know, we wanted to make sure that this is not our fault and when
we did and it worked, I've lost in the amount of patches for DSS that were
sent and what are the real intentions (also taking into account that it all
was post factum).

> 
>>> The reason why the multiple-displays-per-bus is problematic is that the
>>> video bus cannot be shared, and if we have multiple devices on the same
>>> bus, the drivers need extra trickery, delaying initializations, etc, to
>>> handle this. And it still doesn't work right, as it's easy to get two
>>> displays enabled at the same time, configuring the same video bus,
>>> creating a mess.
>>
>> Yep, looks like additional display manager framework is needed.
>> Which will manage the displays on per bus basis?
>>
>>
>>> Quite often the case is that the other displays are not even present
>>> physically. But it is true that some boards have gpio switches that can
>>> be used to change the display during runtime.
>>
>> I don't think the runtime switch requirement will ever go away, so we'd
>> better prepare for it wisely.
>>
>>
>>>> Is there any strong pros you obtain while removing this feature?
>>
>>> For an user, only indirectly. The change will make things sane on the
>>> display side, and will thus make it much easier to proceed towards DT
>>> adaptation, and Common Display Framework. While I can't say it's a
>>> strict must to remove this feature, I can say that it's been a constant
>>> headache for me for, well, ever. And I presume CDF would not have this
>>> feature anyway, as it's rather bad design.
>>
>> Well, I don't know about the CDF, but the runtime switch was there
>> for ages... Think of a DVI or an HDMI... they have the EDID stuff
>> to make the switch work as expected and it really brings multiple
>> displays to the same video bus.
>> I see this is only a meter of how we represent things.
>> Instead of real EDID (or in addition), that comes with the display,
>> currently we have the panel info already in the kernel and
>> panel driver with board specific callbacks to make it work.
>> So abstracting the above (in the long run) to CDF or some other
>> framework, should suit everybody's needs.
>> Probably, we will need board specific drivers, but that never
>> was a problem...
> 
> Comparing desktop DVI/HDMI to our case is not a very good comparison.
> For desktop DVI/HDMI there are no panel devices or such, so it's trivial
> to manage multiple outputs in the display driver.

Well, reading EDID can sometimes involve additional hackery, but you are
right in the general case.

> 
> We need panel device hotplug/unplug support to make this work properly,
> and as there's no generic way to do that, we need board specific drivers
> to handle the hotplug/unplug.

Yep, I don't see any problem with having board specific drivers.
Multiple subsystems have them, so we also can have them in CDF.

> 
> And we probably need some way to show the information about possible
> displays to the userspace. I mean, with a case like DVI/Panel on the
> board, it would make sense to show the userspace that there are those
> two options, even if the other device is not even present.

Indeed this is needed for the runtime switch.


- -- 
Regards,
Igor.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRWplwAAoJEBDE8YO64EfaKH4P/jaMuXrGyvCmfYgD5OLFU0fV
BvsLyy0/DVqoDjB2N8YH8PnuixKrP17L8nEDckq725byXf/ZQEIaYTeyBZ/COYDD
NGAkVn8sFe2w7FLsg+dVa2+GSgYL2Pprvvf4DrJy1JMepBsDlaSkZL7V5LOq7m7J
7PIMizeZIngeDy4OHu4BNAksylPUj/3iqPDGJ9BZpgzoj1TwbPDG/ECyKADD9J8+
JHrK+aSnJFI/5qE+J1j+6ghYhDnIz5OQqtjA/CHNLaBOloNIk6FxgbMAt+Eu+xBZ
7zZ9kk/Esh1QwfdelHHkH1gW7ogfsBqa5lvJ3pa/R06lOaeEAewUSpSzF02+fVqN
hg3shXOjw5ukjxqDytvOtPjb9vJrJ2nHRa2ftmEo2f5w2CJOyOgul1B+QODjztgb
VJCGhAt/+RSxI2RvmRkR9jgG/GNm3psFSBGWQbMN4jND9/ToNEJBDbBP2ewiPe7i
a3ZtAD0ZiUF9sWt27e3r6jT2nHwp0/35uVTigeHzJBTnwliykO/djhyxgO+IGDKn
9iugdPJceh1L8HBfJ+u+MdN+2qpNONzAvP8N1GJWiL5U8hzkR6wNb/r5Hk0gDxaG
crPn8c3BrmSlEcy7kywM2MOe14wZOMPGW5H2LQ6lPA2VXGz4iFioeM3TdEMMv11H
pxMvFk4hNPbXgwSyHlAj
=H7CL
-----END PGP SIGNATURE-----
