From: Ashwin Bihari <abihari@gmail.com>
Subject: Re: lcd rotation in omapfb_main.c
Date: Wed, 22 Apr 2009 09:25:55 -0400
Message-ID: <1f11a5490904220625g26876f68wf5b9a77ed0ed2f4e@mail.gmail.com>
References: <dbdb2ea60904211518o2539b4e1y80750587bebc30a1@mail.gmail.com>
	 <200904220029.30297.marek.vasut@gmail.com>
	 <dbdb2ea60904220539y61bc6dadgb895c4122f892b24@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.28]:18630 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751512AbZDVNZ4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Apr 2009 09:25:56 -0400
Received: by yx-out-2324.google.com with SMTP id 3so1443169yxj.1
        for <linux-omap@vger.kernel.org>; Wed, 22 Apr 2009 06:25:55 -0700 (PDT)
In-Reply-To: <dbdb2ea60904220539y61bc6dadgb895c4122f892b24@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: twebb <taliaferro62@gmail.com>
Cc: Marek Vasut <marek.vasut@gmail.com>, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

On Wed, Apr 22, 2009 at 8:39 AM, twebb <taliaferro62@gmail.com> wrote:
> On Tue, Apr 21, 2009 at 6:29 PM, Marek Vasut <marek.vasut@gmail.com> =
wrote:
>> On Wednesday 22 of April 2009 00:18:54 twebb wrote:
>>> I'm trying to start up the LCD panel on a new omap35xx-based platfo=
rm
>>> in portrait mode, though the native orientation of the display is
>>> landscape. =A0I'm running linux-2.6.27-omap1. =A0However, when I ch=
ange
>>> "def_rotate" to 90 in omapfb_main.c, it doesn't seem to make any
>>> difference in the orientation of the display. =A0Any ideas why this
>>> might be happening? =A0Could there be outstanding fixes/patches I n=
eed?
>>
>> change it to 1 or something ... btw. this should be configurable thr=
ough some
>> platform_data. Also, dont bring up new platform on deprecated kernel=
=2E
>>>
>
> Since when is linux-omap v2.6.27-omap1 deprecated? =A0It's only 5 mon=
ths
> old! =A0Am I missing something here?
>
> And the def_rotate is defined to be in degrees - I'm pretty sure
> setting it to 1 won't work.

Deprecated is probably a poor choice of words, but if you are indeed
bringing up a new platform, doing so on the newest Kernel you can find
will ensure that bringing in newer changes from the time you begin
your work will be easier.

The L-O tree is already about 2.6.30, so you're essentially 3
revisions out and you're just setting yourself up for a bunch of work
to port numerous changes into your Kernel.

And as Greg KH would probably say, 5 months in Kernel development land
is a really long period of time. :)

-- Ashwin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
