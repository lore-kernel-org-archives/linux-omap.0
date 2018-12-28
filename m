From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] clk: ti: fix refcount leak in ti_dt_clocks_register()
Date: Fri, 28 Dec 2018 11:27:17 -0800
Message-ID: <154602523753.179992.582803383819271608@swboyd.mtv.corp.google.com>
References: <20181226132131.4619-1-tiny.windzz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181226132131.4619-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mturquette@baylibre.com, t-kristo@ti.com
Cc: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
List-Id: linux-omap@vger.kernel.org

Quoting Yangtao Li (2018-12-26 05:21:31)
> The of_find_compatible_node() returns a node pointer with refcount
> incremented, but there is the lack of use of the of_node_put() when
> done. Add the missing of_node_put() to release the refcount.
>=20
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/clk/ti/clk.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>=20

Applied to clk-next and fixed a whine

drivers/clk/ti/clk.c:197: trailing whitespace, space before tab in indent.

please be more careful next time. Also, please add fixes tags to fixes.
