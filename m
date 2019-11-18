From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: clock: Move ti-dra7-atl.h to dt-bindigs/clock
Date: Mon, 18 Nov 2019 16:29:59 -0600
Message-ID: <CAL_JsqLahJZ0TqmgNS_cvwtTUw4kRCjD2bn-vdAN8xYmM7zY0w@mail.gmail.com>
References: <20191114101817.20831-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191114101817.20831-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, linux-omap <linux-omap@vger.kernel.org>, linux-clk <linux-clk@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, Nov 14, 2019 at 4:17 AM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
>

typo in subject.

> Most of the clock related dt-binding header files are located in
> dt-bindings/clock folder. It would be good to keep all the similar
> header files at a single location.
>
> Suggested-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  Documentation/devicetree/bindings/clock/ti/dra7-atl.txt | 4 ++--
>  arch/arm/boot/dts/dra7-evm-common.dtsi                  | 2 +-
>  arch/arm/boot/dts/dra72-evm-common.dtsi                 | 2 +-
>  include/dt-bindings/{clk => clock}/ti-dra7-atl.h        | 0
>  4 files changed, 4 insertions(+), 4 deletions(-)
>  rename include/dt-bindings/{clk => clock}/ti-dra7-atl.h (100%)

Otherwise,

Acked-by: Rob Herring <robh@kernel.org>
