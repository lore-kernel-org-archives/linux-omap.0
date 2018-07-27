From: David Rivshin <drivshin@awxrd.com>
Subject: Re: [PATCH v2] pwm: pwm-omap-dmtimer: return -EPROBE_DEFER if no
 dmtimer platform data
Date: Fri, 27 Jul 2018 09:42:55 -0400
Message-ID: <20180727094255.09f5dbe3.drivshin@awxrd.com>
References: <20180726133658.23902-1-drivshin@awxrd.com>
 <20180726185426.GA3546@lenoch>
 <20180726163705.4981d44a.drivshin@awxrd.com>
 <20180727071901.GA10846@lenoch> <20180727110006.GC20233@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180727110006.GC20233@amd>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Pavel Machek <pavel@ucw.cz>, Ladislav Michl <ladis@linux-mips.org>
Cc: linux-pwm@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>, Tony Lindgren <tony@atomide.com>, Keerthy <j-keerthy@ti.com>, Thierry Reding <thierry.reding@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Fri, 27 Jul 2018 13:00:06 +0200
Pavel Machek <pavel@ucw.cz> wrote:

> On Fri 2018-07-27 09:19:01, Ladislav Michl wrote:
> > On Thu, Jul 26, 2018 at 04:37:05PM -0400, David Rivshin wrote:  
> > > On Thu, 26 Jul 2018 20:54:26 +0200
> > > Ladislav Michl <ladis@linux-mips.org> wrote:
> > >   
> > > > On Thu, Jul 26, 2018 at 09:36:58AM -0400, David Rivshin wrote:  
> > > > > From: David Rivshin <DRivshin@allworx.com>
> > > > > 
> > > > > If a pwm-omap-dmtimer is probed before the dmtimer it uses, the platform
> > > > > data won't be set yet.
> > > > > 
> > > > > Fixes: ac30751df953 ("ARM: OMAP: pdata-quirks: Remove unused timer pdata")
> > > > > Cc: <stable@vger.kernel.org> # 4.17+
> > > > > Signed-off-by: David Rivshin <drivshin@allworx.com>
> > > > > Acked-by: Pavel Machek <pavel@ucw.cz>
> > > > > Tested-by: Pavel Machek <pavel@ucw.cz>
> > > > > ---
> > > > > Changes in v2:
> > > > > * Added Pavel's Acked-by/Tested-by [1]
> > > > > 
> > > > > [1] https://lkml.org/lkml/2018/7/16/346
> > > > > 
> > > > >  drivers/pwm/pwm-omap-dmtimer.c | 5 +++--
> > > > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
> > > > > index 665da3c8fbceb..d3d7ea7a53146 100644
> > > > > --- a/drivers/pwm/pwm-omap-dmtimer.c
> > > > > +++ b/drivers/pwm/pwm-omap-dmtimer.c
> > > > > @@ -264,8 +264,9 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
> > > > >  
> > > > >  	timer_pdata = dev_get_platdata(&timer_pdev->dev);
> > > > >  	if (!timer_pdata) {
> > > > > -		dev_err(&pdev->dev, "dmtimer pdata structure NULL\n");
> > > > > -		ret = -EINVAL;
> > > > > +		dev_info(&pdev->dev,
> > > > > +			 "dmtimer pdata structure NULL, deferring probe\n");    
> > > > 
> > > > This seems to be a bit verbose for EPROBE_DEFER case. Could we either remove
> > > > it as it is done later in pdata->request_by_node(timer) failure case or at
> > > > least make it dev_dbg? Otherwise thank you and with mentioned change
> > > > Acked-by: Ladislav Michl <ladis@linux-mips.org>  
> > > 
> > > Hi Ladislav, thanks for the review.
> > > 
> > > I had grepped through other drivers and found no consistent pattern. Some
> > > places used dev_err still, others reduced to one of dev_{warn,info,dbg}, 
> > > and others no message at all. Some messages mentioned they are deferring 
> > > the probe, other didn't. I was already getting a couple of dev_info from 
> > > the pinctrl core code, so I went that way. I figured the message might be
> > > useful to someone, but I don't feel strongly.  
> > 
> > Well, pinctrl probe deferal message is a bit annoying. It really does not
> > tell us much as long as pins are correctly configured and in case they are
> > not it is useless as well :)
> >   
> > > I personally would lean to dev_dbg if you think dev_info is too harsh, 
> > > just in case someone's board suddenly isn't working after upgrade. But 
> > > I'm certainly willing to remove the message entirely if you feel strongly,
> > > or anyone else cares to weigh in.  
> > 
> > I'm fine with dev_dbg as well.  
> 
> Looks good to me, too.

OK, I'll spin a v3 with dev_dbg.

Pavel, I'm not sure of the normal etiquette: since I'm making a minor 
change change to the code, should I keep your Tested-by, or drop it 
until/if you test again? I assume, based on your response, that you'd
still be good with the Acked-by?


> 									Pavel
