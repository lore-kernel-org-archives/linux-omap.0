From: "Girish" <girishsg@ti.com>
Subject: RE: TWL4030 keypad timeout interrupt
Date: Wed, 14 May 2008 14:27:21 +0530
Message-ID: <028f01c8b5a0$87134140$7f8818ac@ent.ti.com>
References: <20080513135417.GL4244@gandalf.research.nokia.com> <3d1886c4eeb5320b5d443df10b6bed87@felipebalbi.com> <023e01c8b580$8242db00$7f8818ac@ent.ti.com> <20080514081629.GA17908@gandalf.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49895 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752903AbYENI6Z (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 May 2008 04:58:25 -0400
In-Reply-To: <20080514081629.GA17908@gandalf.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: 'Felipe Balbi' <me@felipebalbi.com>, 'Linux OMAP Mailing List' <linux-omap@vger.kernel.org>

 

>-----Original Message-----
>From: Felipe Balbi [mailto:felipe.balbi@nokia.com] 
>Sent: Wednesday, May 14, 2008 1:46 PM
>To: ext Girish
>Cc: 'Felipe Balbi'; felipe.balbi@nokia.com; 'Linux OMAP Mailing List'
>Subject: Re: TWL4030 keypad timeout interrupt
>
>Ok, good :-)
>thanks
>
>> 
>> >So if i read it correctly, we might have 0 set as our timeout.
>> >
>> >which might explain why we only see the timeout interrupt when 
>> >releasing the key.
>> >
>> >Am I right ?
>> 
>> Well, the timeout is here to help the controller come out of 
>hangs, if any. 
>
>But is it possible that whenever we release a key we get a 
>timeout? I think something is wrong there.

No, it's an empty timeout feature, an interrupt is generated if no key is pressed
during that period of time.


Regards,
Girish

