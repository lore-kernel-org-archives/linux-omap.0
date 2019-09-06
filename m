From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v2 05/35] clk/ti: Use kmemdup rather than duplicating its implementation
Date: Fri, 06 Sep 2019 14:20:33 -0700
Message-ID: <20190906212033.E6D002070C@mail.kernel.org>
References: <20190703162700.32091-1-huangfq.daxian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190703162700.32091-1-huangfq.daxian@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Tero Kristo <t-kristo@ti.com>, Michael Turquette <mturquette@baylibre.com>, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, Fuqian Huang <huangfq.daxian@gmail.com>
List-Id: linux-omap@vger.kernel.org

Quoting Fuqian Huang (2019-07-03 09:27:00)
> kmemdup is introduced to duplicate a region of memory in a neat way.
> Rather than kmalloc/kzalloc + memcpy, which the programmer needs to
> write the size twice (sometimes lead to mistakes), kmemdup improves
> readability, leads to smaller code and also reduce the chances of mistake=
s.
> Suggestion to use kmemdup rather than using kmalloc/kzalloc + memcpy.
>=20
> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
> ---

Applied to clk-next
