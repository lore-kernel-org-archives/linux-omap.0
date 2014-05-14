From: Pantelis Antoniou <pantelis.antoniou@gmail.com>
Subject: Re: [PATCH v2] ARM: dts: am335x-bone-common: Add i2c2 definition
Date: Tue, 13 May 2014 20:39:25 -0700
Message-ID: <2A5F30DB-EF92-4CFC-BA3C-4ECAE36FD4FF@gmail.com>
References: <1399686184-1594-1-git-send-email-mranostay@gmail.com> <20140512195050.GB5668@atomide.com> <CAOCHtYiYwx_bEsyqkbUTTAbhBYESzvfBOOYeVuFXPS1dDy0ZKA@mail.gmail.com> <20140512201517.GC5668@atomide.com> <CAOCHtYg6XpF0Gbo4iFqsFvP=QSivQQvCzov8UfxeLXMzrRYEWw@mail.gmail.com> <20140512204213.GD5668@atomide.com> <CAOCHtYgg7jwxswH+mqF3RA7-0RP-nGuft+Ze-GRwu1fbA6+0Bw@mail.gmail.com> <537215D3.70306@ti.com> <CABxcv=nq9XvyN0aPOBFDm0UyoaW-Htyy0tyP3YhYaDnDUo3a5w@mail.gmail.com> <20140513142252.GG32082@beef> <CABxcv=mSs71pS1PAS-WdP0ru_Eb1XhXEm1qCCKW7=aL7EN4FgQ@mail.gmail.com> <4BCFCB24-9732-4B96-B814-5290CA2D0EE4@gmail.com> <CABxcv=mWqENSzODJYAJRgDYNy46X6WkQ+0e4NSDt8qE-ob1KuQ@mail.gmail.com> <CF97C6D2.246DE%john3909@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yh0-f41.google.com ([209.85.213.41]:33143 "EHLO
	mail-yh0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751958AbaENDja convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 May 2014 23:39:30 -0400
In-Reply-To: <CF97C6D2.246DE%john3909@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: John Syn <john3909@gmail.com>
Cc: Javier Martinez Canillas <javier@dowhile0.org>, Matt Porter <matt.porter@linaro.org>, Tom Rini <trini@ti.com>, Robert Nelson <robertcnelson@gmail.com>, Tony Lindgren <tony@atomide.com>, Matt Ranostay <mranostay@gmail.com>, robh+dt@kernel.org, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, linux kernel <linux-kernel@vger.kernel.org>

Hi John,

On May 13, 2014, at 1:24 PM, John Syn wrote:

>=20
> On 5/13/14, 10:51 AM, "Javier Martinez Canillas" <javier@dowhile0.org=
>
> wrote:
>=20
>> Hello Pantelis,
>>=20
>> On Tue, May 13, 2014 at 7:07 PM, Pantelis Antoniou
>> <pantelis.antoniou@gmail.com> wrote:
>>> Hi Javier,
>>>=20
>>> On May 13, 2014, at 7:39 AM, Javier Martinez Canillas wrote:
>>>=20
>>>> On Tue, May 13, 2014 at 4:22 PM, Matt Porter <matt.porter@linaro.o=
rg>
>>>> wrote:
>>>>> On Tue, May 13, 2014 at 04:06:02PM +0200, Javier Martinez Canilla=
s
>>>>> wrote:
>>>>>> On Tue, May 13, 2014 at 2:53 PM, Tom Rini <trini@ti.com> wrote:
>>>>>>> On 05/12/2014 04:57 PM, Robert Nelson wrote:
>>>>>>>>>> Either case if fine with me.  As who knows when the dtc
>>>>>>>>>> "overlay" will
>>>>>>>>>> every truly make it mainline, as the capemgr was the only re=
al
>>>>>>>>>> kernel
>>>>>>>>>> user of the i2c/at24 eeprom information.
>>>>>>>>>=20
>>>>>>>>> Sounds like we should keep it disabled though so u-boot can b=
e
>>>>>>>>> used
>>>>>>>>> to toggle it while waiting for the capemgr. That's because th=
e
>>>>>>>>> board
>>>>>>>>> has a header for pins, so it's not exactly limited to just th=
e
>>>>>>>>> capes.
>>>>>>>>>=20
>>>>>>>>> Anybody working on enabling/disabling cape dtb configurations=
 in
>>>>>>>>> u-boot?
>>>>>>>>=20
>>>>>>>> Well,
>>>>>>>>=20
>>>>>>>> Would Tom even approve of that in mainline u-boot? He didn't w=
ant
>>>>>>>> my
>>>>>>>> "invert" the gpio to enable the usb hub on the older beagle xm
>>>>>>>> A/B..
>>>>>>>>=20
>>>>>>>> http://lists.denx.de/pipermail/u-boot/2014-January/172154.html
>>>>>>>>=20
>>>>>>>> http://lists.denx.de/pipermail/u-boot/2014-January/172274.html
>>>>>>=20
>>>>>> Using fdt set from the bootloader to use the same FDT for simila=
r
>>>>>> boards (like the example with Beagle xM variants) is kind of try=
ing
>>>>>> to
>>>>>> replicate what we used to do from boards files where it was poss=
ible
>>>>>> to manage a set of boards using the same platform code.
>>>>>>=20
>>>>>> But Device Trees are meant to describe hardware and thus should =
be
>>>>>> static, if two board are almost identical but slightly different=
,
>>>>>> then
>>>>>> are two different hardware where each need its proper FDT that
>>>>>> describes it.
>>>>>>=20
>>>>>>>=20
>>>>>>> I would think that using the 'fdt' command in U-Boot to add all
>>>>>>> properties of every cape found on a running system would drive
>>>>>>> someone
>>>>>>> to madness quite quickly.  Moving all of Pantelis' work for dyn=
amic
>>>>>>> device trees from the kernel to N bootloaders (U-Boot, barebox,
>>>>>>> UEFI,
>>>>>>> etc) sounds like a step in the wrong direction.
>>>>>>>=20
>>>>>>=20
>>>>>> Agreed. I think that until the device tree overlay and the cape
>>>>>> manager find their way into mainline we should treat capes as if=
 they
>>>>>> were expansion boards attached to a Computer-on-Module. That is,=
 a
>>>>>> static based board which its own DTS including the BB{B,W} as an=
 dtsi
>>>>>> and not something that can be added on runtime.
>>>>>=20
>>>>> It's far more complicated than a SOM plus carrier board. Consider=
 that
>>>>> you can have any 4 of these capes stacked on the BBB/BBW in any
>>>>> combination (assuming no resource conflicts). Capturing all possi=
ble
>>>>> combinations in static dtsis is not practical.
>>>>>=20
>>>>=20
>>>=20
>>> Since this appears to be all coming back to DT overlays, let me try=
 to
>>> address some points.
>>>=20
>>=20
>> It seems that you misunderstood my comments. I do think that DT
>> overlays and the cape manager are a great solution for any hardware
>> that could be expanded on runtime and I really hope that they can
>> eventually land into mainline.
>>=20
>> In fact if you look on my previous mail you will see that I said:
>> "until device tree overlay and the cape manager find their way into
>> mainline..."
>>=20
>>>> Right, I forgot that the capes were stackable so is indeed not
>>>> practical to model every single combination as DTS in mainline. Ev=
en
>>>> if stacking was not possible there are just too many capes out the=
re
>>>> to have a DTS for every single cape.
>>>>=20
>>>=20
>>> Each cape does have a DTS as dynamically loaded fragment; it works
>>> absolutely fine.
>>>=20
>>> Trying to come up with a base DTS for all the capes you've stacked =
up
>>> is an exponential problem.
>>>=20
>>>> My point was that someone who wants to use a BBB + a set of capes =
can
>>>> today write a DTS for its own stacked setup.
>>>>=20
>>>=20
>>> No, the guy that designs a cape (or learns how to) can not write a =
DTS
>>> for
>>> the base board and the cape in question. Doing that he essentially =
cuts
>>> himself off from the community.
>>>=20
>>> Let me explain, the point is for people to easily design capes,
>>> open-source their
>>> design as well as their software, and share them to the community.
>>>=20
>>> This requires that things are easily shareable.
>>>=20
>>> Requiring a relative newbie in kernel development not only generate=
 his
>>> own
>>> base DT, but also to merge all of the other capes DT into his own i=
s a
>>> nightmare.
>>>=20
>>> BTW, on another tangent, it's not just the BB people that care abou=
t
>>> dynamic
>>> hardware configuration. There are a number of FPGA people that seem
>>> interested
>>> as well.
>>>=20
>>> The notion of hardware as something static that never changes is
>>> obsolete IMHO.
>>>=20
>>>> Unfortunately I don't have a solution but what I'm pretty sure is =
that
>>>> mangling the DTS from the bootloader is not the right one :-)
>>>>=20
>>>=20
>>> No, it is not. And this is what we're trying to solve here.
>>>=20
>>=20
>> What I said that I'm against is modifying a FDT using U-Boot scripts
>> commands that is something that mentioned in this thread. That is no=
t
>> a robust way to do it and also is not something that a newbie could =
do
>> it neither.
>>=20
>> Also, doing these FDT changes in the bootloader has several
>> disadvantages, besides having to implement on each bootloaders like
>> Tom said, you need to upgrade your bootloader which is something tha=
t
>> just can't be done on many boards and also is still a static
>> configuration since you need to reboot in order to use a different
>> FDT. So the hardware can't really be expanded on runtime unlike with
>> DT overlays where the overlays are loaded from regular files.
>>=20
>> But I guess you agree with me on all those points and you just
>> misunderstood my comments. So DT overlays is definitely the way to g=
o
>> (or something similar) but my point is that until we have that
>> solution merged, you can use a static DT in mainline for your stacke=
d
>> cape or use a vendor kernel that already has DT overlays support.
>=20
> Given that we are not hot plugging capes, why do we need to modify th=
e DT
> at runtime? Even FPGA developers are not modifying their I/O at runti=
me.
> For example, using the BBB as a reference, why not add an am335x-cape=
-dtsi
> to the am335x-boneblack.dts as follows:
>=20
> /dts-v1/;
>=20
> /include/ "am33xx.dtsi"
>=20
> /include/ "am335x-bone-common.dtsi=B2
>=20
> /include/ =B3am335x-cape.dtsi"
>=20
> &am33xx_pinmux {
> xxx
>=20
> and =B3am335x-cape.dtsi=B2 would look like this:
>=20
> /include/ =B3BB-BONE-AUDI-00A0.dtsi=B2
> /include/ =B3BB-BONE-UART1-00A0.dtsi=B2
> xxx
>=20
> So, cape developers create their own DTSI and users only update the
> am335x-cape.dtsi to include the cape DT required.
>=20
> What am I missing?=20
>=20
> BTW, DTC should be updated to detect I/O conflicts. Waiting for the k=
ernel
> to boot before detecting DT conflicts isn=B9t OK.
>=20
> Regards,
> John
>=20
>=20

=46or a single cape that's fine.

Now handle the case where your cape must work with any kind of cape com=
bination with a same
kernel+dtb+rootfs image.

The point is that you want to get each cape developer contribute back t=
o the official release,
and to get people to use your stuff without recompiling anything.

No-one making distro-releases is willing to handle a few dozens of DTBs=
 for all the combinations.

Regards

-- Pantelis

>=20
>>=20
>> I hope I explained myself better this time ;-)
>>=20
>> Best regards,
>> Javier
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
