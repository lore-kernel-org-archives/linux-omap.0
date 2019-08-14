From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: Lay common foundation to make PVR/SGX work without hacks on OMAP34xx, OMAP36xx, AM335x and potentially OMAP4, OMAP5
Date: Wed, 14 Aug 2019 12:33:36 +0200
Message-ID: <6A6394A6-9D50-4E43-A8E4-716888897AD6@goldelico.com>
References: <CAKpie0RXM1UC33YFeFy-kAxfGhYGNkw4vUgNTThf-ZCAhPTVXw@mail.gmail.com> <BE23C1E4-2877-49FA-B230-F9C10691B805@goldelico.com> <CAKpie0TSo-8gmDm9_Zw4Sd+kjVVEomp8yA9Vu8qY2U2AcrQc=w@mail.gmail.com> <8A069D96-C65F-43F5-8F54-20019CFB1A8D@goldelico.com> <d0cbfaaf-813e-8803-f90b-931a38396750@wizzup.org> <3A03FF16-C203-43ED-AEEF-0260F6B3331A@goldelico.com> <3b0a5e78-c4c2-1963-bac7-b49496a1e9b9@wizzup.org> <1F942AAB-1648-46C0-ADD5-90F6898778BE@goldelico.com> <84cac9b8-0eff-33f8-464d-4f8045d7db19@wizzup.org> <BFAA7FA6-A352-476A-99F9-02EA663A6AAD@goldelico.com> <20190814094755.GC52127@atomide.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190814094755.GC52127@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Merlijn Wajer <merlijn@wizzup.org>, =?utf-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>, Philipp Rossak <embed3d@gmail.com>, moaz korena <moaz@korena.xyz>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, =?utf-8?Q?Filip_Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>, Adam Ford <aford173@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap <linux-omap@vger.kernel.org>, kernel@pyra-handheld.com, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, maemo-leste@lists.dyne.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org


> Am 14.08.2019 um 11:47 schrieb Tony Lindgren <tony@atomide.com>:
>=20
> * H. Nikolaus Schaller <hns@goldelico.com> [190814 08:57]:
>> I also have pushed good news to
>>=20
>> 	=
https://github.com/openpvrsgx-devgroup/linux_openpvrsgx/tree/letux-pvr
>>=20
>> Thanks to the help from the Pyra community, I was able to get a =
(binary) reference
>> implementation using DRM that works on Pyra/OMAP5. At least the =
gles1test1.
>>=20
>> With that reference setup I was able to fix my Makefiles for the =
staging/pvr implementation.
>>=20
>> I have tested that it works with v4.19.66 and v5.3-rc4 (LPAE build of =
the LetuxOS kernel tree)
>> on the Pyra.
>>=20
>> In which areas does this tree go beyond the TI SDK/IMG DDK 1.14?
>>=20
>> * includes internal API fixes for kernels up to v5.3
>> * lives in drivers/staging/pvr/1.14.3699939 - so that we can ask for =
inclusion in linux-next
>> * has Kconfig and Makefiles for in-kernel configuration (no separate =
build system)
>> * builds separate kernel modules for omap3430, omap3630, am335x, =
omap4, omap5, dra7 etc.
>>  pvrsrvkm
>>  e.g. pvrsrvkm_omap_omap5_sgx544_116
>> * the correct kernel module is automatically probed by matching =
.compatible in device tree
>>  so that the code is multi-platform friendly
>> * includes SoC integration for OMAP3/4/5 and has some preliminary =
bindings documentation
>> * code base should also support JZ4780/CI20 and some Intel Atom =
processors (CedarView, Poulsbo)
>> * has got a ToDo to describe what should be done during staging phase
>>=20
>> 	=
https://github.com/openpvrsgx-devgroup/linux_openpvrsgx/blob/letux/latest-=
pvr/drivers/staging/pvr/TODO
>>=20
>> My plans for the next steps are:
>>=20
>> * do more testing (e.g. X11, kmscube)
>> * check if and/or how it can run on am335x (BeagleBone) or OMAP3 =
(e.g. GTA04, OpenPandora)
>> * try a JZ480/CI20 build (unfortuantely I have no HDMI there with =
mainline kernels and I am
>>  missing the user-space libraries for MIPS).
>=20
> That sounds good to me, just one comment. Before getting these into
> staging, I'd like to have omap variants use proper interconnect
> target module in devicetree like we already have in omap4.dtsi
> as target-module@56000000. This should simplify things further
> as the module child device driver(s) can just enable things with
> runtime PM and we can leave out all the legacy hwmod platform data
> that sounds like you're still carrying.

Yes, there is still a lot of SoC-glue included:

	=
https://github.com/openpvrsgx-devgroup/linux_openpvrsgx/commits/letux/omap=
-pvr-soc-glue

It would indeed be a good move to simplify and reduce the glue code
and make it more maintainable / stable / identical on different =
platforms.

>=20
> I have patches here to add similar interconnect target modules for
> at least omap34xx, omap36xx, omap5, and am335x that I'll try to post
> later on today to play with. For am335x, things still depend on the
> recentely posted prm rstctrl patches. I'm not sure if I already
> did a dts patch for dra7 yet, need to check.

I assume it is not yet in linux-next... So something for v5.5 or later.

BR and thanks,
Nikolaus=
