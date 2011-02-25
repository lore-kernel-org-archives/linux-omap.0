From: Hema Kalliguddi <hemahk-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 0/5] usb: musb: Power management support
Date: Fri, 25 Feb 2011 15:56:46 +0530
Message-ID: <875afd9a6c1e7ccc61c7ff025fd57588@mail.gmail.com>
References: <1298628663-27650-1-git-send-email-hemahk@ti.com> <20110225102112.GC4190@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110225102112.GC4190-UiBtZHVXSwEVvW8u9ZQWYwjfymiNCTlR@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Felipe,

>-----Original Message-----
>From: Felipe Balbi [mailto:balbi-l0cyMroinI0@public.gmane.org]
>Sent: Friday, February 25, 2011 3:51 PM
>To: Hema HK
>Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>Subject: Re: [PATCH 0/5] usb: musb: Power management support
>
>On Fri, Feb 25, 2011 at 03:40:58PM +0530, Hema HK wrote:
>> This patch series supports the retention and offmode support in the
>> idle path for musb driver using runtime pm APIs.
>>
>> This is restricted to support offmode and retention only
>when device not
>> connected.When device/cable connected with gadget driver
>loaded, configured
>> to no idle/standby which will not allow the core transition
>to retention
>> or off.
>>
>> There is no context save/restore done by hardware for musb in OMAP3
>> and OMAP4,driver has to take care of saving and restoring the context
>> during offmode.
>>
>> Musb has a requirement of configuring sysconfig register to force
>> idle/standby mode and set the ENABLE_FORCE bit in module
>STANDBY register
>> for retention and offmode support.
>>
>> Runtime pm and hwmod frameworks will take care of
>configuring to force
>> idle/standby when pm_runtime_put_sync is called and back to no
>> idle/standby when pm_runeime_get_sync is called.
>>
>> Compile, boot tested and also tested the retention in the
>idle path on
>> OMAP3630Zoom3. And tested the global suspend/resume with
>offmode enabled.
>> Usb basic functionality tested on OMAP4430SDP.
>>
>> There is some problem with idle path offmode in mainline, I
>could not test
>> with offmode. But I have tested this patch with resetting
>the controller
>> in the idle path when wakeup from retention just to make
>sure that the
>> context is lost, and restore path is working fine.
>
>please base this off of my for-next branch
>
I tried to rebase and found that my hardware mod patches are not
in for-next branch. So there will be some conflicts for patch 4 and 5.
Is there any branch in which you have all the usb and platform changes
merged?

Regards,
Hema
>--
>balbi
>
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
