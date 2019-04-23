From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH 3/3] ARM: omap2: move platform-specific asm-offset.h to arch/arm/mach-omap2
Date: Tue, 23 Apr 2019 13:40:03 +0900
Message-ID: <CAK7LNAR-woScv67owJt5KDNPWH53eh6rzoBJY6e9ktFVoim00A@mail.gmail.com>
References: <20190408075427.6052-1-yamada.masahiro@socionext.com>
 <20190408075427.6052-3-yamada.masahiro@socionext.com> <20190408161802.GI49658@atomide.com>
 <6308904e-443a-46ff-9633-2ccb3b03bef9@ti.com> <CAK7LNASYqkhW_W6K5Y9NvmqnZ2aSCbGZNw0ZFrBB3Dd2FRN8yg@mail.gmail.com>
 <39d9cc92-ef2f-993c-3abd-99b134e1c22e@ti.com> <CAK7LNARKW94j=sOdUd24mNMOcunu9TYXjPMeo_y_kHv7xqnE2Q@mail.gmail.com>
 <20190409141759.GA2839@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190409141759.GA2839@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Keerthy <j-keerthy@ti.com>, arm-soc <arm@kernel.org>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux-OMAP <linux-omap@vger.kernel.org>, Russell King <linux@armlinux.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Apr 9, 2019 at 11:20 PM Tony Lindgren <tony@atomide.com> wrote:
>
> * Masahiro Yamada <yamada.masahiro@socionext.com> [190409 07:06]:
> > On Tue, Apr 9, 2019 at 2:17 PM Keerthy <j-keerthy@ti.com> wrote:
> > >
> > >
> > >
> > > On 09/04/19 10:37 AM, Masahiro Yamada wrote:
> > > > On Tue, Apr 9, 2019 at 2:00 PM Keerthy <j-keerthy@ti.com> wrote:
> > > >>
> > > >>
> > > >>
> > > >> On 08/04/19 9:48 PM, Tony Lindgren wrote:
> > > >>> Hi,
> > > >>>
> > > >>> * Masahiro Yamada <yamada.masahiro@socionext.com> [190408 07:56]:
> > > >>>> <generated/ti-pm-asm-offsets.h> is only generated and included
> > > >>>> by arch/arm/mach-omap2/, so it does not need to reside in the
> > > >>>> globally visible include/generated/.
> > > >>>>
> > > >>>> I moved and renamed it to arch/arm/mach-omap2/pm-asm-offsets.h
> > > >>>> since the prefix 'omap2-' is just redundant in mach-omap2/.
> > > >>>>
> > > >>>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > > >>>> ---
> > > >>>>
> > > >>>> Can this be applied to ARM-SOC tree in a series?
> > > >>>> (with Ack from the platform sub-maintainer.)
> > > >>>>
> > > >>>> ti-pm-asm-offsets.h does not need to reside in include/generated/,
> > > >>>> but you may ask "Why must it get out of include/generated/?"
> > > >>>>
> > > >>>> My main motivation is to avoid a race condition in the currently
> > > >>>> proposed patch:
> > > >>>>
> > > >>>> https://lore.kernel.org/patchwork/patch/1052763/
> > > >>>>
> > > >>>> This patch tries to embed some build artifacts into the kernel.
> > > >>>>
> > > >>>> If arch/arm/mach-omap2/ and kernel/ are built at the same time,
> > > >>>> it may embed a truncated file.
> > > >>>
> > > >>> Looks like a nice improvment to me, adding Keerthy and Dave to Cc.
> > > >>>
> > > >>> Keerthy and Dave, can you please test this series with am3 and am4
> > > >>> PM code?
> > > >>
> > > >> Tested for Deep Sleep0 on AM33xx Beaglebone-black.
> > > >> Tested for Deep Sleep0 on AM437x-gp-evm.
> > > >>
> > > >> Applied this on top of Tony's for-next with the gpio patch
> > > >> required for RTC+DDR mode on am437x-gp-evm.
> > > >
> > > > Was it applied to TI tree?
> > > >
> > > > If so ...
> > > >
> > > > Arnd, Olof,
> > > > Please just ignore this patch
> > > > since it looks it was already applied to TI tree.
> > >
> > > Masahiro Yamada,
> > >
> > > No i manually applied this on top.
> > >
> > > Regards,
> > > Keerthy
> >
> > Keerthy,
> > Sorry, I misunderstood.
> >
> > You just applied it to your local tree for testing.
> >
> > Then, I still think it is better to
> > apply this series in a correct order.
> >
> > The reason I sent this in a series was
> > to make sure asm-offset headers are correctly
> > cleaned up.
>
> Yes looks good to me:
>
> Acked-by: Tony Lindgren <tony@atomide.com>

Sorry, this turned out to break the out-of-tree build.

Please do not apply this for now.

I will come back to this later when ready.


-- 
Best Regards
Masahiro Yamada
