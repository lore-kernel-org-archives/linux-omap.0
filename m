From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: Lay common foundation to make PVR/SGX work without hacks on OMAP34xx, OMAP36xx, AM335x and potentially OMAP4, OMAP5
Date: Tue, 20 Aug 2019 08:48:51 +0200
Message-ID: <04809E3E-A690-4931-B949-1CFDAF407C14@goldelico.com>
References: <20180108214032.GW3872@atomide.com> <4d99c1ae-7752-949b-7e88-bc8f1dc594a2@wizzup.org> <0C51EC59-9CDC-4196-ACF9-24596C9E61B6@goldelico.com> <FA4520D5-62CB-446D-975C-A1C7B9251517@goldelico.com> <20190212205132.GO5720@atomide.com> <0b00ce0a-969f-e638-8247-c2da96cf7ce6@gmail.com> <20190213004143.GP5720@atomide.com> <480AB632-A544-41E7-95A4-DC354AEBB71A@goldelico.com> <CAKpie0SigGGsQxSU+X-Mz5boy-Xx=3wRNOcrf+F=ehFr3RBi7Q@mail.gmail.com> <092210C3-05DE-4AFB-986F-81BD8F990B67@goldelico.com> <CAKpie0RXM1UC33YFeFy-kAxfGhYGNkw4vUgNTThf-ZCAhPTVXw@mail.gmail.com> <BE23C1E4-2877-49FA-B230-F9C10691B805@goldelico.com> <CAKpie0TSo-8gmDm9_Zw4Sd+kjVVEomp8yA9Vu8qY2U2AcrQc=w@mail.gmail.com> <8A069D96-C65F-43F5-8F54-20019CFB1A8D@goldelico.com> <d0cbfaaf-813e-8803-f90b-931a38396750@wizzup.org> <3A03F
 F16-C203-43ED-AEEF-0260F6B3331A@goldelico.com> <3b0a5e78-c4c2-1963-bac7-b49496a1e9b9@wizzup.org> <1F942AAB-1648-46C0-ADD5-90F6898778BE@goldelico.com> <84cac9b8-0eff-33f8-464d-4f8045d7db19@wizzup.org> <BFAA7FA6-A352-476A-99F9-02EA663A6AAD@goldelico.com> <CAHCN7x+87xTsA3MeHy7kUWU0SU3X8HmSc2wbk5gKvYm1dRNe6A@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHCN7x+87xTsA3MeHy7kUWU0SU3X8HmSc2wbk5gKvYm1dRNe6A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Ford <aford173@gmail.com>
Cc: Merlijn Wajer <merlijn@wizzup.org>, Tony Lindgren <tony@atomide.com>, =?utf-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>, Philipp Rossak <embed3d@gmail.com>, moaz korena <moaz@korena.xyz>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, =?utf-8?Q?Filip_Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap <linux-omap@vger.kernel.org>, kernel@pyra-handheld.com, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, maemo-leste@lists.dyne.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org


> Am 19.08.2019 um 21:43 schrieb Adam Ford <aford173@gmail.com>:
>=20
>> Thanks to the help from the Pyra community, I was able to get a =
(binary) reference
>> implementation using DRM that works on Pyra/OMAP5. At least the =
gles1test1.
>=20
> just a question,
>=20
> If DRM is working, does that mean it works without needing the =
overhead of X?

Yes, we have to kill X11 to successfully run the gles1test1. An =
interesting question
will be how to mix both... E.g. have a 3D rendering in a window =
controlled by some
window manager.=
