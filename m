From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] of: provide of_platform_unpopulate()
Date: Mon, 29 Jul 2013 19:33:02 +1000
Message-ID: <1375090382.3859.38.camel@pasglop>
References: <1374257691-31981-1-git-send-email-bigeasy@linutronix.de>
	 <51EBF33A.4050207@gmail.com> <51EC4908.4040504@gmail.com>
	 <CACxGe6sqv2Wsp26MWqqs9W_eWO3tjs-+2z3z8fC=2fe-BjJvkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACxGe6sqv2Wsp26MWqqs9W_eWO3tjs-+2z3z8fC=2fe-BjJvkA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grant Likely <grant.likely@linaro.org>
Cc: Rob Herring <robherring2@gmail.com>, George Cherian <george.cherian@ti.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, devicetree-discuss <devicetree-discuss@lists.ozlabs.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rob Herring <rob.herring@calxeda.com>, Kishon Vijay Abraham I <kishon@ti.com>, Kukjin Kim <kgene.kim@samsung.com>, Felipe Balbi <balbi@ti.com>, Roger Quadros <rogerq@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Naveen Krishna Chatradhi <ch.naveen@samsung.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Vivek Gautam <gautam.vivek@samsung.com>
List-Id: linux-omap@vger.kernel.org

On Mon, 2013-07-22 at 00:44 +0100, Grant Likely wrote:
> > BTW, it looks like Grant has attempted this already:
> 
> Yup, things broke badly. Unfortunately the of_platform_device and
> platform_device history doesn't treat resources in the same way. I
> would like to merge the code, but I haven't been able to figure out a
> clean way to do it. Looks like we do need the unpopulate function.

What is the exact problem Grant ? Care to give me an example ?

Cheers,
Ben.
