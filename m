From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: Lay common foundation to make PVR/SGX work without hacks on OMAP34xx, OMAP36xx, AM335x and potentially OMAP4, OMAP5
Date: Wed, 14 Aug 2019 10:56:29 +0200
Message-ID: <BFAA7FA6-A352-476A-99F9-02EA663A6AAD@goldelico.com>
References: <20180108214032.GW3872@atomide.com> <4d99c1ae-7752-949b-7e88-bc8f1dc594a2@wizzup.org> <0C51EC59-9CDC-4196-ACF9-24596C9E61B6@goldelico.com> <FA4520D5-62CB-446D-975C-A1C7B9251517@goldelico.com> <20190212205132.GO5720@atomide.com> <0b00ce0a-969f-e638-8247-c2da96cf7ce6@gmail.com> <20190213004143.GP5720@atomide.com> <480AB632-A544-41E7-95A4-DC354AEBB71A@goldelico.com> <CAKpie0SigGGsQxSU+X-Mz5boy-Xx=3wRNOcrf+F=ehFr3RBi7Q@mail.gmail.com> <092210C3-05DE-4AFB-986F-81BD8F990B67@goldelico.com> <CAKpie0RXM1UC33YFeFy-kAxfGhYGNkw4vUgNTThf-ZCAhPTVXw@mail.gmail.com> <BE23C1E4-2877-49FA-B230-F9C10691B805@goldelico.com> <CAKpie0TSo-8gmDm9_Zw4Sd+kjVVEomp8yA9Vu8qY2U2AcrQc=w@mail.gmail.com> <8A069D96-C65F-43F5-8F54-20019CFB1A8D@goldelico.com> <d0cbfaaf-813e-8803-f90b-931a38396750@wizzup.org> <3A03F
 F16-C203-43ED-AEEF-0260F6B3331A@goldelico.com> <3b0a5e78-c4c2-1963-bac7-b49496a1e9b9@wizzup.org> <1F942AAB-1648-46C0-ADD5-90F6898778BE@goldelico.com> <84cac9b8-0eff-33f8-464d-4f8045d7db19@wizzup.org>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <84cac9b8-0eff-33f8-464d-4f8045d7db19@wizzup.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Merlijn Wajer <merlijn@wizzup.org>, Tony Lindgren <tony@atomide.com>, =?utf-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>, Philipp Rossak <embed3d@gmail.com>, moaz korena <moaz@korena.xyz>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, =?utf-8?Q?Filip_Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>, Adam Ford <aford173@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, kernel@pyra-handheld.com, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, maemo-leste@lists.dyne.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi all,

> Am 17.07.2019 um 12:51 schrieb Merlijn Wajer <merlijn@wizzup.org>:
>=20
> Hi,
>=20
> On 10/03/2019 08:07, H. Nikolaus Schaller wrote:
>>=20
>>> Am 10.03.2019 um 00:14 schrieb Merlijn Wajer <merlijn@wizzup.org>:
>>>=20
>>> Hi,
>>>=20
>>> On 15/02/2019 14:09, H. Nikolaus Schaller wrote:
>>>=20
>>>>>> At least I can download and start firmware. I just have to find a =
way to fix the omaplfb so that it works
>>>>>> with our omapdrm based panels to runs the CLipBlit test [1] on =
modern kernels...
>>>>>=20
>>>>> Maybe you can compare with what we have here:
>>>>> =
https://github.com/maemo-leste/n9xx-linux/tree/pvr-wip-4.15.7/drivers/gpu/=
pvr
>>>>=20
>>>> I'll take a look into it especially how omaplfb is done.
>>>>=20
>>>> First observation is that there is a "flat" tree while I am working =
on a structured one...
>>>> But that is just a marginal difference (mainly significant for =
Makefile writers).
>>>=20
>>> I've ported the Maemo Leste kernel + pvr to 5.0 and it seems to =
work:
>>> https://github.com/maemo-leste/n9xx-linux/commits/pvr-wip-5.0.y
>>>=20
>>> Should I add this as maemo-leste-n900-5.0 branch (or something) to
>>> https://github.com/openpvrsgx-devgroup/linux_openpvrsgx ?
>>=20
>> Yes, that would be nice to be able to easily compare stuff.
>=20
> I've just pushed the Maemo Leste v5.1 branch + patches here:
>=20
> 	=
https://github.com/openpvrsgx-devgroup/linux_openpvrsgx/tree/n900/v5.1-pat=
ch
>=20
> This works on N900 with X, but it doesn't use DRM yet. I'm wondering
> what a next logical step would be: to try and modules to load/probe on
> another device (I have a droid4 or a Pandaboard ES rev B1), or to try
> and get DRM PowerVR to work on the N900, with omapdrmfb and dri3wsegl.
>=20
> For either path, I'll probably need some help. Any updates from anyone
> else? Maybe we should list things people can work - perhaps document
> progress in github issues. (Mailing list is also fine, BTW)
>=20
> Cheers,
> Merlijn
>=20

I also have pushed good news to

	=
https://github.com/openpvrsgx-devgroup/linux_openpvrsgx/tree/letux-pvr

Thanks to the help from the Pyra community, I was able to get a (binary) =
reference
implementation using DRM that works on Pyra/OMAP5. At least the =
gles1test1.

With that reference setup I was able to fix my Makefiles for the =
staging/pvr implementation.

I have tested that it works with v4.19.66 and v5.3-rc4 (LPAE build of =
the LetuxOS kernel tree)
on the Pyra.

In which areas does this tree go beyond the TI SDK/IMG DDK 1.14?

* includes internal API fixes for kernels up to v5.3
* lives in drivers/staging/pvr/1.14.3699939 - so that we can ask for =
inclusion in linux-next
* has Kconfig and Makefiles for in-kernel configuration (no separate =
build system)
* builds separate kernel modules for omap3430, omap3630, am335x, omap4, =
omap5, dra7 etc.
  pvrsrvkm
  e.g. pvrsrvkm_omap_omap5_sgx544_116
* the correct kernel module is automatically probed by matching =
.compatible in device tree
  so that the code is multi-platform friendly
* includes SoC integration for OMAP3/4/5 and has some preliminary =
bindings documentation
* code base should also support JZ4780/CI20 and some Intel Atom =
processors (CedarView, Poulsbo)
* has got a ToDo to describe what should be done during staging phase

	=
https://github.com/openpvrsgx-devgroup/linux_openpvrsgx/blob/letux/latest-=
pvr/drivers/staging/pvr/TODO

My plans for the next steps are:

* do more testing (e.g. X11, kmscube)
* check if and/or how it can run on am335x (BeagleBone) or OMAP3 (e.g. =
GTA04, OpenPandora)
* try a JZ480/CI20 build (unfortuantely I have no HDMI there with =
mainline kernels and I am
  missing the user-space libraries for MIPS).

BR,
Nikolaus
