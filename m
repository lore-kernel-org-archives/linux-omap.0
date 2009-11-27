From: "Hemanth V" <hemanthv@ti.com>
Subject: Re: omap3evm: touchscreen delays on pm branch
Date: Fri, 27 Nov 2009 11:35:23 +0530
Message-ID: <01cd01ca6f27$9c13a020$LocalHost@wipultra793>
References: <B85A65D85D7EB246BE421B3FB0FBB59301DE72D63F@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43186 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751798AbZK0GFW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 Nov 2009 01:05:22 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id nAR65PVu009636
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 27 Nov 2009 00:05:28 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>, linux-omap@vger.kernel.org

----- Original Message ----- 
From: "Premi, Sanjeev" <premi@ti.com>
To: <linux-omap@vger.kernel.org>
Sent: Thursday, November 26, 2009 10:32 PM
Subject: omap3evm: touchscreen delays on pm branch


> Hi,
> 
> I am finding the response of touchscreen on the omap3evm very slow.
> 
> Here is my test:
> On console, I run : watch -n2 "cat /proc/interrupts"
> Then, I tap the touchscreen approximately once per second. However,
> (usually) no interrupts are registered. As I increase the frequency
> of 'taps' more and more interrupts are registered. But still not
> matching exact taps.
> 
> However, when I keep the cpu busy with "cat /dev/zero > /dev/null &"
> each tap is recognized.
> 
> EVM uses GPIO175 for touchscreen. I notice that Zoom2 uses GPIO102.
> Both are not on BANK0.
> 
> Is the behavior same on ZOOM2 as well?

I dont see this problem on Zoom2/Zoom3, I am able to see interrupts being
incremented for every touch.

> 
> Best regards,
> Sanjeev
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
