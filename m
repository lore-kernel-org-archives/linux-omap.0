From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] clk: don't use __initconst for non-const arrays
Date: Fri, 12 Sep 2014 00:04:45 +0200
Message-ID: <20140911220445.GQ3755@pengutronix.de>
References: <1410469471-31027-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1410469471-31027-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>
Cc: Heiko Stuebner <heiko@sntech.de>, Tomasz Figa <tomasz.figa@gmail.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Tero Kristo <t-kristo@ti.com>, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org, kernel@pengutronix.de
List-Id: linux-omap@vger.kernel.org

Hello,

On Thu, Sep 11, 2014 at 11:04:31PM +0200, Uwe Kleine-K=F6nig wrote:
>  /* Mux parent lists. */
> -static const char *fin_pll_p[] __initconst =3D {
> +static const char *fin_pll_p[] __initdata =3D {
>  	"xxti",
>  	"xusbxti"
>  };
As discussed with Tomasz on irc: The sad thing here is that for this
array only 8 bytes are freed when .init.rodata is thrown away (that is
two pointers). The actual data---5 + 8 bytes + maybe aligning---isn't
freed though.

We wondered if there is a nice and easy way to throw away the
characters, too.

The only way I currently see is:

	const char xxti[] __initconst =3D "xxti";
	...

	static const char *fin_pll_p[] __initdata =3D {
		xxti,
		...
	};

but this definitively doesn't qualify as "nice and easy". Is there an
alternative?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
