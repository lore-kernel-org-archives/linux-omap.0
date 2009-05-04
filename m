From: "vimal singh" <vimalsingh@ti.com>
Subject: Re: [PATCH] onenand_init: Allow disabling sync read and write
     based on flags,
      v2 (Re: [PATCH 1/4] onenand init: Rename board-n800-flash.c to
     gpmc-onenand.c)
Date: Mon, 4 May 2009 11:06:47 +0530 (IST)
Message-ID: <65231.192.168.10.89.1241415407.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40415 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751376AbZEDFhK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 May 2009 01:37:10 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: dedekind@infradead.org, linux-omap@vger.kernel.org, adrian.hunter@nokia.com, Tony Lindgren <tony@atommide.com>



On Fri, May 1, 2009 at 11:08 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Tony Lindgren <tony@atomide.com> [090430 11:56]:
>> * Tony Lindgren <tony@atomide.com> [090430 07:06]:
>> > * vimal singh <vimalsingh@ti.com> [090429 23:33]:
>> > > 'gpmc-onenand.c' is still confusing name. This is not going to used in
>> > > all boards anyway.
>> >
>> > Why do you think this cannot be used for all boards?
>> >
>> > The GPMC timings are totally based on the onenand chip features.
>>
>> And these two patches make omap3430sdp to work with the gpmc-onenand
>> code. Sync mode does not work, but it seems like it was never enabled
>> for sdp anyways.
>>
>> Similar patch should work for other boards too.
>
> Setting the sync_write depends on flags and processor, not just flags.
> Here's a fixed version of this patch.
OK, these both patches seems good to me...
Earlier I was in impression that this patch series is basically to remove
board-*-flash.c files. Since in 3430sdp boards we find out 'CS' number for
flash devices dynamically in different versions of boards. So, I was confused.

> Tony
>


---
Regards,
\/ | |\/| /-\ |_



