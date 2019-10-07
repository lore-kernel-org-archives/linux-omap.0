From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: Lay common foundation to make PVR/SGX work without hacks on OMAP34xx, OMAP36xx, AM335x and potentially OMAP4, OMAP5
Date: Mon, 7 Oct 2019 17:56:38 +0200
Message-ID: <D1CD5D93-4178-4359-AF00-FFC3AA9CA054@goldelico.com>
References: <d0cbfaaf-813e-8803-f90b-931a38396750@wizzup.org> <3A03FF16-C203-43ED-AEEF-0260F6B3331A@goldelico.com> <3b0a5e78-c4c2-1963-bac7-b49496a1e9b9@wizzup.org> <1F942AAB-1648-46C0-ADD5-90F6898778BE@goldelico.com> <84cac9b8-0eff-33f8-464d-4f8045d7db19@wizzup.org> <BFAA7FA6-A352-476A-99F9-02EA663A6AAD@goldelico.com> <CAHCN7x+87xTsA3MeHy7kUWU0SU3X8HmSc2wbk5gKvYm1dRNe6A@mail.gmail.com> <04809E3E-A690-4931-B949-1CFDAF407C14@goldelico.com> <ebb50954-b456-4dab-0765-9dfa06c67075@wizzup.org> <C3A56737-6187-4B31-8697-3A02DD164429@goldelico.com> <20191007155252.GQ5610@atomide.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191007155252.GQ5610@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Merlijn Wajer <merlijn@wizzup.org>, Adam Ford <aford173@gmail.com>, Philipp Rossak <embed3d@gmail.com>, =?utf-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, =?utf-8?Q?Filip_Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, moaz korena <moaz@korena.xyz>, James Hilliard <james.hilliard1@gmail.com>, kernel@pyra-handheld.com, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, maemo-leste@lists.dyne.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org


> Am 07.10.2019 um 17:52 schrieb Tony Lindgren <tony@atomide.com>:
>=20
> Hi,
>=20
> * H. Nikolaus Schaller <hns@goldelico.com> [191005 16:59]:
>>=20
>>=20
>> * AM335x (BeagleBoneBlack): reports a problem with =
omap_reset_deassert:
>> [  204.246706] omap_reset_deassert: timedout waiting for gfx:0
>=20
> Please try with Tero's current github branch at =
github.com/t-kristo/linux-pm.git
> 5.4-rc1-ipc from few days ago, the earlier versions had still issues.

I have seen there has been a new version today and I'll try that one =
asap.

>=20
>> * OMAP5 (Pyra): fails to enable the clocks (did work with the =
previous version)
>> [  304.140363] clock-controller:clk:0000:0: failed to enable
>> [  304.147388] PVR_K:(Error): EnableSGXClocks: pm_runtime_get_sync =
failed (16)
>=20
> Hmm no idea what might be up with this one. Did some clkctrl clock
> fixes maybe cause a regression here? Tero do you have any ideas?

BR and thanks,
Nikolaus
