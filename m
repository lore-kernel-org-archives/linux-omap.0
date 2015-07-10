From: Li Jun <b47624-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH v3 02/11] usb: otg-fsm: support multiple instances
Date: Fri, 10 Jul 2015 16:06:43 +0800
Message-ID: <20150710080642.GB14729@shlinux2>
References: <1436350777-28056-1-git-send-email-rogerq@ti.com>
 <1436350777-28056-3-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1436350777-28056-3-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, Jul 08, 2015 at 01:19:28PM +0300, Roger Quadros wrote:
> Move the state_changed variable into struct otg_fsm
> so that we can support multiple instances.
> 
I am not sure if multiple instances may happen since OTG protocol requires
only one OTG port can be equipped on OTG device.

Li Jun
 
> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/usb/common/usb-otg-fsm.c | 10 ++++------
>  include/linux/usb/otg-fsm.h      |  1 +
>  2 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/common/usb-otg-fsm.c b/drivers/usb/common/usb-otg-fsm.c
> index 61d538a..42c6376 100644
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
> @@ -123,7 +121,7 @@ static void otg_leave_state(struct otg_fsm *fsm, enum usb_otg_state old_state)
>  /* Called when entering a state */
>  static int otg_set_state(struct otg_fsm *fsm, enum usb_otg_state new_state)
>  {
> -	state_changed = 1;
> +	fsm->state_changed = 1;
>  	if (fsm->otg->state == new_state)
>  		return 0;

"fsm->state_changed = 1;" should be put here, I think.

Li Jun

>  	VDBG("Set state: %s\n", usb_otg_state_string(new_state));
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
> index ca508c2..243274f 100644
> --- a/include/linux/usb/otg-fsm.h
> +++ b/include/linux/usb/otg-fsm.h
> @@ -194,6 +194,7 @@ struct otg_fsm {
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
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
