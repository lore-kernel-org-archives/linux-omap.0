From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] clk: ti: fix OF child-node lookup
Date: Thu, 30 Aug 2018 14:46:06 -0700
Message-ID: <153566556601.129321.16962771053169973395@swboyd.mtv.corp.google.com>
References: <20180822090319.29167-1-johan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180822090319.29167-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Michael Turquette <mturquette@baylibre.com>, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
List-Id: linux-omap@vger.kernel.org

Quoting Johan Hovold (2018-08-22 02:03:19)
> Fix child-node lookup which by using the wrong OF helper was searching
> the whole tree depth-first, something which could end up matching an
> unrelated node.
> =

> Also fix the related node-reference leaks.
> =

> Fixes: 5b385a45e001 ("clk: ti: add support for clkctrl aliases")
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---

Applied to clk-next
