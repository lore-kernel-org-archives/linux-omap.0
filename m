From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3] clk/ti/adpll: allocate room for terminating null
Date: Fri, 08 Nov 2019 09:01:54 -0800
Message-ID: <20191108170154.B830E222C4@mail.kernel.org>
References: <20191019155441.2b1b349f@heffalump.sk2.org> <20191019140634.15596-1-steve@sk2.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191019140634.15596-1-steve@sk2.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Michael Turquette <mturquette@baylibre.com>, Tero Kristo <t-kristo@ti.com>, Tony Lindgren <tony@atomide.com>, linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Stephen Kitt <steve@sk2.org>
List-Id: linux-omap@vger.kernel.org

Quoting Stephen Kitt (2019-10-19 07:06:34)
> The buffer allocated in ti_adpll_clk_get_name doesn't account for the
> terminating null. This patch switches to devm_kasprintf to avoid
> overflowing.
>=20
> Signed-off-by: Stephen Kitt <steve@sk2.org>
> ---

Applied to clk-next
