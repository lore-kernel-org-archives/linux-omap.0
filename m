From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] clk: ti: dra7-atl: Remove pm_runtime_irq_safe()
Date: Sun, 05 Jan 2020 19:04:43 -0800
Message-ID: <20200106030444.9FB7720801@mail.kernel.org>
References: <20191114101718.20619-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191114101718.20619-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, mturquette@baylibre.com, t-kristo@ti.com
Cc: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

Quoting Peter Ujfalusi (2019-11-14 02:17:18)
> This is not needed for anything, and prevents proper PM transitions for
> parent devices which is bad in case of ti-sysc; this effectively kills
> PM completely. Thus, remove the flag.
>=20
> Suggested-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---

Applied to clk-fixes. Seems important to not ruin the PM experience.
