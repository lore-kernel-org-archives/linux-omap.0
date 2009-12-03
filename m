From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: Merge plans for 2.6.33 merge window
Date: Fri, 4 Dec 2009 01:28:14 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702FAA0C55D@dbde02.ent.ti.com>
References: <20091203173559.GR4348@atomide.com>
 <FCCFB4CDC6E5564B9182F639FC35608702FAA0C54F@dbde02.ent.ti.com>
 <20091203184454.GS4348@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34762 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751412AbZLCT6Q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Dec 2009 14:58:16 -0500
In-Reply-To: <20091203184454.GS4348@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



>-----Original Message-----
>From: Tony Lindgren [mailto:tony@atomide.com]
>Sent: Thursday, December 03, 2009 12:45 PM
>To: Pandita, Vikram
>Cc: linux-omap@vger.kernel.org
>Subject: Re: Merge plans for 2.6.33 merge window
>
>* Pandita, Vikram <vikram.pandita@ti.com> [091203 10:27]:
>> Tony
>>
>> >-----Original Message-----
>> >From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Tony
>> >Lindgren
>> >Sent: Thursday, December 03, 2009 11:36 AM
>> >To: linux-omap@vger.kernel.org
>> >Subject: Merge plans for 2.6.33 merge window
>> >
>> >Hi all,
>> <snip>
>> >Then there are some new board files, like
>> >touchbook and various fixes.
>>
>> 3630 board support (zoom3/sdp3630) is already integrated in for-next.
>> However the only pending patches missing for 3630 boards to boot are these serial patches:
>> 	http://patchwork.kernel.org/patch/61671/
>> 	http://patchwork.kernel.org/patch/61672/
>>
>> Now there has been much discussion on the approach (errata vs feature).
>> As a moderator, how would you like us to proceed on this?
>
>The best solution way would be to check the revision register for the
>serial module if available and then initialize the serial port
>accordinly.
>
>If this feature cannot be checked in the serial module, and is only
>needed during the serial init, you might as well implement the test
>in arch/arm/mach-omap2/serial.c. So probably no need to add that to
>id.c.

Looking into this aspect to override the serial_in() function based on IP version check in mach-omap2/serial.c file.


>
>Regards,
>
>Tony
