From: Peter Chen <peter.chen@freescale.com>
Subject: Re: [PATCH v4 02/13] usb: otg-fsm: support multiple instances
Date: Sun, 6 Sep 2015 13:52:26 +0800
Message-ID: <20150906055225.GD4914@shlinux2>
References: <1440422484-4737-1-git-send-email-rogerq@ti.com>
 <1440422484-4737-3-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1440422484-4737-3-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: stern@rowland.harvard.edu, balbi@ti.com, gregkh@linuxfoundation.org, dan.j.williams@intel.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, tony@atomide.com, Joao.Pinto@synopsys.com, abrestic@chromium.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, Aug 24, 2015 at 04:21:13PM +0300, Roger Quadros wrote:
> Move the state_changed variable into struct otg_fsm
> so that we can support multiple instances.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  drivers/usb/common/usb-otg-fsm.c | 10 ++++------
>  include/linux/usb/otg-fsm.h      |  1 +
>  2 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/common/usb-otg-fsm.c b/drivers/usb/common/usb-otg-fsm.c
> index 61d538a..32862a4 100644
> --- a/drivers/usb/common/usb-otg-fsm.c
> +++ b/drivers/usb/common/usb-otg-fsm.c
> @@ -61,8 +61,6 @@ static int otg_set_protocol(struct otg_fsm *fsm, int protocol)
>  	return 0;
>  }
>  
> -static int state_changed;
> -
>  /* Called when leaving a state.  Do state clean up jobs here */
>  static void otg_leave_state(struct otg_fsm *fsm, enum usb_otg_state old_state)
>  {
> @@ -123,7 +121,6 @@ static void otg_leave_state(struct otg_fsm *fsm, enum usb_otg_state old_state)
>  /* Called when entering a state */
>  static int otg_set_state(struct otg_fsm *fsm, enum usb_otg_state new_state)
>  {
> -	state_changed = 1;
>  	if (fsm->otg->state == new_state)
>  		return 0;
>  	VDBG("Set state: %s\n", usb_otg_state_string(new_state));
> @@ -237,6 +234,7 @@ static int otg_set_state(struct otg_fsm *fsm, enum usb_otg_state new_state)
>  	}
>  
>  	fsm->otg->state = new_state;
> +	fsm->state_changed = 1;
>  	return 0;
>  }
>  
> @@ -248,7 +246,7 @@ int otg_statemachine(struct otg_fsm *fsm)
>  	mutex_lock(&fsm->lock);
>  
>  	state = fsm->otg->state;
> -	state_changed = 0;
> +	fsm->state_changed = 0;
>  	/* State machine state change judgement */
>  
>  	switch (state) {
> @@ -361,7 +359,7 @@ int otg_statemachine(struct otg_fsm *fsm)
>  	}
>  	mutex_unlock(&fsm->lock);
>  
> -	VDBG("quit statemachine, changed = %d\n", state_changed);
> -	return state_changed;
> +	VDBG("quit statemachine, changed = %d\n", fsm->state_changed);
> +	return fsm->state_changed;
>  }
>  EXPORT_SYMBOL_GPL(otg_statemachine);
> diff --git a/include/linux/usb/otg-fsm.h b/include/linux/usb/otg-fsm.h
> index fc5b4d9..20c8219 100644
> --- a/include/linux/usb/otg-fsm.h
> +++ b/include/linux/usb/otg-fsm.h
> @@ -195,6 +195,7 @@ struct otg_fsm {
>  	/* Current usb protocol used: 0:undefine; 1:host; 2:client */
>  	int protocol;
>  	struct mutex lock;
> +	bool state_changed;
>  };
>  
>  struct otg_fsm_ops {
> -- 
> 2.1.4
> 

Acked-by: Peter Chen <peter.chen@freescale.com>

-- 

Best Regards,
Peter Chen
