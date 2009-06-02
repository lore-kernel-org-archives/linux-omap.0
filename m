From: "Venkatesh, Subbu" <subbu.wrs@ti.com>
Subject: RE: DSS2: How to test TV and LCD output simulatenously
Date: Tue, 2 Jun 2009 10:51:11 -0500
Message-ID: <5F744A5A3C131242B81CE5874BD2CFFB34E35EB5@dlee01.ent.ti.com>
References: <5F744A5A3C131242B81CE5874BD2CFFB34E35EAC@dlee01.ent.ti.com>,<4A251260.7070800@mlbassoc.com>
 <5F744A5A3C131242B81CE5874BD2CFFB34E35EAF@dlee01.ent.ti.com>,<4A25478F.2040500@mlbassoc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55501 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752824AbZFBPxj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Jun 2009 11:53:39 -0400
In-Reply-To: <4A25478F.2040500@mlbassoc.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Gary Thomas <gary@mlbassoc.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shah, Hardik" <hardik.shah@ti.com>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>

Hello Gary,
I have already emailed the patch, here is the link..
 http://patchwork.kernel.org/patch/24196/

Regards,
Subbu
________________________________________
From: Gary Thomas [gary@mlbassoc.com]
Sent: Tuesday, June 02, 2009 10:38 AM
To: Venkatesh, Subbu
Cc: linux-omap@vger.kernel.org; Shah, Hardik; tomi.valkeinen@nokia.com
Subject: Re: DSS2: How to test TV and LCD output simulatenously

Venkatesh, Subbu wrote:
> Hi Gary,
> LDP is a development board, I have to work on LDP panel driver  and BSP code to support new DSS2, It is ported on linux-omap tree.
> I am still working on testing the features. For camera I might move into V4l2, but I cannot confirm this, I am still working on testing the Framebuffer features.

How much of this can you share?  I'd like to try this on my LDP (Zoom1)
and then get it ported to my own hardware (very similar to Zoom1)

Thanks

> ________________________________________
> From: Gary Thomas [gary@mlbassoc.com]
> Sent: Tuesday, June 02, 2009 6:52 AM
> To: Venkatesh, Subbu
> Cc: linux-omap@vger.kernel.org; Shah, Hardik; tomi.valkeinen@nokia.com
> Subject: Re: DSS2: How to test TV and LCD output simulatenously
>
> Venkatesh, Subbu wrote:
>> Hi,
>> I have DSS2 ported on LDP board, I could manage to get output display on TV and LCD interface individually, also tested some of the features like Rotation and Mirroring, they worked with out any problem.
>
> What does "DSS2 ported on LDP board" mean?  What source tree/branch did you use?
>
>> Now I am trying to get output both on TV and LCD simultaneously,
>>
>> I was not successful with my approach that I tried, like
>>
>> 1. Boot the kernel with the default LCD display
>> 2. Then I enabled ntsc timings for TV, as PAL do not work on it.
>>     #echo ntsc > /sys/devices/platform/omapdss/display1/timings
>> 3. Enabled TV
>>   # echo 1 > /sys/devices/platform/omapdss/display1/enable
>> and did the common fb test....
>> But it did not seem to work.
>> Its nice if someone has different working approach or can suggest me where I am going wrong in the above steps.
>
> Is this stuff documented somewhere?  Like the difference
> between DSS1 and DSS2?  How the various layers and overlays
> are supposed to work?  What about the camera interface?

--
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------

