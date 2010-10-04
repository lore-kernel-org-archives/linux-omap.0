From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [PATCH v2] OMAP3: Keypad: Fix failure exit path in probe
Date: Mon, 4 Oct 2010 13:32:29 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402DB90C98C@dbde02.ent.ti.com>
References: <1285069770-4261-1-git-send-email-manjugk@ti.com>
 <1285076060.14206.3.camel@chotu>
 <E0D41E29EB0DAC4E9F3FF173962E9E9402785A3478@dbde02.ent.ti.com>
 <20100921162658.GA2310@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20100921162658.GA2310@core.coreip.homeip.net>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Ameya Palande <ameya.palande@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

Dmitry,
As agreed, can you push this patch?
https://patchwork.kernel.org/patch/197442/

-Manjunath

> -----Original Message-----
> From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com] 
> Sent: Tuesday, September 21, 2010 9:57 PM
> To: G, Manjunath Kondaiah
> Cc: Ameya Palande; linux-omap@vger.kernel.org; 
> linux-input@vger.kernel.org; 
> linux-arm-kernel@lists.infradead.org; Tony Lindgren
> Subject: Re: [PATCH v2] OMAP3: Keypad: Fix failure exit path in probe
> 
> Hi,
> 
> On Tue, Sep 21, 2010 at 07:11:01PM +0530, G, Manjunath Kondaiah wrote:
> > 
> > Hi,
> > 
> > > -----Original Message-----
> > > From: Ameya Palande [mailto:ameya.palande@nokia.com]
> > > Sent: Tuesday, September 21, 2010 7:04 PM
> > > To: G, Manjunath Kondaiah
> > > Cc: linux-omap@vger.kernel.org; 
> linux-input@vger.kernel.org; Dmitry 
> > > Torokhov; linux-arm-kernel@lists.infradead.org; Tony Lindgren
> > > Subject: Re: [PATCH v2] OMAP3: Keypad: Fix failure exit path in 
> > > probe
> > > 
> > > Hi Manjunath,
> > > 
> > > On Tue, 2010-09-21 at 13:49 +0200, ext G, Manjunath 
> Kondaiah wrote:
> > > > The failure exit paths seems to be wrong in probe function.
> > > > This patch corrects exit failure paths for error handling cases.
> > > 
> 
> And also adds memory leak...
> 
> 
> > > https://patchwork.kernel.org/patch/160551/
> > > Any comments on this?
> > 
> > Looks fine. Sorry, I didn't look at the change. This 
> version seems to 
> > be better.
> > 
> 
> I do not understand why we need to separate memory 
> allocations. It looks
> like the minimal patch should be like one below.
> 
> Thanks.
> 
> -- 
> Dmitry
> 
> 
> Input: twl4030_keypad - fix error handling path
> 
> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> We should not try to call free_irq() when request_irq() failed.
> 
> Reported-by: G, Manjunath Kondaiah <manjugk@ti.com>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
> 
>  drivers/input/keyboard/twl4030_keypad.c |    7 +++----
>  1 files changed, 3 insertions(+), 4 deletions(-)
> 
> 
> diff --git a/drivers/input/keyboard/twl4030_keypad.c 
> b/drivers/input/keyboard/twl4030_keypad.c
> index fb16b5e..09bef79 100644
> --- a/drivers/input/keyboard/twl4030_keypad.c
> +++ b/drivers/input/keyboard/twl4030_keypad.c
> @@ -406,23 +406,22 @@ static int __devinit 
> twl4030_kp_probe(struct platform_device *pdev)
>  	if (error) {
>  		dev_info(kp->dbg_dev, "request_irq failed for 
> irq no=%d\n",
>  			kp->irq);
> -		goto err3;
> +		goto err2;
>  	}
>  
>  	/* Enable KP and TO interrupts now. */
>  	reg = (u8) ~(KEYP_IMR1_KP | KEYP_IMR1_TO);
>  	if (twl4030_kpwrite_u8(kp, reg, KEYP_IMR1)) {
>  		error = -EIO;
> -		goto err4;
> +		goto err3;
>  	}
>  
>  	platform_set_drvdata(pdev, kp);
>  	return 0;
>  
> -err4:
> +err3:
>  	/* mask all events - we don't care about the result */
>  	(void) twl4030_kpwrite_u8(kp, 0xff, KEYP_IMR1);
> -err3:
>  	free_irq(kp->irq, NULL);
>  err2:
>  	input_unregister_device(input);
> 