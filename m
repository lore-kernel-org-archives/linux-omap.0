From: Peter Chen <peter.chen@freescale.com>
Subject: Re: [RFC][PATCH v2 01/13] usb: otg-fsm: Add documentation for struct
 otg_fsm
Date: Thu, 16 Apr 2015 19:32:32 +0800
Message-ID: <20150416113231.GA3181@shlinux2>
References: <1429008120-5395-1-git-send-email-rogerq@ti.com>
 <1429008120-5395-2-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1429008120-5395-2-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: gregkh@linuxfoundation.org, balbi@ti.com, stern@rowland.harvard.edu, dan.j.williams@intel.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, tony@atomide.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Apr 14, 2015 at 01:41:48PM +0300, Roger Quadros wrote:
> struct otg_fsm is the interface to the OTG state machine.
> 
> Document the input, output and internal state variables.
> Definations are taken from Table 7-2 and Table 7-4 of
> the USB OTG & EH Specification Rev.2.0
> 
> Re-arrange some of the members as per use case for more
> clarity.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  include/linux/usb/otg-fsm.h | 80 +++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 73 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/usb/otg-fsm.h b/include/linux/usb/otg-fsm.h
> index b6ba1bf..c5b74c5 100644
> --- a/include/linux/usb/otg-fsm.h
> +++ b/include/linux/usb/otg-fsm.h
> @@ -57,37 +57,103 @@ enum otg_fsm_timer {
>  	NUM_OTG_FSM_TIMERS,
>  };
>  
> -/* OTG state machine according to the OTG spec */
> +/**
> + * struct otg_fsm - OTG state machine according to the OTG spec
> + *
> + * OTG hardware Inputs
> + *
> + *	Common inputs for A and B device

What's the intention you leave two spaces at above line?

> + * @id:		TRUE for B-device, FALSE for A-device.
> + * @adp_change: TRUE when current ADP measurement (n) value, compared to the
> + *		ADP measurement taken at n-2, differs by more than CADP_THR
> + * @power_up:	TRUE when the OTG device first powers up its USB system and
> + *		ADP measurement taken if ADP capable
> + *
> + *	A-Device state inputs
> + * @a_srp_det:	TRUE if the A-device detects SRP
> + * @a_vbus_vld:	TRUE when VBUS voltage is in regulation
> + * @b_conn:	TRUE if the A-device detects connection from the B-device
> + * @a_bus_resume: TRUE when the B-device detects that the A-device is signaling
> + *		  a resume (K state)
> + *	B-Device state inputs
> + * @a_bus_suspend: TRUE when the B-device detects that the A-device has put the bus into suspend
> + * @a_conn:	TRUE if the B-device detects a connection from the A-device
> + * @b_se0_srp:	TRUE when the line has been at SE0 for more than the minimum
> + *		time before generating SRP
> + * @b_ssend_srp: TRUE when the VBUS has been below VOTG_SESS_VLD for more than
> + *		 the minimum time before generating SRP
> + * @b_sess_vld:	TRUE when the B-device detects that the voltage on VBUS is
> + *		above VOTG_SESS_VLD
> + * @test_device: TRUE when the B-device switches to B-Host and detects an OTG test device
> + *		 FIXME: must be set by host/hub driver

Yes, according to pid/vid pair.

> + *
> + *	Application inputs (A-Device)
> + * @a_bus_drop:	TRUE when A-device application needs to power down the bus
> + * @a_bus_req:	TRUE when A-device application wants to use the bus.
> + *		FALSE to suspend the bus
> + *
> + *	Application inputs (B-Device)
> + * @b_bus_req:	TRUE during the time that the Application running on the
> + *		B-device wants to use the bus
> + *
> + *	Auxilary inputs
> + * @a_sess_vld:		??

See OTG spec 1.3, and obsolete now.

> + * @b_bus_suspend:	??
> + * @b_bus_resume:	??

They are used at current otg fsm, just for B-host.

> + *
> + * OTG Output status. Read only for users. updated by otg_ops() helpers
> + *
> + *	Outputs for Both A and B device
> + * @drv_vbus:	TRUE when A-device is driving VBUS
> + * @loc_conn:	TRUE when the local device has signaled that it is connected to the bus
> + * @loc_sof:	TRUE when the local device is generating activity on the bus
> + * @adp_prb:	TRUE when the local device is in the process of doing ADP probing
> + *
> + *	Outputs for B-device state
> + * @adp_sns:	TRUE when the B-device is in the process of carrying out ADP sensing
> + * @data_pulse: TRUE when the B-device is performing data line pulsing
> + *
> + * Internal Variables
> + *
> + * a_set_b_hnp_en: TRUE when the A-device has successfully set the b_hnp_enable bit in the B-device.
> + *		   FIXME: OTG fsm uses otg->host->b_hnp_enable instead

a_set_b_hnp_en is for otg 2.0 and it should instead of
otg->host->b_hnp_enable at otg fsm.

> + * b_srp_done:	TRUE when the B-device has completed initiating SRP
> + * b_hnp_enable: TRUE when the B-device has accepted the SetFeature(b_hnp_enable) B-device
> + *		 FIXME: OTG fsm uses otg->gadget->b_hnp_enable instead

Yes

> + * a_clr_err:	Asserted (by application ?) to clear a_vbus_err due to an overcurrent condition
> + *		and causes the A-device to transition to a_wait_vfall
> + */
>  struct otg_fsm {
>  	/* Input */
>  	int id;
>  	int adp_change;
>  	int power_up;
> -	int test_device;
> -	int a_bus_drop;
> -	int a_bus_req;
>  	int a_srp_det;
>  	int a_vbus_vld;
>  	int b_conn;
>  	int a_bus_resume;
>  	int a_bus_suspend;
>  	int a_conn;
> -	int b_bus_req;
>  	int b_se0_srp;
>  	int b_ssend_srp;
>  	int b_sess_vld;
> +	int test_device;
> +	int a_bus_drop;
> +	int a_bus_req;
> +	int b_bus_req;
> +
>  	/* Auxilary inputs */
>  	int a_sess_vld;
>  	int b_bus_resume;
>  	int b_bus_suspend;
>  
>  	/* Output */
> -	int data_pulse;
>  	int drv_vbus;
>  	int loc_conn;
>  	int loc_sof;
>  	int adp_prb;
>  	int adp_sns;
> +	int data_pulse;
>  
>  	/* Internal variables */
>  	int a_set_b_hnp_en;
> @@ -95,7 +161,7 @@ struct otg_fsm {
>  	int b_hnp_enable;
>  	int a_clr_err;
>  
> -	/* Informative variables */
> +	/* Informative variables. All unused as of now */
>  	int a_bus_drop_inf;
>  	int a_bus_req_inf;
>  	int a_clr_err_inf;
> -- 
> 2.1.0
> 

-- 

Best Regards,
Peter Chen
