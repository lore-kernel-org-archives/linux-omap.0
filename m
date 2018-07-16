From: David Rivshin <drivshin@awxrd.com>
Subject: Re: [PATCH] pwm-omap: handle timers not ready in probe
Date: Mon, 16 Jul 2018 11:47:58 -0400
Message-ID: <20180716114758.60a6a6cb.drivshin@awxrd.com>
References: <20180709214910.tes6u4ivxomd3aja@earth.universe>
 <20180709220211.GA7760@amd>
 <20180710101147.lyu65ro4czvrs2da@earth.universe>
 <20180710133040.GA4391@amd>
 <20180710161123.azym6sbboriuj4yc@earth.universe>
 <20180711080218.GA21225@amd> <20180711132739.GL99251@atomide.com>
 <20180711142526.dto6iost57zx5t5l@earth.universe>
 <20180716071323.GB23110@amd> <20180716075740.GT99251@atomide.com>
 <20180716083720.GA3047@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180716083720.GA3047@amd>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Pavel Machek <pavel@ucw.cz>, Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, mpartap@gmx.net, Tony Lindgren <tony@atomide.com>, merlijn@wizzup.org, Sebastian Reichel <sre@kernel.org>, kernel list <linux-kernel@vger.kernel.org>, nekit1000@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Mon, 16 Jul 2018 10:37:20 +0200
Pavel Machek <pavel@ucw.cz> wrote:

> On Mon 2018-07-16 00:57:40, Tony Lindgren wrote:
> > * Pavel Machek <pavel@ucw.cz> [180716 07:16]:  
> > > 
> > > When all the drivers are built-in, timers are not ready and probing
> > > fails. Fix that with -EPROBE_DEFFER.
> > > 
> > > Signed-off-by: Pavel Machek <pavel@ucw.cz>
> > > 
> > > diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
> > > index 665da3c..debeb70 100644
> > > --- a/drivers/pwm/pwm-omap-dmtimer.c
> > > +++ b/drivers/pwm/pwm-omap-dmtimer.c
> > > @@ -265,7 +271,7 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
> > >  	timer_pdata = dev_get_platdata(&timer_pdev->dev);
> > >  	if (!timer_pdata) {
> > >  		dev_err(&pdev->dev, "dmtimer pdata structure NULL\n");
> > > -		ret = -EINVAL;
> > > +		ret = -EPROBE_DEFER;
> > >  		goto put;
> > >  	}  
> > 
> > There seems to be an earlier similar patch, care to take a look
> > at "[PATCH] pwm: pwm-omap-dmtimer: return -EPROBE_DEFER if no
> > dmtimer platform data"?  
> 
> Yes, that one is equivalent.
> 
> You can add
> 
> Acked-by: Pavel Machek <pavel@ucw.cz>
> Tested-by: Pavel Machek <pavel@ucw.cz>
> 
> on it.
> 
> Thanks,
> 									Pavel

Thanks Pavel. I hadn't been watching the Droid 4 threads, so I didn't 
see you were hitting the same problem. I'm assuming the patch will go
through the PWM tree, so copying in Thierry.
