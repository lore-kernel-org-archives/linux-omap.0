From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 0/2] power button repeat input events
Date: Fri, 11 Mar 2011 22:25:27 +0530
Message-ID: <4D7A53FF.4060004@ti.com>
References: <1299861450-19914-1-git-send-email-ext-denis.2.karpov@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:36304 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751019Ab1CKQzx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Mar 2011 11:55:53 -0500
Received: by fxm15 with SMTP id 15so1091880fxm.3
        for <linux-omap@vger.kernel.org>; Fri, 11 Mar 2011 08:55:51 -0800 (PST)
In-Reply-To: <1299861450-19914-1-git-send-email-ext-denis.2.karpov@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Denis Karpov <ext-denis.2.karpov@nokia.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org

Denis Karpov wrote, on 03/11/2011 10:07 PM:
> Hi,
>
> this patchset adds optional generation of repeat input events for
> twl4030 power button. It adds optional platform data for
> twl4030-pwrbutton and initializes it for RX51/N900 (default
> behavior kept - repeated input events disabled).
>
> We are working on an OMAP3 with TWL5031 MFD. In one of the use
> scenarios userspace wants to receive repeated input events from
> long press of power button.
>

dumb question - is'nt this a userspace responsibility as far as power 
button is concerned? what is the benefit of providing repeat events like 
a generic keypad for the power button?

-- 
Regards,
Nishanth Menon
