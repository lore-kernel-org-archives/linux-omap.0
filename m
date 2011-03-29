From: Hema Kalliguddi <hemahk@ti.com>
Subject: RE: [PATCH 1/2 v2] usb: otg: OMAP4430: Fixing the omap4430_phy_init function
Date: Tue, 29 Mar 2011 11:43:31 +0530
Message-ID: <4369479157892165533add3d883a79a7@mail.gmail.com>
References: <1300966722-10955-1-git-send-email-hemahk@ti.com> <20110328212015.GH30616@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:35553 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751727Ab1C2GNl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 Mar 2011 02:13:41 -0400
In-Reply-To: <20110328212015.GH30616@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

Hi,

>-----Original Message-----
>From: Tony Lindgren [mailto:tony@atomide.com]
>Sent: Tuesday, March 29, 2011 2:50 AM
>To: Hema HK
>Cc: linux-usb@vger.kernel.org; linux-omap@vger.kernel.org
>Subject: Re: [PATCH 1/2 v2] usb: otg: OMAP4430: Fixing the
>omap4430_phy_init function
>
>* Hema HK <hemahk@ti.com> [110324 04:36]:
>> omap4430_phy_init() function can be called with no device pointer,
>> to powerdown the PHY during board init when USB is disabled.
>> Fix the function accordingly.
>
>This should no longer be needed after merge commit
>0df0914d414a504b975f3cc66ace0c16ef55b7f3.

I did not get how the above commit help to fix it.

This fix is required in the USB disabled case.
When CONFIG_USB is not enabled, then the device is not built
but, there is a need to powerdown the PHY for core domain transition to
ret and offmode.

Regards,
Hema
>
>Tony
>
