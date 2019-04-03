From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] drivers: gpio: omap: use devm_platform_ioremap_resource()
Date: Wed, 3 Apr 2019 10:07:52 +0700
Message-ID: <CACRpkdYODv81GnsAV=n=TwKjbcAAqh3BVHYddCtMzVWXR4h9iQ@mail.gmail.com>
References: <d3b12ed4-67e6-2993-4f56-80b1be572a24@gmail.com> <1552333805-23235-1-git-send-email-info@metux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1552333805-23235-1-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Mar 12, 2019 at 2:50 AM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:

> Use the new helper that wraps the calls to platform_get_resource()
> and devm_ioremap_resource() together.
>
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>

Patch applied with Grygorii's ACK.

Yours,
Linus Walleij
