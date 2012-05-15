From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] ARM: OMAP4: PM: Keep static dep between MPUSS and ABE clockdomain
Date: Tue, 15 May 2012 20:30:44 +0530
Message-ID: <CAMQu2gy72cbR4+xr6pYQBamNSjLdxUu4s_MkDf=pwrPnB56enA@mail.gmail.com>
References: <1337082156-30390-1-git-send-email-tarun.kanti@ti.com> <4FB268F9.9040508@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4FB268F9.9040508@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>
List-Id: linux-omap@vger.kernel.org

On Tue, May 15, 2012 at 8:02 PM, Cousson, Benoit <b-cousson@ti.com> wro=
te:
> + Paul
>
> Hi Tarun,
>
> On 5/15/2012 1:42 PM, Tarun Kanti DebBarma wrote:
>> Commit 68523f4233de5f233478dde0a63047b4efb710b8 (ARM: OMAP4:
>> Workaround the OCP synchronisation issue with 32K synctimer)
>> does not include GP Timers in ABE domain. Since synchronization
>> issue is applicable to all GPTIMER[1-12], we also need to set
>> static dependency of MPUSS with abe_clkdm and l4_per_clkdm.
>> Dependency with l4_per_clkdm timers is already set in commit
>> 12f27826bdaf56b01cbdfc8bdeb577ebc106dee3 (ARM: OMAP4: PM: Keep
>> static dep between MPUSS-EMIF and MPUSS-L3/L4 and DUCATI-L3).
>> Therefore, set static dependency of MPUSS with abe_clkdm.
>
> It seems to me that these various static dep workaround patches are m=
ore and more confusing and should require some further investigation / =
explanation.
>
This is a new BUG which has not made it to errata list yet. It will
make it eventually.

> If we keep doing that we will end up having every clock domains alway=
s ON each time the CPU is active. This is a very brute force approach n=
ot really acceptable for mainline and for PM point of view.
>
Indeed.

> Here we are forcing the ABE domain to be ON each time the MPU is ON e=
ven if we do not have any timer used inside the domain.
>
Actually the BUG is really related to timers running on 32KHz and only
in that case such a WA is needed. BTW, the WA is suggested by hardware
team.

> It was mostly OK to do that for the wakeup domain due to the small po=
wer impact, but doing that on the L4_PER and ABE seems a little bit too=
 much.
>
L4PER and ABE should not be set default....

> The fix assumes as well that the MPU is the only user of that timer. =
What if either DSP or IPU uses it as well?
>

> Moreover the previous 68523f4233de5f2 commit did add tons of deps tha=
t does not seems to be really justified by any HW errata AFAIK.
> That does not mean they are not needed, but I think we should either =
remove them or add some more explanation.
>
EMIF and L3 are covered as part of the errata's. Most if these static
deps issues never worked properly and people ended up hacking
like disable L3 when display ON etc etc.

> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* The dynamic dependency between MPUSS -> MEMIF and
> + =A0 =A0 =A0 =A0* MPUSS -> L4_PER/L3_* and DUCATI -> L3_* doesn't wo=
rk as
> + =A0 =A0 =A0 =A0* expected. The hardware recommendation is to enable=
 static
> + =A0 =A0 =A0 =A0* dependencies for these to avoid system lock ups or=
 random crashes.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 mpuss_clkdm =3D clkdm_lookup("mpuss_clkdm");
> + =A0 =A0 =A0 emif_clkdm =3D clkdm_lookup("l3_emif_clkdm");
> + =A0 =A0 =A0 l3_1_clkdm =3D clkdm_lookup("l3_1_clkdm");
> + =A0 =A0 =A0 l3_2_clkdm =3D clkdm_lookup("l3_2_clkdm");
> + =A0 =A0 =A0 l4_per_clkdm =3D clkdm_lookup("l4_per_clkdm");
> + =A0 =A0 =A0 ducati_clkdm =3D clkdm_lookup("ducati_clkdm");
> + =A0 =A0 =A0 if ((!mpuss_clkdm) || (!emif_clkdm) || (!l3_1_clkdm) ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (!l3_2_clkdm) || (!ducati_clkdm) || (!l=
4_per_clkdm))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err2;
> +
> + =A0 =A0 =A0 ret =3D clkdm_add_wkdep(mpuss_clkdm, emif_clkdm);
>
> AFAIK, this one is the only one covered by an errata. It might be goo=
d to add a comment to explained the issue.
>
> + =A0 =A0 =A0 ret |=3D clkdm_add_wkdep(mpuss_clkdm, l3_1_clkdm);
> + =A0 =A0 =A0 ret |=3D clkdm_add_wkdep(mpuss_clkdm, l3_2_clkdm);
> + =A0 =A0 =A0 ret |=3D clkdm_add_wkdep(mpuss_clkdm, l4_per_clkdm);
> + =A0 =A0 =A0 ret |=3D clkdm_add_wkdep(ducati_clkdm, l3_1_clkdm);
> + =A0 =A0 =A0 ret |=3D clkdm_add_wkdep(ducati_clkdm, l3_2_clkdm);
>
> Do we have errata for any of these ones?
>
If we forget about the latest timer issues doing the round only EMIF an=
d L3
deps with different initiators were needed. L4PER was because of UART
idle mode issue which I fixed recently. At least with that fix, L4PER s=
hould
be killed. Will be good to take the latest findings on the static deps =
issues
and update above list.

These timer OCP sync issue has really created a big mess again...
Timer is 3 domains. AON, ABE and L4pER and the WA suggested is
static dep as if it is free. There is no other WA.

Regards
Santosh
