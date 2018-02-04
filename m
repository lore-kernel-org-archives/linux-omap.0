From: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Subject: Re: power management problems in ehci-omap
Date: Sun, 4 Feb 2018 14:43:31 +0100
Message-ID: <7B2EB45F-AD8F-44ED-9EA6-486F8568BB05@goldelico.com>
References: <20180204000335.29812776@kemnade.info> <CAOf5uw=6RCJBPZd1fCi6+xb23THLRmXcfqsNtiZQeM=oKx0VvQ@mail.gmail.com> <20180204093831.44322452@kemnade.info> <CAOf5uwnoQtS+PnPO0t7Mf1qP9u_BgLPAX0h4EhiXfY7380QXng@mail.gmail.com> <20180204115052.2fe3e1db@kemnade.info> <CAOf5uwk_CYNBavy=miFEskAOdr9Hpa9jesJbXWRMLAEKseg8vg@mail.gmail.com> <6A0B83EE-3453-4BC4-8CB0-94EE83E2E1E7@goldelico.com> <CAOf5uwm1iWtn=xqm9LwCgjqBMPt0c-vr24X_Da0NbB0TP1NY5Q@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAOf5uwm1iWtn=xqm9LwCgjqBMPt0c-vr24X_Da0NbB0TP1NY5Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Nazzareno Trimarchi <michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>
Cc: Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Discussions about the Letux Kernel <letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,
Andreas seems to be travelling back from FOSDEM so I jump in with best =
of my knowledge.

> Am 04.02.2018 um 12:34 schrieb Michael Nazzareno Trimarchi =
<michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>:
>=20
> Hi
>=20
> On Sun, Feb 4, 2018 at 12:07 PM, H. Nikolaus Schaller =
<hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org> wrote:
>> Hi Michael,
>>=20
>>> Am 04.02.2018 um 11:55 schrieb Michael Nazzareno Trimarchi =
<michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>:
>>>=20
>>> Hi Andreas
>>>=20
>>> On Sun, Feb 4, 2018 at 11:50 AM, Andreas Kemnade =
<andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org> wrote:
>>>> Hi,
>>>>=20
>>>> On Sun, 4 Feb 2018 09:43:45 +0100
>>>> Michael Nazzareno Trimarchi <michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org> wrote:
>>>>=20
>>>>> Hi Andreas
>>>>>=20
>>>>> On Sun, Feb 4, 2018 at 9:38 AM, Andreas Kemnade =
<andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org> wrote:
>>>>>> On Sun, 4 Feb 2018 00:10:50 +0100
>>>>>> Michael Nazzareno Trimarchi <michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org> wrote:
>>>>>>=20
>>>>>>> Hi
>>>>>>>=20
>>>>>>> On Sun, Feb 4, 2018 at 12:03 AM, Andreas Kemnade =
<andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org> wrote:
>>>>>>>> Hi,
>>>>>>>>=20
>>>>>>>> I booted a 4.15 kernel without udev and loaded modules piece by =
piece to analyze
>>>>>>>> pm problems. modprobe ehci-omap increases current by around =
35mA and
>>>>>>>> also rmmod ehci-omap does not let it go down at all.
>>>>>>>>=20
>>>>>>>> I expect that removing hardware does the same thing
>>>>>> nonsense sentence from me, was to tired. I would expect that =
removing the modules
>>>>>> properly powers down the device.
>>>>>>>>=20
>>>>>>>> Also suspend current increases by around 15mA if that module is =
loaded.
>>>>>>>> I tested with having everything disabled which is attached to =
that usb bus.
>>>>>>>>=20
>>>>>>>=20
>>>>>>> Do you have an LTE connected to the usb?
>>>>>>>=20
>>>>>> Yes, there is a UMTS modem attached, but it was off during the =
tests.
>>>>>> It did not enumerate on the modem.
>>>>>>=20
>>>>>=20
>>>>> Just to understand if the suspend current drop was connected to =
the
>>>>> suspend of lte modem on your side.
>>>>> So you don't have anything connected on usb bus?
>>>>>=20
>>>> Suspend current is increased when the ehci-omap module is loaded
>>>> in comparison to the state. I tested with the modem disabled, so =
there
>>>> is nothing on the bus. Increased suspend current is one thing,
>>>> current_before_modprobe_ehci_omap !=3D =
current_after_rmmod_ehci_omap.
>>>>=20
>>>> I am testing with init=3Dsome_testscript.sh, so no userspace
>>>> is doing strange things. No module autoload or something.
>>>>=20
>>>=20
>>> How many port are configured and how is the phy part connected to =
the
>>> ehci controller?
>>> Can you point me the schematic page?
>>=20
>> it is essentially a copy&paste from BeagleBoard XM.
>>=20
>> Schematics of the GTA04 are here:
>>=20
>>        http://projects.goldelico.com/p/gta04-main/downloads/48/
>>=20
>> USB PHY is on page 9.
>>=20
>=20
> I see. GPIO174 is controlled by you during boot or connected to the =
dts?
> I don't find in mainline the connection to the physical and it's own
> programming.
> Can you check if the phy is in reset when module is remove?

The reset gpio is defined in the respective board-DTS:

=
https://elixir.free-electrons.com/linux/v4.15/source/arch/arm/boot/dts/oma=
p3-beagle-xm.dts#L88
=
https://elixir.free-electrons.com/linux/v4.15/source/arch/arm/boot/dts/oma=
p3-gta04.dtsi#L120

BR,
Nikolaus

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
