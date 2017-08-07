From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/2] gpio: omap : Add missing clk_unprepare().
Date: Mon, 7 Aug 2017 13:58:10 +0200
Message-ID: <CACRpkdaDZhxKmFGqmNUFbb=2e_ZoC1EtiP4G0OaDTvv+qgCfuQ@mail.gmail.com>
References: <e84a2b010f0632369030f92fa30572ba1e4aaaf2.1501569628.git.arvind.yadav.cs@gmail.com>
 <f41f83c5a540065ca9fc1cae754b5b4d4a2749a2.1501569628.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f41f83c5a540065ca9fc1cae754b5b4d4a2749a2.1501569628.git.arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Aug 1, 2017 at 8:44 AM, Arvind Yadav <arvind.yadav.cs@gmail.com> wrote:

> omap_gpio_probe() can fail here and we must disable clock.
>
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Patch applied with Grygorii's ACK.

yours,
Linus Walleij
