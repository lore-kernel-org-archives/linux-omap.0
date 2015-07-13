From: Peter Chen <peter.chen@freescale.com>
Subject: Re: [PATCH v3 02/11] usb: otg-fsm: support multiple instances
Date: Mon, 13 Jul 2015 09:39:49 +0800
Message-ID: <20150713013948.GA27710@shlinux2>
References: <1436350777-28056-1-git-send-email-rogerq@ti.com>
 <1436350777-28056-3-git-send-email-rogerq@ti.com>
 <20150710080642.GB14729@shlinux2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150710080642.GB14729@shlinux2>
Sender: linux-kernel-owner@vger.kernel.org
To: Li Jun <b47624@freescale.com>
Cc: Roger Quadros <rogerq@ti.com>, stern@rowland.harvard.edu, balbi@ti.com, gregkh@linuxfoundation.org, dan.j.williams@intel.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, tony@atomide.com, Joao.Pinto@synopsys.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, Jul 10, 2015 at 04:06:43PM +0800, Li Jun wrote:
> On Wed, Jul 08, 2015 at 01:19:28PM +0300, Roger Quadros wrote:
> > Move the state_changed variable into struct otg_fsm
> > so that we can support multiple instances.
> > 
> I am not sure if multiple instances may happen since OTG protocol requires
> only one OTG port can be equipped on OTG device.
> 

It is ok the software can support more than spec requires, the user can
only use one and the spec may change in future :)

> Li Jun
>  
> > Signed-off-by: Roger Quadros <rogerq@ti.com>
> > ---
> >  drivers/usb/common/usb-otg-fsm.c | 10 ++++------
> >  include/linux/usb/otg-fsm.h      |  1 +
> >  2 files changed, 5 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/usb/common/usb-otg-fsm.c b/drivers/usb/common/usb-otg-fsm.c
> > index 61d538a..42c6376 100644
> > --- a/drivers/usb/common/usb-otg-fsm.c
> > +++ b/drivers/usb/common/usb-otg-fsm.c
> > @@ -61,8 +61,6 @@ static int otg_set_protocol(struct otg_fsm *fsm, int protocol)
> >  	return 0;
> >  }
> >  
> > -static int state_changed;
> > -
> >  /* Called when leaving a state.  Do state clean up jobs here */
> >  static void otg_leave_state(struct otg_fsm *fsm, enum usb_otg_state old_state)
> >  {
> > @@ -123,7 +121,7 @@ static void otg_leave_state(struct otg_fsm *fsm, enum usb_otg_state old_state)
> >  /* Called when entering a state */
> >  static int otg_set_state(struct otg_fsm *fsm, enum usb_otg_state new_state)
> >  {
> > -	state_changed = 1;
> > +	fsm->state_changed = 1;
> >  	if (fsm->otg->state == new_state)
> >  		return 0;
> 
> "fsm->state_changed = 1;" should be put here, I think.
> 

Yes, seems it is the problem at current code.

> Li Jun
> 
> >  	VDBG("Set state: %s\n", usb_otg_state_string(new_state));
> > @@ -248,7 +246,7 @@ int otg_statemachine(struct otg_fsm *fsm)
> >  	mutex_lock(&fsm->lock);
> >  
> >  	state = fsm->otg->state;
> > -	state_changed = 0;
> > +	fsm->state_changed = 0;
> >  	/* State machine state change judgement */
> >  
> >  	switch (state) {
> > @@ -361,7 +359,7 @@ int otg_statemachine(struct otg_fsm *fsm)
> >  	}
> >  	mutex_unlock(&fsm->lock);
> >  
> > -	VDBG("quit statemachine, changed = %d\n", state_changed);
> > -	return state_changed;
> > +	VDBG("quit statemachine, changed = %d\n", fsm->state_changed);
> > +	return fsm->state_changed;
> >  }
> >  EXPORT_SYMBOL_GPL(otg_statemachine);
> > diff --git a/include/linux/usb/otg-fsm.h b/include/linux/usb/otg-fsm.h
> > index ca508c2..243274f 100644
> > --- a/include/linux/usb/otg-fsm.h
> > +++ b/include/linux/usb/otg-fsm.h
> > @@ -194,6 +194,7 @@ struct otg_fsm {
> >  	/* Current usb protocol used: 0:undefine; 1:host; 2:client */
> >  	int protocol;
> >  	struct mutex lock;
> > +	bool state_changed;
> >  };
> >  
> >  struct otg_fsm_ops {
> > -- 
> > 2.1.4
> > 

-- 

Best Regards,
Peter Chen
