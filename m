From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] pinctrl: pinctrl-single: Add pinctrl-single,bits
 type of mux
Date: Wed, 12 Sep 2012 13:27:01 -0700
Message-ID: <20120912202700.GD5997@atomide.com>
References: <1347353664-15906-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1347353664-15906-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [120911 01:54]:
> With pinctrl-single,bits it is possible to update just part of the register
> within the pinctrl-single,function-mask area.
> This is useful when one register configures mmore than one pin's mux.

>  	size /= sizeof(*mux);	/* Number of elements in array */
> -	rows = size / 2;	/* Each row is a key value pair */
> +	rows = size / params;	/* Each row is a key value pair */

Maybe just remove the comment:  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

I don't think it's needed any longer. Other than that,
thanks for updating the patch:

Acked-by: Tony Lindgren <tony@atomide.com>
