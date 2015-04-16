From: Peter Chen <peter.chen@freescale.com>
Subject: Re: [RFC][PATCH v2 02/13] usb: otg-fsm: support multiple instances
Date: Thu, 16 Apr 2015 20:06:02 +0800
Message-ID: <20150416120602.GF3181@shlinux2>
References: <1429008120-5395-1-git-send-email-rogerq@ti.com>
 <1429008120-5395-3-git-send-email-rogerq@ti.com>
 <20150416113559.GB3181@shlinux2> <552FA3DC.90709@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bn1on0145.outbound.protection.outlook.com ([157.56.110.145]:3910
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754730AbbDPMIi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Apr 2015 08:08:38 -0400
Content-Disposition: inline
In-Reply-To: <552FA3DC.90709@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: gregkh@linuxfoundation.org, balbi@ti.com, stern@rowland.harvard.edu, dan.j.williams@intel.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, tony@atomide.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org

On Thu, Apr 16, 2015 at 02:58:20PM +0300, Roger Quadros wrote:
> On 16/04/15 14:36, Peter Chen wrote:
> > On Tue, Apr 14, 2015 at 01:41:49PM +0300, Roger Quadros wrote:
> >> Move the state_changed variable into struct otg_fsm
> >> so that we can support multiple instances.
> > 
> > OTG device has only one port. See 3.1.1.
> > If you go to pass OTG Certification, the lab requires that there is only
> > one port at your board.
> > 
> 
> We're not breaking OTG compliance by this ;).
> Moreover this structure is not limited to OTG but for DRD (dual-role) use as well.
> We can have multiple DRD ports per board.
> 

Ok, the code is ok for keeping multiple instances.

Peter
> 
> >>
> >> Signed-off-by: Roger Quadros <rogerq@ti.com>
> >> ---
> >>  drivers/usb/common/usb-otg-fsm.c | 10 ++++------
> >>  include/linux/usb/otg-fsm.h      |  1 +
> >>  2 files changed, 5 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/drivers/usb/common/usb-otg-fsm.c b/drivers/usb/common/usb-otg-fsm.c
> >> index 1736bbe..0caa37b 100644
> >> --- a/drivers/usb/common/usb-otg-fsm.c
> >> +++ b/drivers/usb/common/usb-otg-fsm.c
> >> @@ -61,8 +61,6 @@ static int otg_set_protocol(struct otg_fsm *fsm, int protocol)
> >>  	return 0;
> >>  }
> >>  
> >> -static int state_changed;
> >> -
> >>  /* Called when leaving a state.  Do state clean up jobs here */
> >>  static void otg_leave_state(struct otg_fsm *fsm, enum usb_otg_state old_state)
> >>  {
> >> @@ -123,7 +121,7 @@ static void otg_leave_state(struct otg_fsm *fsm, enum usb_otg_state old_state)
> >>  /* Called when entering a state */
> >>  static int otg_set_state(struct otg_fsm *fsm, enum usb_otg_state new_state)
> >>  {
> >> -	state_changed = 1;
> >> +	fsm->state_changed = 1;
> >>  	if (fsm->otg->state == new_state)
> >>  		return 0;
> >>  	VDBG("Set state: %s\n", usb_otg_state_string(new_state));
> >> @@ -255,7 +253,7 @@ int otg_statemachine(struct otg_fsm *fsm)
> >>  	mutex_lock(&fsm->lock);
> >>  
> >>  	state = fsm->otg->state;
> >> -	state_changed = 0;
> >> +	fsm->state_changed = 0;
> >>  	/* State machine state change judgement */
> >>  
> >>  	switch (state) {
> >> @@ -368,7 +366,7 @@ int otg_statemachine(struct otg_fsm *fsm)
> >>  	}
> >>  	mutex_unlock(&fsm->lock);
> >>  
> >> -	VDBG("quit statemachine, changed = %d\n", state_changed);
> >> -	return state_changed;
> >> +	VDBG("quit statemachine, changed = %d\n", fsm->state_changed);
> >> +	return fsm->state_changed;
> >>  }
> >>  EXPORT_SYMBOL_GPL(otg_statemachine);
> >> diff --git a/include/linux/usb/otg-fsm.h b/include/linux/usb/otg-fsm.h
> >> index c5b74c5..85a9150 100644
> >> --- a/include/linux/usb/otg-fsm.h
> >> +++ b/include/linux/usb/otg-fsm.h
> >> @@ -183,6 +183,7 @@ struct otg_fsm {
> >>  	/* Current usb protocol used: 0:undefine; 1:host; 2:client */
> >>  	int protocol;
> >>  	struct mutex lock;
> >> +	bool state_changed;
> >>  };
> >>  
> >>  struct otg_fsm_ops {
> >> -- 
> >> 2.1.0
> >>
> > 
> 

-- 

Best Regards,
Peter Chen
