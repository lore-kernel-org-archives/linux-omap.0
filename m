From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: Lay common foundation to make PVR/SGX work without hacks on OMAP34xx, OMAP36xx, AM335x and potentially OMAP4, OMAP5
Date: Mon, 7 Oct 2019 21:24:08 +0200
Message-ID: <9253CFB5-0AF7-4EA0-AC7F-6DE37318238A@goldelico.com>
References: <d0cbfaaf-813e-8803-f90b-931a38396750@wizzup.org> <3A03FF16-C203-43ED-AEEF-0260F6B3331A@goldelico.com> <3b0a5e78-c4c2-1963-bac7-b49496a1e9b9@wizzup.org> <1F942AAB-1648-46C0-ADD5-90F6898778BE@goldelico.com> <84cac9b8-0eff-33f8-464d-4f8045d7db19@wizzup.org> <BFAA7FA6-A352-476A-99F9-02EA663A6AAD@goldelico.com> <CAHCN7x+87xTsA3MeHy7kUWU0SU3X8HmSc2wbk5gKvYm1dRNe6A@mail.gmail.com> <04809E3E-A690-4931-B949-1CFDAF407C14@goldelico.com> <ebb50954-b456-4dab-0765-9dfa06c67075@wizzup.org> <C3A56737-6187-4B31-8697-3A02DD164429@goldelico.com> <20191007155252.GQ5610@atomide.com> <64474fb1-f6d2-52d0-175a-65bb493dc1fe@ti.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <64474fb1-f6d2-52d0-175a-65bb493dc1fe@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Merlijn Wajer <merlijn@wizzup.org>, Adam Ford <aford173@gmail.com>, Philipp Rossak <embed3d@gmail.com>, =?utf-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, =?utf-8?Q?Filip_Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, moaz korena <moaz@korena.xyz>, James Hilliard <james.hilliard1@gmail.com>, kernel@pyra-handheld.com, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, maemo-leste@lists.dyne.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Tero,

> Am 07.10.2019 um 21:18 schrieb Tero Kristo <t-kristo@ti.com>:
>=20
> On 07/10/2019 18:52, Tony Lindgren wrote:
>> Hi,
>> * H. Nikolaus Schaller <hns@goldelico.com> [191005 16:59]:
>> Please try with Tero's current github branch at =
github.com/t-kristo/linux-pm.git
>> 5.4-rc1-ipc from few days ago, the earlier versions had still issues.
>=20
> Yeah, this one should be fixed now.

Ok! Will try asap.

>=20
>>> * OMAP5 (Pyra): fails to enable the clocks (did work with the =
previous version)
>>> [  304.140363] clock-controller:clk:0000:0: failed to enable
>>> [  304.147388] PVR_K:(Error): EnableSGXClocks: pm_runtime_get_sync =
failed (16)
>> Hmm no idea what might be up with this one. Did some clkctrl clock
>> fixes maybe cause a regression here? Tero do you have any ideas?
>=20
> So, this one I am not too sure, I haven't looked at omap5 graphics =
clocking. I don't think it has anything to do with reset handling =
though.
>=20
> Is there some simple way to try this out on board; without PVR module =
that is?

Yes, I have also seen it when just running the commands in the original =
commit message [1]:

# echo on > $(find /sys -name control | grep \/5600)
# rwmem 0x5600fe00	# OCP Revision
0x5600fe00 =3D 0x40000000
# echo auto > $(find /sys -name control | grep \/5600)
# rwmem 0x5600fe10
# rwmem 0x56000024

But I have not yet tested with 5.4-rc2, just 5.4-rc1.

BR and thanks,
Nikolaus

[1]: =
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/=
?h=3Dv5.4-rc2&id=3D394534cb07d8f89b6e621e8a1e6da23571725aef=
