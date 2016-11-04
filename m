From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/4] pinctrl: single: Use generic parser and
 #pinctrl-cells for pinctrl-single,pins
Date: Fri, 4 Nov 2016 22:52:39 +0100
Message-ID: <CACRpkdaJ5gvZdXtJn3PaBZs1hM0jsuN=MQs+wPmu70s0jdT00w@mail.gmail.com>
References: <20161103163550.27330-1-tony@atomide.com> <20161103163550.27330-3-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20161103163550.27330-3-tony@atomide.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jon Hunter <jonathanh@nvidia.com>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Nishanth Menon <nm@ti.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Nov 3, 2016 at 5:35 PM, Tony Lindgren <tony@atomide.com> wrote:

> We can now use generic parser. To support the legacy binding without
> #pinctrl-cells, add pcs_quirk_missing_pinctrl_cells() and warn about
> missing #pinctrl-cells.
>
> Let's also update the documentation for struct pcs_soc_data while at it
> as that seems to be out of date.
>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

This v2 patch applied.

Yours,
Linus Walleij
