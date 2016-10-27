From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 0/4] Generic #pinctrl-cells and and pinctrl_parse_index_with_args
Date: Thu, 27 Oct 2016 10:15:32 +0200
Message-ID: <CACRpkdYni7SSNnzhFJg+MOhML2ma2bcv8LvctkQfwfcGch8wUg@mail.gmail.com>
References: <20161025164538.453-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20161025164538.453-1-tony@atomide.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jon Hunter <jonathanh@nvidia.com>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Nishanth Menon <nm@ti.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Oct 25, 2016 at 6:45 PM, Tony Lindgren <tony@atomide.com> wrote:

> Here are some pinctrl changes to introduce #pinctrl-cells and a generic
> parser pinctrl_parse_index_with_args that the drivers can optionally use.

I like this set. If we can get ACK from the DT people and get the
modifier of_* functions exported I'm generally happy to merge it.

Yours,
Linus Walleij
