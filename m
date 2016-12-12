From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 3/4] dt-bindings: power/supply: Update TPS65217 properties
Date: Mon, 12 Dec 2016 11:26:32 -0600
Message-ID: <20161212172632.p6a3vvbs7bpm4uto@rob-hp-laptop>
References: <20161209062833.5768-1-woogyom.kim@gmail.com>
 <20161209062833.5768-4-woogyom.kim@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161209062833.5768-4-woogyom.kim@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Milo Kim <woogyom.kim@gmail.com>
Cc: bcousson@baylibre.com, Tony Lindgren <tony@atomide.com>, Arnd Bergmann <arnd@arndb.de>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, Dec 09, 2016 at 03:28:32PM +0900, Milo Kim wrote:
> Add interrupt specifiers for USB and AC charger input. Interrupt numbers
> are from the datasheet.
> Fix wrong property for compatible string.
> 
> Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
> ---
>  .../devicetree/bindings/power/supply/tps65217_charger.txt          | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
