From: Hema Kalliguddi <hemahk@ti.com>
Subject: RE: [PATCH 1/2 v2] usb: otg: OMAP4430: Fixing the omap4430_phy_init function
Date: Thu, 31 Mar 2011 12:33:51 +0530
Message-ID: <3f372a946644cc29673bbddab67e4417@mail.gmail.com>
References: <1300966722-10955-1-git-send-email-hemahk@ti.com>
 <20110328212015.GH30616@atomide.com> <4369479157892165533add3d883a79a7@mail.gmail.com>
 <20110330184637.GG18334@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:32899 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752793Ab1CaHEB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 31 Mar 2011 03:04:01 -0400
In-Reply-To: <20110330184637.GG18334@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>

Hi,

>-----Original Message-----
>From: Tony Lindgren [mailto:tony@atomide.com]
>Sent: Thursday, March 31, 2011 12:17 AM
>To: Hema Kalliguddi
>Cc: linux-usb@vger.kernel.org; linux-omap@vger.kernel.org; Felipe Balbi
>Subject: Re: [PATCH 1/2 v2] usb: otg: OMAP4430: Fixing the
>omap4430_phy_init function
>
>* Hema Kalliguddi <hemahk@ti.com> [110328 23:11]:
>> Hi,
>>
>> >-----Original Message-----
>> >From: Tony Lindgren [mailto:tony@atomide.com]
>> >Sent: Tuesday, March 29, 2011 2:50 AM
>> >To: Hema HK
>> >Cc: linux-usb@vger.kernel.org; linux-omap@vger.kernel.org
>> >Subject: Re: [PATCH 1/2 v2] usb: otg: OMAP4430: Fixing the
>> >omap4430_phy_init function
>> >
>> >* Hema HK <hemahk@ti.com> [110324 04:36]:
>> >> omap4430_phy_init() function can be called with no device pointer,
>> >> to powerdown the PHY during board init when USB is disabled.
>> >> Fix the function accordingly.
>> >
>> >This should no longer be needed after merge commit
>> >0df0914d414a504b975f3cc66ace0c16ef55b7f3.
>>
>> I did not get how the above commit help to fix it.
>
>Ah it's not there. Well IMHO omap4430_phy_init(dev) should
>not get called before dev is initialized in usb_musb_init.
>
>So it should get called only after the get_device(dev) call.

Right. I think this was merge issue. When USB is enabled, it should be
ideally called only after the device build.

But this patch required for the case when USB is not not enabled,
there will not be a device built at all. But need to powerdown the PHY.

Regards,
Hema




>
>Regards,
>
>Tony
>
>
