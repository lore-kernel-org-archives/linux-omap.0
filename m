From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/3] clk: ti: Implement FAPLL set_rate for the synthesizer
Date: Mon, 23 Mar 2015 08:52:42 -0700
Message-ID: <20150323155242.GX31346@atomide.com>
References: <1427063726-4248-1-git-send-email-tony@atomide.com>
 <1427063726-4248-3-git-send-email-tony@atomide.com>
 <5510143A.8090404@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5510143A.8090404@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Brian Hutchinson <b.hutchman@gmail.com>, Matthijs van Duin <matthijsvanduin@gmail.com>
List-Id: linux-omap@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [150323 06:25]:
> On 03/23/2015 12:35 AM, Tony Lindgren wrote:
> >+static u32 ti_fapll_synth_set_frac_rate(struct fapll_synth *synth,
> >+					unsigned long rate,
> >+					unsigned long parent_rate)
> >+{
> >+	u32 post_div_m, synth_int_div, synth_frac_div, v;
> >+
> >+	post_div_m =3D DIV_ROUND_UP_ULL((u64)parent_rate * SYNTH_PHASE_K, =
rate);
> >+	post_div_m =3D post_div_m / SYNTH_MAX_INT_DIV;
> >+	if (post_div_m > SYNTH_MAX_DIV_M)
> >+		return -EINVAL;
> >+	if (!post_div_m)
> >+		post_div_m =3D 1;
> >+
> >+	for (; post_div_m < SYNTH_MAX_DIV_M; post_div_m++) {
> >+		synth_int_div =3D DIV_ROUND_UP_ULL((u64)parent_rate *
> >+						 SYNTH_PHASE_K *
> >+						 10000000,
> >+						 rate * post_div_m);
> >+		synth_frac_div =3D synth_int_div % 10000000;
> >+		synth_int_div /=3D 10000000;
> >+
> >+		if (synth_int_div <=3D SYNTH_MAX_INT_DIV)
> >+			break;
> >+	}
> >+
> >+	if (synth_int_div > SYNTH_MAX_INT_DIV)
> >+		return -EINVAL;
> >+
> >+	v =3D readl_relaxed(synth->freq);
> >+	v &=3D ~0x1fffffff;
> >+	v |=3D (synth_int_div & SYNTH_MAX_INT_DIV) << 24;
> >+	v |=3D (synth_frac_div & 0xffffff);
>=20
> This code is generating these compile time warnings for me:
>=20
>   CC      drivers/clk/ti/fapll.o
> drivers/clk/ti/fapll.c: In function =E2=80=98ti_fapll_synth_set_rate=E2=
=80=99:
> drivers/clk/ti/fapll.c:394:5: warning: =E2=80=98synth_int_div=E2=80=99=
 may be used
> uninitialized in this function [-Wuninitialized]
> drivers/clk/ti/fapll.c:373:18: note: =E2=80=98synth_int_div=E2=80=99 =
was declared here
> drivers/clk/ti/fapll.c:400:23: warning: =E2=80=98synth_frac_div=E2=80=
=99 may be used
> uninitialized in this function [-Wuninitialized]
> drivers/clk/ti/fapll.c:373:33: note: =E2=80=98synth_frac_div=E2=80=99=
 was declared here

Oops thanks will check. I did move this into a separate function
to make it more readable, probably happened at that point.

Regards,

Tony
