From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH] [ARM] video/omap2/tdo35s: fix visual artefacts
Date: Mon, 26 Jul 2010 11:34:00 +0300
Message-ID: <4C4D4878.9050703@compulab.co.il>
References: <1278931370-19912-1-git-send-email-grinberg@compulab.co.il>	 <4C4705DB.4000402@compulab.co.il> <1280131405.2427.11.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:45376 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753461Ab0GZIeI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 26 Jul 2010 04:34:08 -0400
In-Reply-To: <1280131405.2427.11.camel@tubuntu.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Mike Rapoport <mike@compulab.co.il>

>
> On Wed, 2010-07-21 at 16:36 +0200, ext Igor Grinberg wrote:
>   
>> ping!
>>     
> Man has to have his vacation!
>
>   

Well, sorry for that...
I had no idea you are on vacation, but I hope you had a good one :)

>>> TDO35S samples the data on the falling adge of the pixel clock,
>>> therefore the data strobe should be on the raising edge.
>>>       
> Looks fine to me, except I'd like the patch subject to be in line with
> the other patches (ie. prefixed by OMAP: DSS2: ...), and I think it
> should describe the change more precisely, perhaps something like "fix
> the video signal".
>
>   

I'm still new to omap and mostly worked on pxa's till now,
so I brought the subject from there...

> I can make those changes as I apply it to my tree, if it's ok to you.
>   

It is completely fine with me :)

>  Tomi
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>   

-- 
Regards,
Igor.

