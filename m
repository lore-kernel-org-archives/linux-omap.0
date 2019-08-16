From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] clk: ti: Don't reference clk_init_data after registration
Date: Fri, 16 Aug 2019 07:51:34 -0700
Message-ID: <20190816145135.82244206C1@mail.kernel.org>
References: <20190815221249.53235-1-sboyd@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190815221249.53235-1-sboyd@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, Tero Kristo <t-kristo@ti.com>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

Quoting Stephen Boyd (2019-08-15 15:12:49)
> A future patch is going to change semantics of clk_register() so that
> clk_hw::init is guaranteed to be NULL after a clk is registered. Avoid
> referencing this member here so that we don't run into NULL pointer
> exceptions.
>=20
> Cc: Tero Kristo <t-kristo@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---
>=20
> This might be causing boot regressions in linux-next. Not sure.
>=20

I don't see linux-next boot regressions in kernel-ci so it must be
working.
