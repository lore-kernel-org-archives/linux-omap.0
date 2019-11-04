From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v2] clk: ti: dra7-atl-clock: Remove ti_clk_add_alias call
Date: Mon, 04 Nov 2019 09:56:20 -0800
Message-ID: <20191104175620.CCCF520B7C@mail.kernel.org>
References: <20191002083436.10194-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191002083436.10194-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, mturquette@baylibre.com, t-kristo@ti.com
Cc: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Quoting Peter Ujfalusi (2019-10-02 01:34:36)
> ti_clk_register() calls it already so the driver should not create
> duplicated alias.
>=20
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---

Applied to clk-fixes
