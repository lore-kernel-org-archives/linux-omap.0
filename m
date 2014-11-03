From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1/4] extcon: gpio: Convert the driver to use gpio desc
 API's
Date: Mon, 3 Nov 2014 10:51:08 -0800
Message-ID: <20141103185101.GC10558@roeck-us.net>
References: <1415032350-8459-1-git-send-email-balbi@ti.com>
 <1415032350-8459-2-git-send-email-balbi@ti.com>
 <20141103180150.GA10164@roeck-us.net>
 <20141103180602.GU27425@saruman>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141103180602.GU27425@saruman>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: myungjoo.ham@samsung.com, cw00.choi@samsung.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, nsekhar@ti.com, grant.likely@linaro.org, George Cherian <george.cherian@ti.com>
List-Id: linux-omap@vger.kernel.org

On Mon, Nov 03, 2014 at 12:06:02PM -0600, Felipe Balbi wrote:
> On Mon, Nov 03, 2014 at 10:01:50AM -0800, Guenter Roeck wrote:
> > On Mon, Nov 03, 2014 at 10:32:27AM -0600, Felipe Balbi wrote:
> > > From: George Cherian <george.cherian@ti.com>
> > > 
> > > Convert the driver to use gpiod_* API's.
> > > 
> > > Reviewed-by: Roger Quadros <rogerq@ti.com>
> > > Signed-off-by: George Cherian <george.cherian@ti.com>
> > > Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> > > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > > ---
> > 
> > I think it might be useful and appropriate to explain that and why
> > you remove support for active-low pins, instead of hiding it in a
> > seemingly unrelated patch.
> 
> removed ? why removed ? gpio descs handle that for you, read the source
> code.
> 
Well, it for sure looks like it. Care to explain that in the patch,
as well as how the platform data flag is used ?

Thanks,
Guenter
