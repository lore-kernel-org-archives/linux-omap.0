From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v3 10/11] usb: otg: Add dual-role device (DRD) support
Date: Mon, 27 Jul 2015 12:31:48 +0300
Message-ID: <55B5FA84.1040508@ti.com>
References: <1436350777-28056-1-git-send-email-rogerq@ti.com> <1436350777-28056-11-git-send-email-rogerq@ti.com> <20150717090212.GC4515@shlinux2> <55A8DD30.5030407@ti.com> <20150720012308.GB4584@shlinux2>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150720012308.GB4584@shlinux2>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Chen <peter.chen@freescale.com>
Cc: Li Jun <b47624@freescale.com>, stern@rowland.harvard.edu, balbi@ti.com, gregkh@linuxfoundation.org, dan.j.williams@intel.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, tony@atomide.com, Joao.Pinto@synopsys.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 20/07/15 04:23, Peter Chen wrote:
> On Fri, Jul 17, 2015 at 01:47:12PM +0300, Roger Quadros wrote:
>>>> + * DRD mode hardware Inputs
>>>> + *
>>>> + * @id:		TRUE for B-device, FALSE for A-device.
>>>> + * @vbus:	VBUS voltage in regulation.
>>>> + *
>>>>   * OTG hardware Inputs
>>>>   *
>>>>   *	Common inputs for A and B device
>>>> @@ -122,7 +127,8 @@ enum otg_fsm_timer {
>>>>   */
>>>>  struct otg_fsm {
>>>>  	/* Input */
>>>> -	int id;
>>>> +	int id;			/* DRD + OTG */
>>>> +	int vbus;		/* DRD only */
>>>
>>> Existing b_sess_vld can be also used for drd only case, no need create
>>> a new flag.
>>
>> b_sess_vld is a bit confusing to people not familiar with OTG.
>> My suggestion is to use dedicated 'vbus' flag for DRD case
>> for simplicity.
>>
> 
> Since OTG DRD is the subset in OTG FSM (FSM, data structure, APIs, etc),
> I agree with Jun to reuse existing variables, and we can add some comments
> for b_sess_vld if needed.

OK then. I'll get rid of vbus and use b_sess_vld.

cheers,
-roger

> 
> 
>>>
>>>>  	int adp_change;
>>>>  	int power_up;
>>>>  	int a_srp_det;
>>
