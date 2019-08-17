From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: Lay common foundation to make PVR/SGX work without hacks on OMAP34xx, OMAP36xx, AM335x and potentially OMAP4, OMAP5
Date: Sat, 17 Aug 2019 11:01:45 +0200
Message-ID: <2ACE0AFF-D929-47AB-BAA9-973DA5DB3A1C@goldelico.com>
References: <CAKpie0TSo-8gmDm9_Zw4Sd+kjVVEomp8yA9Vu8qY2U2AcrQc=w@mail.gmail.com> <8A069D96-C65F-43F5-8F54-20019CFB1A8D@goldelico.com> <d0cbfaaf-813e-8803-f90b-931a38396750@wizzup.org> <3A03FF16-C203-43ED-AEEF-0260F6B3331A@goldelico.com> <3b0a5e78-c4c2-1963-bac7-b49496a1e9b9@wizzup.org> <1F942AAB-1648-46C0-ADD5-90F6898778BE@goldelico.com> <84cac9b8-0eff-33f8-464d-4f8045d7db19@wizzup.org> <BFAA7FA6-A352-476A-99F9-02EA663A6AAD@goldelico.com> <20190814094755.GC52127@atomide.com> <6A6394A6-9D50-4E43-A8E4-716888897AD6@goldelico.com> <20190814131607.GD52127@atomide.com> <CAHCN7xJ2kcr7dOFvxTB_PX_62sX_QV5EyeMPHMaPbZ9fXts9pg@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHCN7xJ2kcr7dOFvxTB_PX_62sX_QV5EyeMPHMaPbZ9fXts9pg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Ford <aford173@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Merlijn Wajer <merlijn@wizzup.org>, =?utf-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>, Philipp Rossak <embed3d@gmail.com>, moaz korena <moaz@korena.xyz>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, =?utf-8?Q?Filip_Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap <linux-omap@vger.kernel.org>, kernel@pyra-handheld.com, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, maemo-leste@lists.dyne.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Adam,

> Am 17.08.2019 um 01:01 schrieb Adam Ford <aford173@gmail.com>:
>=20
>=20
> Nikolaus,
>=20
> I tested Tony's change and I can confirm that I can read the value
> when enabled.  Should I apply his patches to your branch before I
> test, or is it go too to go as-is?

My branch is currently as-is and not aware of Tony's patches and based =
on v5.3-rc3.
I think I will have to remove some glue code which tries to do the =
platform
reset and enables clocks and replace by pm_runtime_get_sync() before it =
fits
together. Then we can likely remove the omap-pvr-soc-glue branch at =
least
partially and/or replace by Tony's patches before they arrive in =
mainline.

The current status of my branch is that it works on OMAP5/Pyra but a
quick test on BeagleBone or GTA04 did show some reset/clock errors and
it did not more than creating /proc/pvr. pvrsrvctl --start did fail.

Which means that the omap-pvr-soc-glue patches are currently broken
with 5.3-rc3 anyways...

I'll look at it as soon as possible.

> I've got an AM3517, OMAP35 and a
> DM3730.  I am not sure if the AM3517 is even on the radar, but it has
> an sgx530 as well.

Good to know and keep in mind.

BR,
Nikolaus
