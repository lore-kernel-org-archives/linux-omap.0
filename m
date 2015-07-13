From: Peter Chen <peter.chen@freescale.com>
Subject: Re: [PATCH v3 01/11] usb: otg-fsm: Add documentation for struct
 otg_fsm
Date: Mon, 13 Jul 2015 09:21:26 +0800
Message-ID: <20150713012109.GC19248@shlinux2>
References: <1436350777-28056-1-git-send-email-rogerq@ti.com>
 <1436350777-28056-2-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1436350777-28056-2-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: stern@rowland.harvard.edu, balbi@ti.com, gregkh@linuxfoundation.org, dan.j.williams@intel.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, tony@atomide.com, Joao.Pinto@synopsys.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Jul 08, 2015 at 01:19:27PM +0300, Roger Quadros wrote:
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
>  include/linux/usb/otg-fsm.h | 89 +++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 82 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/usb/otg-fsm.h b/include/linux/usb/otg-fsm.h
> index f728f18..ca508c2 100644
> --- a/include/linux/usb/otg-fsm.h
> +++ b/include/linux/usb/otg-fsm.h
> @@ -59,37 +59,112 @@ enum otg_fsm_timer {
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
> + * @a_bus_suspend: TRUE when the B-device detects that the A-device has put the
> + *		bus into suspend
> + * @a_conn:	TRUE if the B-device detects a connection from the A-device
> + * @b_se0_srp:	TRUE when the line has been at SE0 for more than the minimum
> + *		time before generating SRP
> + * @b_ssend_srp: TRUE when the VBUS has been below VOTG_SESS_VLD for more than
> + *		 the minimum time before generating SRP
> + * @b_sess_vld:	TRUE when the B-device detects that the voltage on VBUS is
> + *		above VOTG_SESS_VLD
> + * @test_device: TRUE when the B-device switches to B-Host and detects an OTG
> + *		test device. This must be set by host/hub driver
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
> + *	Auxilary inputs (OTG v1.3 only. Obsolete now.)
> + * @a_sess_vld:	TRUE if the A-device detects that VBUS is above VA_SESS_VLD
> + * @b_bus_suspend: TRUE when the A-device detects that the B-device has put
> + *		the bus into suspend
> + * @b_bus_resume: TRUE when the A-device detects that the B-device is signaling
> + *		 resume on the bus
> + *
> + * OTG Output status. Read only for users. updated by otg_ops() helpers

updated by OTG FSM helpers defined in this file

Only one tiny comment, others are ok.

Acked-by: Peter Chen <peter.chen@freescale.com>

-- 

Best Regards,
Peter Chen
