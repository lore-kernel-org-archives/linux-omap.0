From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 16/20] mfd: stw481x: Use devm_mfd_add_devices() for
 mfd_device registration
Date: Tue, 5 Apr 2016 15:18:49 +0200
Message-ID: <CACRpkdbVNxCRS6dGFHa6v0o-DBhx=0uGmmBPgUU5pRS=Y90Otg@mail.gmail.com>
References: <1459856912-17859-1-git-send-email-ldewangan@nvidia.com>
	<1459856912-17859-17-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1459856912-17859-17-git-send-email-ldewangan@nvidia.com>
Sender: linux-doc-owner@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: Lee Jones <lee.jones@linaro.org>, Jon Corbet <corbet@lwn.net>, Andreas Werner <andreas.werner@men.de>, Tony Lindgren <tony@atomide.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, "open list:WOLFSON MICROELECTRONICS DRIVERS" <patches@opensource.wolfsonmicro.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Apr 5, 2016 at 1:48 PM, Laxman Dewangan <ldewangan@nvidia.com> wrote:

> Use devm_mfd_add_devices() for mfd devices registration and get
> rid of .remove callback to remove mfd devices. This is done
> by managed device framework.
>
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> CC: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
