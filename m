From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH] Remove inline from clock framework function definitions
 to build the kernel with GCC 4.7
Date: Thu, 15 Nov 2012 12:24:40 -0600
Message-ID: <50A53368.6090306@ti.com>
References: <50A52134.2010502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <50A52134.2010502@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: i.mazanov@gmail.com, Mike Turquette <mturquette@ti.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, tony@atomide.com, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


On 11/15/2012 11:07 AM, Igor Mazanov wrote:
>  Remove inline from clock framework function definitions to
>  build the kernel with GCC 4.7

Adding Mike to the party ...

May be good to add some details about the exact problem seen.

I am seeing the same problem today with GCC 4.7 and Tony's master
branch. For a bit of background it seems that for 4.7 not having
the body of the inlined function available in the header is
causing this error. Another example here [1].

The actual compiler error seen for OMAP is ...

In file included from arch/arm/mach-omap2/clockdomain.c:25:0:
arch/arm/mach-omap2/clockdomain.c: In function =E2=80=98clkdm_clk_disab=
le=E2=80=99:
include/linux/clk-provider.h:338:12: error: inlining failed in call to =
always_inline =E2=80=98__clk_get_enable_count=E2=80=99: function body n=
ot available
arch/arm/mach-omap2/clockdomain.c:1001:28: error: called from here
make[1]: *** [arch/arm/mach-omap2/clockdomain.o] Error 1
make: *** [arch/arm/mach-omap2] Error 2

=20
> Signed-off-by: Igor Mazanov <i.mazanov@gmail.com>
> ---
>  include/linux/clk-provider.h |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provide=
r.h
> index c127315..f9f5e9e 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -335,8 +335,8 @@ const char *__clk_get_name(struct clk *clk);
>  struct clk_hw *__clk_get_hw(struct clk *clk);
>  u8 __clk_get_num_parents(struct clk *clk);
>  struct clk *__clk_get_parent(struct clk *clk);
> -inline int __clk_get_enable_count(struct clk *clk);
> -inline int __clk_get_prepare_count(struct clk *clk);
> +int __clk_get_enable_count(struct clk *clk);
> +int __clk_get_prepare_count(struct clk *clk);
>  unsigned long __clk_get_rate(struct clk *clk);
>  unsigned long __clk_get_flags(struct clk *clk);
>  int __clk_is_enabled(struct clk *clk);

Do we also need to remove the inline from the functions declared in
drivers/clk/clk.c too?

Cheers
Jon

[1] https://bugs.launchpad.net/linaro-android/+bug/983496
