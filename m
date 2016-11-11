From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 2/2] pinctrl: single: search for the bits property when
 parsing bits
Date: Fri, 11 Nov 2016 21:30:12 +0100
Message-ID: <CACRpkdam=s2Px64iqybciaDMugDaqTT=SgxMKpAMFrQp0PmH7Q@mail.gmail.com>
References: <20161109145401.25327-1-ahaslam@baylibre.com> <20161109145401.25327-3-ahaslam@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161109145401.25327-3-ahaslam@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Axel Haslam <ahaslam@baylibre.com>
Cc: ext Tony Lindgren <tony@atomide.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, Kevin Hilman <khilman@baylibre.com>, "Nori, Sekhar" <nsekhar@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Nov 9, 2016 at 3:54 PM, Axel Haslam <ahaslam@baylibre.com> wrote:

> The pcs_parse_bits_in_pinctrl_entry function should search
> for the "pinctrl-single,bits" and not "pinctrl-single,pins"
>
> Signed-off-by: Axel Haslam <ahaslam@baylibre.com>

Patch applied with Tony's ACK.

Yours,
Linus Walleij
