From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 1/2] pinctrl: single: check for any error when getting rows
Date: Fri, 11 Nov 2016 21:29:02 +0100
Message-ID: <CACRpkdYuC6rWJJf1wdrjEvLc1_3RtEKcpKwCn4SQ_Kby2BP7bg@mail.gmail.com>
References: <20161109145401.25327-1-ahaslam@baylibre.com> <20161109145401.25327-2-ahaslam@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20161109145401.25327-2-ahaslam@baylibre.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Axel Haslam <ahaslam@baylibre.com>
Cc: ext Tony Lindgren <tony@atomide.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, Kevin Hilman <khilman@baylibre.com>, "Nori, Sekhar" <nsekhar@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Nov 9, 2016 at 3:54 PM, Axel Haslam <ahaslam@baylibre.com> wrote:

> pinctrl_count_index_with_args returns -ENOENT not
> -EINVAL. The return check would pass, and we would
> try to kzalloc with a negative error size throwing
> a warning.
>
> Instead of checking for -EINVAL specifically, lets
> check for any error and avoid negative size allocations.
>
> Signed-off-by: Axel Haslam <ahaslam@baylibre.com>

Patch applied with Tony's ACK.

Yours,
Linus Walleij
