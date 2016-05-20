From: Rob Herring <robh@kernel.org>
Subject: Re: [RFC PATCH 1/2] Input: rotary-encoder- Add support for absolute
 encoder
Date: Fri, 20 May 2016 16:49:06 -0500
Message-ID: <20160520214906.GA20973@rob-hp-laptop>
References: <1463648641-6931-1-git-send-email-vigneshr@ti.com>
 <1463648641-6931-2-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1463648641-6931-2-git-send-email-vigneshr@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Tony Lindgren <tony@atomide.com>, Jonathan Corbet <corbet@lwn.net>, Johan Hovold <johan@kernel.org>, Sylvain Rochet <sylvain.rochet@finsecur.com>, Masanari Iida <standby24x7@gmail.com>, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, S Twiss <stwiss.opensource@diasemi.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Moritz Fischer <moritz.fischer@ettus.com>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Timo Teras <timo.teras@iki.fi>, Guido Martinez <guido@vanguardiasur.com.ar>, Clifton Barnes <clifton.a.barnes@gmail.com>, Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Thu, May 19, 2016 at 02:34:00PM +0530, Vignesh R wrote:
> There are rotary-encoders where GPIO lines reflect the actual position
> of the rotary encoder dial. For example, if dial points to 9, then four
> GPIO lines connected to the rotary encoder will read HLLH(1001b = 9).
> Add support for such rotary-encoder.
> The driver relies on rotary-encoder,absolute-encoder DT property to
> detect such encoders.
> Since, GPIO IRQs are not necessary to work with
> such encoders, optional polling mode support is added using
> input_poll_dev skeleton. This is can be used by enabling
> CONFIG_INPUT_GPIO_ROTARY_ENCODER_POLL_MODE_SUPPORT.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
>  .../devicetree/bindings/input/rotary-encoder.txt   |   4 +
>  Documentation/input/rotary-encoder.txt             |   9 ++
>  drivers/input/misc/Kconfig                         |  11 ++
>  drivers/input/misc/rotary_encoder.c                | 165 ++++++++++++++++-----
>  4 files changed, 155 insertions(+), 34 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/input/rotary-encoder.txt b/Documentation/devicetree/bindings/input/rotary-encoder.txt
> index 6c9f0c8a846c..9c928dbd1500 100644
> --- a/Documentation/devicetree/bindings/input/rotary-encoder.txt
> +++ b/Documentation/devicetree/bindings/input/rotary-encoder.txt
> @@ -12,6 +12,10 @@ Optional properties:
>  - rotary-encoder,relative-axis: register a relative axis rather than an
>    absolute one. Relative axis will only generate +1/-1 events on the input
>    device, hence no steps need to be passed.
> +- rotary-encoder,absolute-encoder: support encoders where GPIO lines
> +  reflect the actual position of the rotary encoder dial. For example,
> +  if dial points to 9, then four GPIO lines read HLLH(1001b = 9).
> +  In this case, rotary-encoder,steps-per-period needed not be defined.

I think this should be done as a new compatible string rather than a 
property. It seems like fundamentally different h/w.

Rob
