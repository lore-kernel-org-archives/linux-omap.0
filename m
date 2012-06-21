From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] OMAP: USB : Fix the EHCI enumeration and core retention issue
Date: Thu, 21 Jun 2012 12:02:25 -0700
Message-ID: <87fw9o32v2.fsf@ti.com>
References: <1340286132-20634-1-git-send-email-keshava_mgowda@ti.com>
	<CAP05o4KOprVvgJ5aLD2+LLARtspRFkoE0Rob-dtVC7CefO-W2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog137.obsmtp.com ([74.125.149.18]:50918 "EHLO
	na3sys009aog137.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759638Ab2FUTC3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 Jun 2012 15:02:29 -0400
Received: by pbbro2 with SMTP id ro2so3195848pbb.27
        for <linux-omap@vger.kernel.org>; Thu, 21 Jun 2012 12:02:27 -0700 (PDT)
In-Reply-To: <CAP05o4KOprVvgJ5aLD2+LLARtspRFkoE0Rob-dtVC7CefO-W2A@mail.gmail.com>
	(Keshava Munegowda's message of "Thu, 21 Jun 2012 19:13:52 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Cc: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, balbi@ti.com, sameo@linux.intel.com, notasas@gmail.com

"Munegowda, Keshava" <keshava_mgowda@ti.com> writes:

> On Thu, Jun 21, 2012 at 7:12 PM, Keshava Munegowda
> <keshava_mgowda@ti.com> wrote:
>> This commit 354ab8567ae3107a8cbe7228c3181990ba598aac titled
>> "Fix OMAP EHCI suspend/resume failure (i693)" is causing
>> the usb hub and device detection fails in beagle XM
>> causeing NFS not functional. This affects the core retention too.
>> The same commit logic needs to be revisted adhering to hwmod and
>> device tree framework.
>> for now, this commit id 354ab8567ae3107a8cbe7228c3181990ba598aac
>> titled "Fix OMAP EHCI suspend/resume failure (i693)" reverted.
>>
>> This patch is validated on BeagleXM with NFS support over
>> usb ethernet and USB mass storage and other device detection.
>>
>> Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>

[...]

>
> hi kevin
>
> here is pm count log on beagle XM with the above patch:

What are you meaning to show by this log?    

This dump shows that neither PER or CORE are hitting retention in idle.
Which sounds to me like you have not enabled UART runtime suspend:

echo 3000 > /sys/devices/platform/omap_uart.0/power/autosuspend_delay_ms
echo 3000 > /sys/devices/platform/omap_uart.1/power/autosuspend_delay_ms
echo 3000 > /sys/devices/platform/omap_uart.2/power/autosuspend_delay_ms
echo 3000 > /sys/devices/platform/omap_uart.3/power/autosuspend_delay_ms

My test with your patch shows that it fixes the oops during boot, and
doesn't hang during suspend, but that USB host is still preventing CORE
retention during idle (after UART runtime suspend is enabled.)

This happens on 3530/Overo, 3630/Beagle-xM and 3730/Overo

Setting CONFIG_MFD_OMAP_USB_HOST=n allows CORE to hit retention again.

Kevin


>  cat ./debug/pm_debug/count
> usbhost_pwrdm (ON),OFF:0,RET:3,INA:0,ON:4,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
> sgx_pwrdm (OFF),OFF:1,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
> core_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMBANK2-OFF:0
> per_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
> dss_pwrdm (ON),OFF:0,RET:1254,INA:0,ON:1255,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
> cam_pwrdm (RET),OFF:0,RET:1,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
> neon_pwrdm (ON),OFF:0,RET:1254,INA:0,ON:1255,RET-LOGIC-OFF:0
> mpu_pwrdm (ON),OFF:0,RET:1254,INA:0,ON:1255,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
> iva2_pwrdm (RET),OFF:0,RET:1,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMBANK2-OFF:0,RET-MEMBANK3-OFF:0,RET-MEMBANK4-OFF:0
> usbhost_clkdm->usbhost_pwrdm (3)
> sgx_clkdm->sgx_pwrdm (0)
> per_clkdm->per_pwrdm (19)
> cam_clkdm->cam_pwrdm (0)
> dss_clkdm->dss_pwrdm (1)
> core_l4_clkdm->core_pwrdm (25)
> core_l3_clkdm->core_pwrdm (4)
> d2d_clkdm->core_pwrdm (0)
> iva2_clkdm->iva2_pwrdm (0)
> neon_clkdm->neon_pwrdm (0)
> mpu_clkdm->mpu_pwrdm (0)
> prm_clkdm->wkup_pwrdm (0)
> cm_clkdm->core_pwrdm (0)
>
>
> regards
> keshava
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
