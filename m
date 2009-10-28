From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: [PATCH 1/2] Added board-3630.c file.
Date: Thu, 29 Oct 2009 03:09:08 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702FA36ED5A@dbde02.ent.ti.com>
References: <7A436F7769CA33409C6B44B358BFFF0C012AC22851@dlee02.ent.ti.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E940253EFE1C8@dbde02.ent.ti.com>
 <FCCFB4CDC6E5564B9182F639FC35608702FA36ED28@dbde02.ent.ti.com>
 <7A436F7769CA33409C6B44B358BFFF0C012AD6D92C@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48439 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751360AbZJ1VjJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Oct 2009 17:39:09 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n9SLdB93012162
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 28 Oct 2009 16:39:13 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n9SLdAJR008948
	for <linux-omap@vger.kernel.org>; Thu, 29 Oct 2009 03:09:10 +0530 (IST)
In-Reply-To: <7A436F7769CA33409C6B44B358BFFF0C012AD6D92C@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>, "Pais, Allen" <allen.pais@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Taliaferro, Steve" <staliaferro@ti.com>


Nishanth

>-----Original Message-----
>From: Menon, Nishanth
>> From: Pandita, Vikram
>> >From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of Pais,
>> >Sent: Monday, October 26, 2009 4:40 PM
>> >To: Pais, Allen; linux-omap@vger.kernel.org
>> >Subject: RE: [PATCH 1/2] Added board-3630.c file.
>>
>> >> Signed-off-by: Allen Pais <allen.pais@ti.com>
>> >> ---
>> >>  arch/arm/mach-omap2/board-3630sdp.c |  188
>> >> +++++++++++++++++++++++++++++++++++
>> >>  1 files changed, 188 insertions(+), 0 deletions(-)  create mode
>> >> 100644 arch/arm/mach-omap2/board-3630sdp.c
>> >>
>> >> diff --git a/arch/arm/mach-omap2/board-3630sdp.c b/arch/arm/mach-
>> >> omap2/board-3630sdp.c new file mode 100644 index 0000000..d3ddbd1
>> >> --- /dev/null
>> >> +++ b/arch/arm/mach-omap2/board-3630sdp.c
>> >> @@ -0,0 +1,188 @@
>> >> +/*
>> >> +
>> >
>> >NAK. Could we follow the same issue with zoom2 -> break the keypad into a
>> Separate one and use it
>> >instead? Same for all reused zoom2 components..
>> >
>> >[Allen] Yes, we should do that. Not only for keypad but also
>> >For display panel and touch screen so that sdp3630, zoom3 and
>> >Zoom2 could use the same code, without having to duplicate
>> >Code.
>>
>> We just got the same image for zoom3 boot on SDP3630 (after mach-type
>> change)
>> The peripheral set is almost >90% same: same keypad, same display, same
>> RAM, same NAND.
>Ok zoom2,zoom3,sdp3630 -> might be good to compare. Here is a quick attempt:
>Peripheral    zoom2    zoom3    sdp3630

I was making that list already. Good to see you thinking on same lines.
However your list does not match with mine and I tried to confirm the changes looking at h/w.
Here is the list, in the order of impact:


Peripheral    zoom2    zoom3    sdp3630
Ethernet	  A		A	  B **(may not be same)
NOR		  n/a	     n/a	  B ** different
Onenand	  n/a	     n/a	  B ** diffferent
HDMI          A         A       B **(Need to verify: not there on i2c3)
NAND          A         A       A (same nand)
SDRAM         A         A       A (same sdram)
Keypad        A         A       A (same twl) 
Camera        A         A       A (same sensor can be mounted: can check further)
LCD Display   A         A       A (same wvga display)
Power         A         A       A (same chip level)
Audio         A         A       A (its the same)
Voltage resources??			(not sure what you mean?)
LEDs          A         A       B (LEDs are board specific, can reside in separate board file)
OPPs          A         A       A (same chip feature)


>.... others?? ...
>NOTE: I am just using A and B to show the types of devices. So the files registering the same type
>would probably be shared.. could you expand this list?
>
>>
>> I see a good amount of re-use possible here.
>> Here is how we could do it:
>>
>> Board-zoom2.c
>> Split into:
>> 	Board-zoom2.c
>> 	Board-zoom-peripheral.c [reuse]
>>
>> 3630 zoom3 uses:
>> 	Board-zoom3.c
>> 	Board-zoom-peripheral.c [reuse]
>>
>> 3630 SDP uses:
>> 	Board-3630sdp.c
>> 	Board-zoom-peripheral.c [reuse]
>>
>>
>> Will give a first pass at this split up and post patches.
>>
>Thanks..
>
>Regards,
>Nishanth Menon

