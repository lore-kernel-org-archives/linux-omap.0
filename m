From: Adam Ford <aford173@gmail.com>
Subject: Re: [RFC] ARM: omap3: Enable HWMODS for HW Random Number Generator
Date: Tue, 10 Sep 2019 10:48:29 -0500
Message-ID: <CAHCN7x+t-OVRE7pVM4V87_YMWpgO+_Vashfn1s5msoqC5eiwTg@mail.gmail.com>
References: <20190828150037.2640-1-aford173@gmail.com> <20190905230443.GA52127@atomide.com>
 <CAHCN7xL0fbr=Sv+b=0AuGB1PPhAAFdAFLEd_iBM+ZMTkUw5sHQ@mail.gmail.com>
 <CAHCN7xL-Gfxe0qF5w7BUsHnyhcNNpmCnchdKErnmiqggXfsLWw@mail.gmail.com>
 <20190909134033.s26eiurpat3iekse@pali> <20190909163543.GQ52127@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190909163543.GQ52127@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Tero Kristo <t-kristo@ti.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Adam Ford <adam.ford@logicpd.com>, =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Paul Walmsley <paul@pwsan.com>, devicetree <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, arm-soc <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Sep 9, 2019 at 11:35 AM Tony Lindgren <tony@atomide.com> wrote:
>
> * Pali Roh=C3=A1r <pali.rohar@gmail.com> [190909 13:41]:
> > On Monday 09 September 2019 08:37:09 Adam Ford wrote:
> > > I applied this on 5.3 and it is working.  I assume the same is true i=
n for-next.
>
> Hmm I noticed I stopped getting RNG data after several rmmod modprobe
> cycles, or several hd /dev/random reads. Anybody else seeing that?
>
> > > Do you want to submit a formal patch?  I  can mark it as 'tested-by'
> > > This really helps speed up the startup sequence on boards with sshd
> > > because it delays for nearly 80 seconds waiting for entropy without
> > > the hwrng.
> >
> > Hi! When applying a patch, could you please disable this rng for n900?
> >
> > In omap3-n900.dts for rng should be status =3D "disabled" (as Tony alre=
ady
> > wrote), similarly like for aes.
>
> Yeah I'll post a proper patch after -rc1.

FYI,

By putting your node into omap34xx.dtsi and omap36xx.dtsi along with
the following, I can get the RNG to work on an OMAP3530 and a DM3730.


diff --git a/arch/arm/boot/dts/omap34xx-omap36xx-clocks.dtsi
b/arch/arm/boot/dts/omap34xx-omap36xx-clocks.dtsi
index 5e9d1afcd422..73f351e6d132 100644
--- a/arch/arm/boot/dts/omap34xx-omap36xx-clocks.dtsi
+++ b/arch/arm/boot/dts/omap34xx-omap36xx-clocks.dtsi
@@ -259,7 +259,7 @@
                         <&i2c1_ick>, <&uart2_ick>, <&uart1_ick>, <&gpt11_i=
ck>,
                         <&gpt10_ick>, <&mcbsp5_ick>, <&mcbsp1_ick>,
                         <&omapctrl_ick>, <&aes2_ick>, <&sha12_ick>, <&icr_=
ick>,
-                        <&des2_ick>, <&mspro_ick>, <&mailboxes_ick>,
+                        <&des2_ick>, <&mspro_ick>, <&mailboxes_ick>,
<&rng_ick>,
                         <&mspro_fck>;
        };
 };

I tried doing the same for am3517, but it doesn't appear to work.  In
fact, the board hangs at boot with no splat, so I assume that some
clock isn't running and causing a hang.  Figure 4-50 in the AM3517 TRM
shows the security_l4_iclk2, so I wonder if the HW mods for AES, SHA,
etc are doing something to enable this clock.  Those HWmods are
disabled on AM3517.  I tried turning on the hwmods for them before
without success, but I'll try it again.

adam
>
> Regards,
>
> Tony
