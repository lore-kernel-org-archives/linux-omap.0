From: Adam Ford <aford173@gmail.com>
Subject: Re: Lay common foundation to make PVR/SGX work without hacks on
 OMAP34xx, OMAP36xx, AM335x and potentially OMAP4, OMAP5
Date: Mon, 19 Aug 2019 14:25:34 -0500
Message-ID: <CAHCN7xJH6ZjksNZ2cyb1rN_TiF-0GKAtW9KD1kv1-JE+gqLgEA@mail.gmail.com>
References: <d0cbfaaf-813e-8803-f90b-931a38396750@wizzup.org>
 <3A03FF16-C203-43ED-AEEF-0260F6B3331A@goldelico.com> <3b0a5e78-c4c2-1963-bac7-b49496a1e9b9@wizzup.org>
 <1F942AAB-1648-46C0-ADD5-90F6898778BE@goldelico.com> <84cac9b8-0eff-33f8-464d-4f8045d7db19@wizzup.org>
 <BFAA7FA6-A352-476A-99F9-02EA663A6AAD@goldelico.com> <20190814094755.GC52127@atomide.com>
 <6A6394A6-9D50-4E43-A8E4-716888897AD6@goldelico.com> <20190814131607.GD52127@atomide.com>
 <CAHCN7xJ2kcr7dOFvxTB_PX_62sX_QV5EyeMPHMaPbZ9fXts9pg@mail.gmail.com> <20190817070307.GJ52127@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190817070307.GJ52127@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "H. Nikolaus Schaller" <hns@goldelico.com>, Merlijn Wajer <merlijn@wizzup.org>, =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>, Philipp Rossak <embed3d@gmail.com>, moaz korena <moaz@korena.xyz>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, =?UTF-8?Q?Filip_Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap <linux-omap@vger.kernel.org>, kernel@pyra-handheld.com, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, maemo-leste@lists.dyne.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Sat, Aug 17, 2019 at 2:03 AM Tony Lindgren <tony@atomide.com> wrote:
>
> * Adam Ford <aford173@gmail.com> [190816 23:02]:
> > On Wed, Aug 14, 2019 at 8:16 AM Tony Lindgren <tony@atomide.com> wrote:
> > > Well I just posted some sgx interconnect target module patches. We might
> > > still have them in v5.4 assuming people manage to review and test them.
> >
> > Nikolaus,
> >
> > I tested Tony's change and I can confirm that I can read the value
> > when enabled.  Should I apply his patches to your branch before I
> > test, or is it go too to go as-is? I've got an AM3517, OMAP35 and a
> > DM3730.  I am not sure if the AM3517 is even on the radar, but it has
> > an sgx530 as well.
>
> My estimate is am3517 is wired the same way as omap34xx with a 60%
> chance, then 30% chance it's wired the same way as omap36xx, and then
> 10% chance for similar wiring to am335x.. So hopefully that leaves 0%
> chance for yet something different for it's wiring :)

Based on [1], I went under the assumption it was wired like the
omap34xx.  I applied your omap34 patches to the am3517.dtsi, and I was
able to get the same response as I did for the omap3530.  Do you want
me to post the patches to the mailing list, or do you want to do it?

adam

[1] - http://processors.wiki.ti.com/index.php/GSG:_AM35x_and_OMAP35x_Rebuilding_the_Software#How_to_check_for_SGX_core_revision

>
> If you have a chance please give it a try. Also check the TRM for the
> sgx sysconfig register bits to see which of the above matches, and if
> 3517 has a related rstctrl register like am335x has.
>
> Regards,
>
> Tony
