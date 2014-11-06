From: Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH 1/4] input: touchscreen: ti_am335x_tsc Interchange
 touchscreen and ADC steps
Date: Thu, 6 Nov 2014 15:19:17 +0100
Message-ID: <20141106141916.GA17151@netboy>
References: <1414408111-2631-1-git-send-email-vigneshr@ti.com>
 <1414408111-2631-2-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1414408111-2631-2-git-send-email-vigneshr@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Vignesh R <vigneshr@ti.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Tony Lindgren <tony@atomide.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Paul Gortmaker <paul.gortmaker@windriver.com>, Peter Meerwald <pmeerw@pmeerw.net>, Lee Jones <lee.jones@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>, Russell King <linux@arm.linux.org.uk>, Samuel Ortiz <sameo@linux.intel.com>, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, Brad Griffis <bgriffis@ti.com>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Hartmut Knaack <knaack.h@gmx.de>, Rob Herring <robh+dt@kernel.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jan Kardell <jan.kardell@telliq.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Benoit Cousson <bcousson@baylibre.com>, Kumar Gala <galak@>
List-Id: linux-omap@vger.kernel.org

On Mon, Oct 27, 2014 at 04:38:28PM +0530, Vignesh R wrote:

...

> @@ -209,6 +214,7 @@ static void titsc_read_coordinates(struct titsc *ts_dev,
>  	unsigned int read, diff;
>  	unsigned int i, channel;
>  	unsigned int creads = ts_dev->coordinate_readouts;
> +	unsigned int first_step = TOTAL_STEPS - (creads * 2 + 2);
>  
>  	*z1 = *z2 = 0;
>  	if (fifocount % (creads * 2 + 2))
> @@ -226,7 +232,7 @@ static void titsc_read_coordinates(struct titsc *ts_dev,
>  
>  		channel = (read & 0xf0000) >> 16;
>  		read &= 0xfff;
> -		if (channel < creads) {
> +		if (channel > first_step + creads + 2) {
>  			diff = abs(read - prev_val_x);
>  			if (diff < prev_diff_x) {
>  				prev_diff_x = diff;
> @@ -234,19 +240,19 @@ static void titsc_read_coordinates(struct titsc *ts_dev,
>  			}
>  			prev_val_x = read;
>  
> -		} else if (channel < creads * 2) {
> +		} else if (channel == first_step + creads + 1) {
> +			*z1 = read;
> +
> +		} else if (channel == first_step + creads + 2) {
> +			*z2 = read;
> +
> +		} else if (channel > first_step) {
>  			diff = abs(read - prev_val_y);
>  			if (diff < prev_diff_y) {
>  				prev_diff_y = diff;
>  				*y = read;

While you are at it, please get rid of the this "delta filter"
nonsense.

Thanks,
Richard

>  			}
>  			prev_val_y = read;
> -
> -		} else if (channel < creads * 2 + 1) {
> -			*z1 = read;
> -
> -		} else if (channel < creads * 2 + 2) {
> -			*z2 = read;
>  		}
>  	}
>  }
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
