From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH RESEND] phy: phy-twl4030-usb: fix denied runtime access
Date: Tue, 18 Sep 2018 09:56:24 -0700
Message-ID: <20180918165624.GB177805@dtor-ws>
References: <20180917052254.12336-1-andreas@kemnade.info>
 <20180917175131.GA104770@dtor-ws>
 <20180917205634.6a320cad@aktux>
 <20180917222345.GA203020@dtor-ws>
 <20180918181619.2e266f0d@aktux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180918181619.2e266f0d@aktux>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Kemnade <andreas@kemnade.info>
Cc: kishon@ti.com, lee.jones@linaro.org, daniel.thompson@linaro.org, wsa@the-dreams.de, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Sep 18, 2018 at 06:16:19PM +0200, Andreas Kemnade wrote:
> Hi,
> 
> On Mon, 17 Sep 2018 15:23:45 -0700
> Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> 
> > On Mon, Sep 17, 2018 at 08:56:34PM +0200, Andreas Kemnade wrote:
> > > Hi Dmitry,
> > > 
> > > On Mon, 17 Sep 2018 10:51:31 -0700
> > > Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > >   
> > > > Hi Andreas,
> > > > 
> > > > On Mon, Sep 17, 2018 at 07:22:54AM +0200, Andreas Kemnade wrote:  
> > > > > When runtime is not enabled, pm_runtime_get_sync() returns -EACCESS,
> > > > > the counter will be incremented but the resume callback not called,
> > > > > so enumeration and charging will not start properly.
> > > > > To avoid that happen, wait and try again later.
> > > > > 
> > > > > Practically this happens when the device is woken up from suspend by
> > > > > plugging in usb.
> > > > > 
> > > > > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > > > > ---
> > > > >  drivers/phy/ti/phy-twl4030-usb.c | 9 +++++++++
> > > > >  1 file changed, 9 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/phy/ti/phy-twl4030-usb.c b/drivers/phy/ti/phy-twl4030-usb.c
> > > > > index a44680d64f9b..1f3cf4e48383 100644
> > > > > --- a/drivers/phy/ti/phy-twl4030-usb.c
> > > > > +++ b/drivers/phy/ti/phy-twl4030-usb.c
> > > > > @@ -552,6 +552,15 @@ static irqreturn_t twl4030_usb_irq(int irq, void *_twl)
> > > > >  
> > > > >  	status = twl4030_usb_linkstat(twl);
> > > > >  
> > > > > +	/* we might get here too early when runtime is not ready yet
> > > > > +	 * and we will get an EACCESS later, so try again later
> > > > > +	 */    
> > > > 
> > > > How exactly can this happen? What disables (and later re-enables)
> > > > runtime PM?   
> > > If the whole resume process is started by plugging in usb, the
> > > interrupt will be triggered still in the resume process so that 
> > > runtime resume is not yet possible, pm_runtime_get_sync() returns
> > > EACCESS  
> > 
> > I see. This all seems a bit wonky, to be honest. I would expect that the
> > driver would have a suspend routine that disables interrupt and also
> > configure interrupt for wakeup (enable_irq_wake) and kick bus scanning
> > from there instead of aborting interrupt handler...
> > 
> well, that seems doable. So there will be a v2.
> 
> > >   
> > > > How can we guarantee that the interrupt will be
> > > > re-triggered?
> > > >   
> > > The interrupt will not be re-triggered but the handler will be
> > > called at some other places...
> > >   
> > > > > +	if (!pm_runtime_enabled(twl->dev)) {
> > > > > +		cancel_delayed_work(&twl->id_workaround_work);
> > > > > +		schedule_delayed_work(&twl->id_workaround_work, HZ);
> > > > > +		return IRQ_HANDLED;
> > > > > +	}
> > > > > +  
> > > ... for example by this delayed work which is already there.  
> > 
> > If we decide to keep this, it should be mod_delayed_work() I think.
> > 
> Well, is that valid for the other uses of id_workaround_work() (which
> are clearly required)? So there should be a second, independent
> cleanup patch for the existing uses?

Yes, mod_delayed_work() is replacement for cancel + reschedule. I guess
this driver was created before mod_delayed_work() was added to the
kernel.

Thanks.

-- 
Dmitry
