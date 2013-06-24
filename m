From: Ambresh K <ambresh@ti.com>
Subject: Re: [PATCH V2 3/3] ARM: OMAP2+: clk: Fix return type of callbacks
Date: Mon, 24 Jun 2013 10:21:58 +0530
Message-ID: <51C7D06E.30407@ti.com>
References: <1371458384-23936-1-git-send-email-ambresh@ti.com> <1371458384-23936-4-git-send-email-ambresh@ti.com> <20130621181333.20448.23218@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130621181333.20448.23218@quantum>
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Tero Kristo <t-kristo@ti.com>, Rajendra <rnayak@ti.com>, Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>
List-Id: linux-omap@vger.kernel.org



On Friday 21 June 2013 11:43 PM, Mike Turquette wrote:
> Quoting Ambresh K (2013-06-17 01:39:44)
>> From: Ambresh K <ambresh@ti.com>
>>
>> clk_ops's .get_parent member data return's signed value.
>>
>> Signed-off-by: Ambresh K <ambresh@ti.com>
>=20
> Unsurprisingly I get the following errors when building
> multi_v7_defconfig:
>=20
> drivers/clk/clk-composite.c: In function =E2=80=98clk_register_compos=
ite=E2=80=99:
> drivers/clk/clk-composite.c:148:33: warning: assignment from incompat=
ible pointer type [enabled by default]
> drivers/clk/clk-prima2.c:411:2: warning: initialization from incompat=
ible pointer type [enabled by default]
> drivers/clk/clk-prima2.c:411:2: warning: (near initialization for =E2=
=80=98msi_ops.get_parent=E2=80=99) [enabled by default]
> drivers/clk/clk-prima2.c:459:2: warning: initialization from incompat=
ible pointer type [enabled by default]
> drivers/clk/clk-prima2.c:459:2: warning: (near initialization for =E2=
=80=98cpu_ops.get_parent=E2=80=99) [enabled by default]
> drivers/clk/clk-prima2.c:485:2: warning: initialization from incompat=
ible pointer type [enabled by default]
> drivers/clk/clk-prima2.c:485:2: warning: (near initialization for =E2=
=80=98dmn_ops.get_parent=E2=80=99) [enabled by default]
> drivers/clk/clk-zynq.c:118:2: warning: initialization from incompatib=
le pointer type [enabled by default]
> drivers/clk/clk-zynq.c:118:2: warning: (near initialization for =E2=80=
=98zynq_periph_clk_ops.get_parent=E2=80=99) [enabled by default]
> drivers/clk/clk-zynq.c:228:2: warning: initialization from incompatib=
le pointer type [enabled by default]
> drivers/clk/clk-zynq.c:228:2: warning: (near initialization for =E2=80=
=98zynq_cpu_clk_ops.get_parent=E2=80=99) [enabled by default]
>=20
> All definitions of .get_parent callbacks need to be updated, not just
> your platform of choice. And there may well be more than the ones abo=
ve.
>=20
> I'm not taking this series for 3.11. After the merge window can you
> resubmit this series with fixes for all of the .get_parent definition=
s?
> Not just for OMAP.
>=20
> Otherwise the rest of the series looks good and I'll be happy to take
> this in towards 3.12.

Thanks Mike! Will fix for other platforms too and resend v3.

>=20
> Thanks,
> Mike
>=20
>> ---
>>  arch/arm/mach-omap2/clkt_clksel.c |    2 +-
>>  arch/arm/mach-omap2/clkt_dpll.c   |    2 +-
>>  arch/arm/mach-omap2/clock.h       |    4 ++--
>>  3 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/clkt_clksel.c b/arch/arm/mach-omap2=
/clkt_clksel.c
>> index 0ec9f6f..2773657 100644
>> --- a/arch/arm/mach-omap2/clkt_clksel.c
>> +++ b/arch/arm/mach-omap2/clkt_clksel.c
>> @@ -303,7 +303,7 @@ u32 omap2_clksel_round_rate_div(struct clk_hw_om=
ap *clk,
>>   * way to return an error, so if we encounter an error, just WARN()
>>   * and pretend that we know that we're doing.
>>   */
>> -u8 omap2_clksel_find_parent_index(struct clk_hw *hw)
>> +int omap2_clksel_find_parent_index(struct clk_hw *hw)
>>  {
>>         struct clk_hw_omap *clk =3D to_clk_hw_omap(hw);
>>         const struct clksel *clks;
>> diff --git a/arch/arm/mach-omap2/clkt_dpll.c b/arch/arm/mach-omap2/c=
lkt_dpll.c
>> index 924c230..54b8c49 100644
>> --- a/arch/arm/mach-omap2/clkt_dpll.c
>> +++ b/arch/arm/mach-omap2/clkt_dpll.c
>> @@ -186,7 +186,7 @@ static int _dpll_test_mult(int *m, int n, unsign=
ed long *new_rate,
>>  }
>> =20
>>  /* Public functions */
>> -u8 omap2_init_dpll_parent(struct clk_hw *hw)
>> +int omap2_init_dpll_parent(struct clk_hw *hw)
>>  {
>>         struct clk_hw_omap *clk =3D to_clk_hw_omap(hw);
>>         u32 v;
>> diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock=
=2Eh
>> index 7aa32cd..2784087 100644
>> --- a/arch/arm/mach-omap2/clock.h
>> +++ b/arch/arm/mach-omap2/clock.h
>> @@ -384,7 +384,7 @@ void __init omap2_clk_disable_clkdm_control(void=
);
>>  u32 omap2_clksel_round_rate_div(struct clk_hw_omap *clk,
>>                                 unsigned long target_rate,
>>                                 u32 *new_div);
>> -u8 omap2_clksel_find_parent_index(struct clk_hw *hw);
>> +int omap2_clksel_find_parent_index(struct clk_hw *hw);
>>  unsigned long omap2_clksel_recalc(struct clk_hw *hw, unsigned long =
parent_rate);
>>  long omap2_clksel_round_rate(struct clk_hw *hw, unsigned long targe=
t_rate,
>>                                 unsigned long *parent_rate);
>> @@ -396,7 +396,7 @@ int omap2_clksel_set_parent(struct clk_hw *hw, u=
8 field_val);
>>  extern void omap2_clkt_iclk_allow_idle(struct clk_hw_omap *clk);
>>  extern void omap2_clkt_iclk_deny_idle(struct clk_hw_omap *clk);
>> =20
>> -u8 omap2_init_dpll_parent(struct clk_hw *hw);
>> +int omap2_init_dpll_parent(struct clk_hw *hw);
>>  unsigned long omap2_get_dpll_rate(struct clk_hw_omap *clk);
>> =20
>>  int omap2_dflt_clk_enable(struct clk_hw *hw);
>> --=20
>> 1.7.4.1
>=20
