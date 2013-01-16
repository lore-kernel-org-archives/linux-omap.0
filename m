From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] OMAP: omap4-panda: add WiLink shared transport power functions
Date: Wed, 16 Jan 2013 19:10:57 -0200
Message-ID: <CAOMZO5DtKT9wFvJz+nvJZRgR5aNf1xv9O7FOo4YocOoSsujQ=g@mail.gmail.com>
References: <1358368495-10499-1-git-send-email-coelho@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1358368495-10499-1-git-send-email-coelho@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Luciano Coelho <coelho@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wed, Jan 16, 2013 at 6:34 PM, Luciano Coelho <coelho@ti.com> wrote:

> +static int wilink_st_init(void)
> +{
> +       int status;
> +
> +       status = gpio_request(GPIO_BT_EN, "kim");
> +       if (status) {
> +               pr_err("%s: failed to request gpio %d\n", __func__,
> +                      GPIO_BT_EN);
> +               return status;
> +       }
> +
> +       status = gpio_direction_output(GPIO_BT_EN, 0);
> +       if (status)
> +               pr_err("%s: unable to configure gpio %d", __func__,
> +                      GPIO_BT_EN);
> +

You could use gpio_request_one() instead.
