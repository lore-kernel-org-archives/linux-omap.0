From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 06/10] input: touchscreen: edt-ft5x06: fix driver
 autoprobing
Date: Tue, 18 Nov 2014 10:38:47 -0800
Message-ID: <20141118183847.GE3003@dtor-ws>
References: <1416334028-7766-1-git-send-email-balbi@ti.com>
 <1416334028-7766-6-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1416334028-7766-6-git-send-email-balbi@ti.com>
Sender: linux-input-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Lothar =?iso-8859-1?Q?Wa=DFmann?= <lw@karo-electronics.de>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, linux-input@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Felipe,

On Tue, Nov 18, 2014 at 12:07:04PM -0600, Felipe Balbi wrote:
> i2c devices match against struct i2c_device_id
> even for CONFIG_OF case, so adding a struct of_device_id
> doesn't change anything. As a result, currently, edt-ft5x06
> will not autoprobe if built as a module.

Why doe snot it autoprobe? We properly declare MODULE_DEVICE_TABLE for
OF, is it because we are missing some data in device uevent?

> 
> To fix the issue and still maintain backwards compatibility
> with all DTS files currently in tree, we're just moving
> all ids from of_device_id to i2c_device_id while also
> adding the following specific ids which should be used
> from now on:
> 
> 	{ "edt-ft5206", 0, }
> 	{ "edt-ft5306", 0, }
> 	{ "edt-ft5406", 0, }

Is this a tee-wide change? Link to the discussion?

Thanks.

-- 
Dmitry
