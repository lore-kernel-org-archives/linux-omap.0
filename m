From: Bharathraj Nagaraju <bharathraj.nagaraju@sasken.com>
Subject: RE: Reg: USB: ehci-omap: Suspend the controller during idle.
Date: Mon, 26 Aug 2013 12:32:21 +0000
Message-ID: <88EA9DA16B788648836D263C936F15C2D91E@exgmbxfz02.sasken.com>
References: <8D86EEFC18AF0D43A2B8E0ABFA8B88A17B16B9455E@EXGMBX01.sasken.com>,<520107C5.20803@ti.com>
 <88EA9DA16B788648836D263C936F15C2D8FA@exgmbxfz02.sasken.com>,<521B3EDE.9010209@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mta-blr1.sasken.com ([203.200.200.72]:50033 "EHLO
	mta-blr1.sasken.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751835Ab3HZMcb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Aug 2013 08:32:31 -0400
In-Reply-To: <521B3EDE.9010209@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>

On 08/26/2013 02:29 PM, Bharathraj Nagaraju wrote:
> Dear All,
>
> With continuation to below mail, our client requirement is pushing us to implement the EHCI runtime suspend/resume.
>
> I have implemented EHCI runtime suspend/resume using timer concept,Please find the below design and attached patch for the same.
>
> Design Approach:
>      - A timer of 10sec is scheduled.
>      - During EHCI transaction (tx/rx), this timer is reset.
>        If the EHCI clocks are switched off, it is switched on before any actual
>        transaction.
>      - If there are no transaction on EHCI for >10secs, the timer callback is invoked.
>      - EHCI clocks are disabled in the timer expire function.

>>    Why are you using your own timer? USB core already supports runtime PM which maintains
>>   its own autosuspend timer. you just need to implement the runtime PM driver ops.
>>    (i.e. .runtime_suspend and .runtime_resume)

In our current kernel code(kernel 3.0.31) clocks are enabled when port get connected and disabled during disconnect, hence we need to implement with my own timer or else we have to change back port kernel 3.8 above code.

>
> NOTE : Runtime remote wake up feature need to be implement.

>>  Did you try the patches I pointed to you earlier? They already work with remote wakeup.

Not yet, i will try once this timer implementation is done. 


>
> With the above approach the ECHI is suspended,if there are no transaction for > 10secs,during next transaction
> i am enabling the clocks and resuming the EHCI controller, but we are getting below errors and its not working properly
>
> [   66.986175] catalina_wwan_ctrl_attr_wwan_on_show: wwan_on status = 1
> [   66.993743] ehci-omap ehci-omap.0: ehci_omap_bus_resume
> [   66.999542] ehci-omap ehci-omap.0: resume root hub
> [   67.024475] ehci_bus_resume: port_status[2]=0x501000, PORT_SUSPEND=0
> [   67.031311] ehci_bus_resume: port_status[1]=0x501000, PORT_SUSPEND=0
> [   67.038238] ehci_bus_resume: port_status[0]=0x601885, PORT_SUSPEND=128
> [   67.079223] ehci-omap ehci-omap.0: detected XactErr len 0/10 retry 1
> [   67.086090] ehci-omap ehci-omap.0: detected XactErr len 0/512 retry 1
> [   67.093139] ehci-omap ehci-omap.0: detected XactErr len 0/10 retry 2
> [   67.099975] ehci-omap ehci-omap.0: detected XactErr len 0/512 retry 2
> [   67.106994] ehci-omap ehci-omap.0: detected XactErr len 0/10 retry 3
> [   67.113830] ehci-omap ehci-omap.0: detected XactErr len 0/512 retry 3
> [   67.120819] ehci-omap ehci-omap.0: detected XactErr len 0/10 retry 4
>
> Can you please guide me why we are getting above errors.

>>> These type of errors usually occur if all required clocks for the controller are not enabled.

Thanks i will look into this.

Cheers Bharath
________________________________________
From: Roger Quadros [rogerq@ti.com]
Sent: Monday, August 26, 2013 5:11 PM
To: Bharathraj Nagaraju
Cc: linux-omap@vger.kernel.org; linux-usb@vger.kernel.org
Subject: Re: Reg: USB: ehci-omap: Suspend the controller during idle.

Hi Bharat,

On 08/26/2013 02:29 PM, Bharathraj Nagaraju wrote:
> Dear All,
>
> With continuation to below mail, our client requirement is pushing us to implement the EHCI runtime suspend/resume.
>
> I have implemented EHCI runtime suspend/resume using timer concept,Please find the below design and attached patch for the same.
>
> Design Approach:
>      - A timer of 10sec is scheduled.
>      - During EHCI transaction (tx/rx), this timer is reset.
>        If the EHCI clocks are switched off, it is switched on before any actual
>        transaction.
>      - If there are no transaction on EHCI for >10secs, the timer callback is invoked.
>      - EHCI clocks are disabled in the timer expire function.

Why are you using your own timer? USB core already supports runtime PM which maintains
its own autosuspend timer. you just need to implement the runtime PM driver ops.
(i.e. .runtime_suspend and .runtime_resume)

>
> NOTE : Runtime remote wake up feature need to be implement.

Did you try the patches I pointed to you earlier? They already work with remote wakeup.

>
> With the above approach the ECHI is suspended,if there are no transaction for > 10secs,during next transaction
> i am enabling the clocks and resuming the EHCI controller, but we are getting below errors and its not working properly
>
> [   66.986175] catalina_wwan_ctrl_attr_wwan_on_show: wwan_on status = 1
> [   66.993743] ehci-omap ehci-omap.0: ehci_omap_bus_resume
> [   66.999542] ehci-omap ehci-omap.0: resume root hub
> [   67.024475] ehci_bus_resume: port_status[2]=0x501000, PORT_SUSPEND=0
> [   67.031311] ehci_bus_resume: port_status[1]=0x501000, PORT_SUSPEND=0
> [   67.038238] ehci_bus_resume: port_status[0]=0x601885, PORT_SUSPEND=128
> [   67.079223] ehci-omap ehci-omap.0: detected XactErr len 0/10 retry 1
> [   67.086090] ehci-omap ehci-omap.0: detected XactErr len 0/512 retry 1
> [   67.093139] ehci-omap ehci-omap.0: detected XactErr len 0/10 retry 2
> [   67.099975] ehci-omap ehci-omap.0: detected XactErr len 0/512 retry 2
> [   67.106994] ehci-omap ehci-omap.0: detected XactErr len 0/10 retry 3
> [   67.113830] ehci-omap ehci-omap.0: detected XactErr len 0/512 retry 3
> [   67.120819] ehci-omap ehci-omap.0: detected XactErr len 0/10 retry 4
>
> Can you please guide me why we are getting above errors.

These type of errors usually occur if all required clocks for the controller are not enabled.

cheers,
-roger

>
> ________________________________________
> From: Roger Quadros [rogerq@ti.com]
> Sent: Tuesday, August 06, 2013 7:57 PM
> To: Bharathraj Nagaraju
> Cc: linux-omap@vger.kernel.org; linux-usb@vger.kernel.org; Kevin Hilman; Alan Stern
> Subject: Re: Reg: USB: ehci-omap: Suspend the controller during idle.
>
> Hi,
>
> On 08/06/2013 03:55 PM, Bharathraj Nagaraju wrote:
>>   Dear All,
>>
>>   We are working on omap4470 based device,kernel-3.0.31 is running on this.
>>   In our device modem is connected to OMAP4470 using USB EHCI.
>>
>>   In our current kernel code, clocks are enabled when ports get connected
>>   and disabled during disconnect.Due to this current consumption is more in idle use case.
>>
>>   I have tried to put the host in smart idle/standby mode,due to erratas around Host doesn't allow us
>>   use smart idle/standby capabilities.
>>
>>   1) i571: USB host EHCI may stall when entering smart-standby mode
>>   2) i660: USBHOST Configured In Smart-Idle Can Lead To a Deadlock
>>
>>   we are thinking to implement USB EHCI runtime suspend/resume feature.
>>
>>   In kernel-3.0.31 architecture the usbcore driver is parent of ehci and ohci drivers.
>>   The ehci and ohci drivers call the pm_runtime_get_sync and pm_runtime_put_sync of parent device usbhs core.
>>
>>   From the ehci-omap driver what i can see only partial implementation of runtime PM.
>>   what i mean is that runtime PM methods are used only during the normal suspend path
>>   and when nothing is connected to ports(modem disconnected in our case).
>>
>>   I am thinking to change the ehci driver code, could claver enough to use runtime PM
>>   to disable the hardware when modem is connected and the system is in idle state.
>>
>>   Kindly guide me how can i go about this.
>>
>>   Let me know if you need further clarification from me on this.
>>
>>   Thanks for spending your valuable time .......:)
>
>
> The problem with OMAP EHCI controller is that it needs to rely on IO Daisy chain mechanism
> to wake up when it is suspended. Without that, we can't really put the controller in to runtime
> suspend, else we will not be able to detect a new device connect.
>
> IO daisy chaining is still not supported in mainline. One approach had been posted [1] and it works
> but it is still in transition.
>
> I've made some patches [2] which implement USB runtime suspend with remote wakeup working
> for OMAP3 beagle-xm board. This depends on [1]. It shouldn't be hard to get it working on OMAP4.
>
> [1] http://article.gmane.org/gmane.linux.ports.arm.omap/101105
> [2] http://article.gmane.org/gmane.linux.ports.arm.kernel/251250
>
> cheers,
> -roger
>
>
> ________________________________
>
> SASKEN BUSINESS DISCLAIMER: This message may contain confidential, proprietary or legally privileged information. In case you are not the original intended Recipient of the message, you must not, directly or indirectly, use, disclose, distribute, print, or copy any part of this message and you are requested to delete it and inform the sender. Any views expressed in this message are those of the individual sender unless otherwise stated. Nothing contained in this message shall be construed as an offer or acceptance of any offer by Sasken Communication Technologies Limited ("Sasken") unless sent with that express intent and with due authority of Sasken. Sasken has taken enough precautions to prevent the spread of viruses. However the company accepts no liability for any damage caused by an
 y virus transmitted by this email.
> Read Disclaimer at http://www.sasken.com/extras/mail_disclaimer.html
>

