From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1/4] extcon: gpio: Convert the driver to use gpio desc
 API's
Date: Mon, 3 Nov 2014 10:01:50 -0800
Message-ID: <20141103180150.GA10164@roeck-us.net>
References: <1415032350-8459-1-git-send-email-balbi@ti.com>
 <1415032350-8459-2-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1415032350-8459-2-git-send-email-balbi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: myungjoo.ham@samsung.com, cw00.choi@samsung.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, nsekhar@ti.com, grant.likely@linaro.org, George Cherian <george.cherian@ti.com>
List-Id: linux-omap@vger.kernel.org

On Mon, Nov 03, 2014 at 10:32:27AM -0600, Felipe Balbi wrote:
> From: George Cherian <george.cherian@ti.com>
> 
> Convert the driver to use gpiod_* API's.
> 
> Reviewed-by: Roger Quadros <rogerq@ti.com>
> Signed-off-by: George Cherian <george.cherian@ti.com>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---

I think it might be useful and appropriate to explain that and why
you remove support for active-low pins, instead of hiding it in a
seemingly unrelated patch.

Also, since you don't use the platform data flag anymore, you might
as well remove it to give out-of-tree users a fair warning. Overall,
it might be easier to just revert the patch introducing it (5bfbdc9caa7)
before converting extcon to gpiod.

I am just glad that we stopped using extcon for other reasons ;-)

Guenter
