From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v2] ARM: OMAP: Power on EHCI, serial, camera and DVI on
 beagleboard-xM
Date: Sun, 19 Dec 2010 09:22:33 -0600
Message-ID: <4D0E2339.40401@ti.com>
References: <1291725639-86397-1-git-send-email-koen@beagleboard.org> <1292769735-54159-1-git-send-email-koen@dominion.thruhere.net> <4D0E1B07.2000703@ti.com> <24FA44A2-FF60-4DA5-B672-66F501E297F6@dominion.thruhere.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:39006 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932256Ab0LSPW4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 19 Dec 2010 10:22:56 -0500
Received: by yxe42 with SMTP id 42so1023433yxe.9
        for <linux-omap@vger.kernel.org>; Sun, 19 Dec 2010 07:22:55 -0800 (PST)
In-Reply-To: <24FA44A2-FF60-4DA5-B672-66F501E297F6@dominion.thruhere.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <koen@dominion.thruhere.net>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

Koen Kooi wrote, on 12/19/2010 08:56 AM:
>
> Op 19 dec 2010, om 15:47 heeft Nishanth Menon het volgende geschreven:
>
>> Koen Kooi wrote, on 12/19/2010 08:42 AM:
>> $subject - should'nt you be doing this in separate patches? easier to track with git bisect at a later date than a whole sale change?
>
> Is that really needed?
it is usually recommended to keep each separate functionality 
introduced/fixed independent of the other.

>
>> btw, why are we enabling camera here? should'nt that be done in camera's probe function? no?
>
> On P7/P8 it's the camera, but on A2 and above it's the LDO that powers the TFP410, so if you want to have output on DVI you need to turn it on.
 >I'm not sure if it should be part of the DVI init since it has 
different functions on different board revisions.
P7/P8 were not production Beagles if my memory serves me right.. DVI 
init makes more sense to me.

-- 
Regards,
Nishanth Menon
