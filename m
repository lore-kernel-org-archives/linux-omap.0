From: twebb <taliaferro62@gmail.com>
Subject: Re: lcd rotation in omapfb_main.c
Date: Wed, 22 Apr 2009 08:39:23 -0400
Message-ID: <dbdb2ea60904220539y61bc6dadgb895c4122f892b24@mail.gmail.com>
References: <dbdb2ea60904211518o2539b4e1y80750587bebc30a1@mail.gmail.com>
	 <200904220029.30297.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.29]:16986 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752277AbZDVMpl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Apr 2009 08:45:41 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1959404ywb.1
        for <linux-omap@vger.kernel.org>; Wed, 22 Apr 2009 05:45:40 -0700 (PDT)
In-Reply-To: <200904220029.30297.marek.vasut@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

On Tue, Apr 21, 2009 at 6:29 PM, Marek Vasut <marek.vasut@gmail.com> wr=
ote:
> On Wednesday 22 of April 2009 00:18:54 twebb wrote:
>> I'm trying to start up the LCD panel on a new omap35xx-based platfor=
m
>> in portrait mode, though the native orientation of the display is
>> landscape. =A0I'm running linux-2.6.27-omap1. =A0However, when I cha=
nge
>> "def_rotate" to 90 in omapfb_main.c, it doesn't seem to make any
>> difference in the orientation of the display. =A0Any ideas why this
>> might be happening? =A0Could there be outstanding fixes/patches I ne=
ed?
>
> change it to 1 or something ... btw. this should be configurable thro=
ugh some
> platform_data. Also, dont bring up new platform on deprecated kernel.
>>

Since when is linux-omap v2.6.27-omap1 deprecated?  It's only 5 months
old!  Am I missing something here?

And the def_rotate is defined to be in degrees - I'm pretty sure
setting it to 1 won't work.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
