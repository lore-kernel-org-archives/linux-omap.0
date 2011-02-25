From: Hema Kalliguddi <hemahk@ti.com>
Subject: RE: [PATCH 5/5 v2] usb: musb: OMAP4430: Save/restore the context
Date: Fri, 25 Feb 2011 19:09:39 +0530
Message-ID: <37d1d2ead8135d5088ec75c2c87b0936@mail.gmail.com>
References: <1298640246-21181-1-git-send-email-hemahk@ti.com>
 <1298640246-21181-6-git-send-email-hemahk@ti.com> <20110225133254.GK4190@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:50104 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755923Ab1BYNjl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Feb 2011 08:39:41 -0500
In-Reply-To: <20110225133254.GK4190@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>

 Felipe,

>-----Original Message-----
>From: linux-usb-owner@vger.kernel.org
>[mailto:linux-usb-owner@vger.kernel.org] On Behalf Of Felipe Balbi
>Sent: Friday, February 25, 2011 7:03 PM
>To: Hema HK
>Cc: linux-usb@vger.kernel.org; linux-omap@vger.kernel.org;
>Felipe Balbi; Tony Lindgren; Paul Walmsley
>Subject: Re: [PATCH 5/5 v2] usb: musb: OMAP4430: Save/restore
>the context
>
>On Fri, Feb 25, 2011 at 06:54:06PM +0530, Hema HK wrote:
>> Add the context save restore for the control module register
>> used for OMAP4430 musb with UTMI embedded PHY interface.
>>
>> Signed-off-by: Hema HK <hemahk@ti.com>
>> Cc: Felipe Balbi <balbi@ti.com>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Cc: Paul Walmsley <paul@pwsan.com>
>
>$SUBJECT is mis-leading. It's not related to MUSB, it's related to the
>Internal PHY on OMAP4 ;-)

My bad... :-(...

Regards,
Hema

>
>--
>balbi
>--
>To unsubscribe from this list: send the line "unsubscribe linux-usb" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
