From: Ruslan Bilovol <ruslan.bilovol@ti.com>
Subject: Re: [PATCH 1/1] ARM: OMAP4: Add OMAP4 Blaze Tablet support
Date: Thu, 14 Feb 2013 01:28:05 +0200
Message-ID: <CAB=otbScyfU3PmANeLhgdeVEW=iG3yWXP46ZKwOWHaxeac1djA@mail.gmail.com>
References: <1360352269-14922-1-git-send-email-ruslan.bilovol@ti.com>
	<1360352269-14922-2-git-send-email-ruslan.bilovol@ti.com>
	<20130210025225.GB4801@atomide.com>
	<51193DE1.6080704@ti.com>
	<20130211190011.GS4801@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f44.google.com ([209.85.219.44]:35409 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752354Ab3BMX2K (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Feb 2013 18:28:10 -0500
In-Reply-To: <20130211190011.GS4801@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux@arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Tony, Jon,

On Mon, Feb 11, 2013 at 9:00 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Jon Hunter <jon-hunter@ti.com> [130211 10:58]:
>>
>> Please note that the blaze is derived from the omap4-sdp board and so I
>> would hope that we can use the existing for sdp dts and board file for
>> blaze. In fact this is what I do today for basic booting.
>>
>> So unless there is some feature on the blaze that is not compatible with
>> the original sdp, we should just use the sdp dts.
>
> Sounds like we need some common .dts file and separate files
> for sdp, blaze and tablet that include the common .dts file?
>
> There's a different LCD panel at least between blaze and the
> tablet.

Please note, that, although 'Blaze' board is very close to 'SDP' board,
there are quite big differences comparing to 'Blaze Tablet' board.
At least:
 - LCD panels
 - touchscreen controllers
 - LEDs
 - Keypad (on 'Blaze') / gpio keys (on 'Blaze Tablet')
 - Sensors
 - HS USB Host related stuff
 - cameras (there is no embedded cameras on 'Blaze Tablet' board)

As per my point of view, next should be done:
1) Add the DTS file for BlazeTablet board
2) Figure out what is common for both and move it to some common file
(if that makes sense)

I'm currently working on step '#1'. So after that step #2 should not
be an issue for us.

Best regards,
Ruslan

>
> Regards,
>
> Tony
