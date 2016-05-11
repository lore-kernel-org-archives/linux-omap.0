From: Peter Chen <hzpeterchen@gmail.com>
Subject: Re: [PATCH v7 11/14] usb: otg: use dev_dbg() instead of VDBG()
Date: Wed, 11 May 2016 16:43:31 +0800
Message-ID: <20160511084331.GI16910@shlinux2.ap.freescale.net>
References: <1462191537-10314-1-git-send-email-rogerq@ti.com>
 <1462191537-10314-12-git-send-email-rogerq@ti.com>
 <20160506090425.GD32359@shlinux2.ap.freescale.net>
 <57305CEC.5010604@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <57305CEC.5010604@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: peter.chen@freescale.com, stern@rowland.harvard.edu, balbi@kernel.org, gregkh@linuxfoundation.org, dan.j.williams@intel.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, tony@atomide.com, Joao.Pinto@synopsys.com, abrestic@chromium.org, yoshihiro.shimoda.uh@renesas.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, May 09, 2016 at 12:48:28PM +0300, Roger Quadros wrote:
> On 06/05/16 12:04, Peter Chen wrote:
> > On Mon, May 02, 2016 at 03:18:54PM +0300, Roger Quadros wrote:
> >> Now that we have a device reference in struct usb_otg
> >> let's use dev_dbg() for debug messages.
> >>
> >> Signed-off-by: Roger Quadros <rogerq@ti.com>
> >> ---
> >>  drivers/usb/common/usb-otg-fsm.c | 19 +++++++------------
> >>  1 file changed, 7 insertions(+), 12 deletions(-)
> >>
> >> diff --git a/drivers/usb/common/usb-otg-fsm.c b/drivers/usb/common/usb-otg-fsm.c
> >> index 2986b66..e6e58c2 100644
> >> --- a/drivers/usb/common/usb-otg-fsm.c
> >> +++ b/drivers/usb/common/usb-otg-fsm.c
> >> @@ -30,13 +30,6 @@
> >>  #include <linux/usb/otg.h>
> >>  #include <linux/usb/otg-fsm.h>
> >>  
> >> -#ifdef VERBOSE
> >> -#define VDBG(fmt, args...) pr_debug("[%s]  " fmt , \
> >> -				 __func__, ## args)
> >> -#else
> >> -#define VDBG(stuff...)	do {} while (0)
> >> -#endif
> >> -
> >>  /* Change USB protocol when there is a protocol change */
> >>  static int otg_set_protocol(struct otg_fsm *fsm, int protocol)
> >>  {
> >> @@ -44,8 +37,9 @@ static int otg_set_protocol(struct otg_fsm *fsm, int protocol)
> >>  	int ret = 0;
> >>  
> >>  	if (fsm->protocol != protocol) {
> >> -		VDBG("Changing role fsm->protocol= %d; new protocol= %d\n",
> >> -			fsm->protocol, protocol);
> >> +		dev_vdbg(otg->dev,
> >> +			 "Changing role fsm->protocol= %d; new protocol= %d\n",
> >> +			 fsm->protocol, protocol);
> >>  		/* stop old protocol */
> >>  		if (fsm->protocol == PROTO_HOST)
> >>  			ret = otg_start_host(otg, 0);
> >> @@ -226,7 +220,7 @@ static int otg_set_state(struct otg_fsm *fsm, enum usb_otg_state new_state)
> >>  
> >>  	if (otg->state == new_state)
> >>  		return 0;
> >> -	VDBG("Set state: %s\n", usb_otg_state_string(new_state));
> >> +	dev_vdbg(otg->dev, "Set state: %s\n", usb_otg_state_string(new_state));
> >>  	otg_leave_state(fsm, otg->state);
> >>  	switch (new_state) {
> >>  	case OTG_STATE_B_IDLE:
> >> @@ -358,7 +352,7 @@ int otg_statemachine(struct usb_otg *otg)
> >>  
> >>  	switch (state) {
> >>  	case OTG_STATE_UNDEFINED:
> >> -		VDBG("fsm->id = %d\n", fsm->id);
> >> +		dev_vdbg(otg->dev, "fsm->id = %d\n", fsm->id);
> >>  		if (fsm->id)
> >>  			otg_set_state(fsm, OTG_STATE_B_IDLE);
> >>  		else
> >> @@ -466,7 +460,8 @@ int otg_statemachine(struct usb_otg *otg)
> >>  	}
> >>  	mutex_unlock(&fsm->lock);
> >>  
> >> -	VDBG("quit statemachine, changed = %d\n", fsm->state_changed);
> >> +	dev_vdbg(otg->dev, "quit statemachine, changed = %d\n",
> >> +		 fsm->state_changed);
> >>  	return fsm->state_changed;
> >>  }
> >>  EXPORT_SYMBOL_GPL(otg_statemachine);
> >> -- 
> > 
> > Could you squash patch 2 with this one?
> > 
> 
> We can't because at patch 2, otg->dev is not defined and we need patch 2
> before patch 8 to prevent the build warning. This patch can come only
> after patch 8 where we add otg->dev.
> 

Acked-by: Peter Chen <peter.chen@nxp.com>

-- 

Best Regards,
Peter Chen
