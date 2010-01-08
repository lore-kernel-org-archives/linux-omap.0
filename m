From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: RE: [PATCH 8/8] DSPBRIDGE: Use _IOxx macro to define ioctls
Date: Fri, 8 Jan 2010 11:19:21 -0600
Message-ID: <27F9C60D11D683428E133F85D2BB4A53042DC952BE@dlee03.ent.ti.com>
References: <1262912461-30151-1-git-send-email-omar.ramirez@ti.com>
 <4B469FA0.8000106@ti.com> <4B46A22D.1010507@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49989 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751408Ab0AHRT3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jan 2010 12:19:29 -0500
In-Reply-To: <4B46A22D.1010507@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, "Guzman Lugo, Fernando" <x0095840@ti.com>, "Ramos Falcon, Ernesto" <ernesto@ti.com>

>From: Menon, Nishanth
>
>Apologies on the spam, but a few points below for preventing a future
>ioctl change:
>
>Menon, Nishanth had written, on 01/07/2010 08:59 PM, the following:
>> Ramirez Luna, Omar had written, on 01/07/2010 07:01 PM, the following:
>>> - Use standard convention to define ioctls.
>please warn in the commit message that this will break compatibility.
>

Will do

>>> - Removed runtime check for ioctl matching table number.
>>> - Added __deprectaed marker to functions that are not used anymore.
>generic idea:
>  	if (cmd < ARRAY_SIZE(WCD_cmdTable)) {
>  		/* make the fxn call via the cmd table */
>  		*pResult = (*WCD_cmdTable[cmd].fxn) (args, pr_ctxt);
>if you convert this into:
>  	if (!WCD_cmdTable[cmd].fxn)
>		return -EINVAL;
>  	/* make the fxn call via the cmd table */
>  	*pResult = (*WCD_cmdTable[cmd].fxn) (args, pr_ctxt);
>you'd make deprecation of a previously defined ioctl easy -> just NULL
>and remove the function  in the array and remove it and it's unused
>helper functions.. :)..

Problem comes if you are expecting some status value from that function

>
>
>one generic question - I did not see an features/ioctls supported around
>- having not dug enough, how does the userspace know if the bridge uses
>the new ioctls/old ioctls?

Patch will be sent to userspace repository on dev.omapzoom.org... the idea is to support this set of ioctls from now on... overall I don't think I got your question

[snip]

- omar
