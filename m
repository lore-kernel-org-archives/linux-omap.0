From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 02/25] OMAP4: Redefine mandatory barriers for OMAP to
 include interconnect barriers.
Date: Wed, 14 Sep 2011 11:09:12 +0530
Message-ID: <CAMQu2gzX8+i61=WY+5HchVt4z+G+aFg3d40-nP7Mm62CGW0giA@mail.gmail.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
 <1315144466-9395-3-git-send-email-santosh.shilimkar@ti.com> <20110913202701.GF24252@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:60476 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750752Ab1INFjd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Sep 2011 01:39:33 -0400
Received: by gyg8 with SMTP id 8so1079183gyg.6
        for <linux-omap@vger.kernel.org>; Tue, 13 Sep 2011 22:39:32 -0700 (PDT)
In-Reply-To: <20110913202701.GF24252@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, khilman@ti.com, rnayak@ti.com, Richard Woodruff <r-woodruff2@ti.com>

On Wed, Sep 14, 2011 at 1:57 AM, Tony Lindgren <tony@atomide.com> wrote=
:
> * Santosh Shilimkar <santosh.shilimkar@ti.com> [110904 06:22]:
>> On OMAP4 SOC intecronnects has many write buffers in the async bridg=
es
>> and they can be drained only with stongly ordered accesses.
>
> This is not correct, strongly ordered access does not guarantee
> anything here. If it fixes issues, it's because it makes the writes
> to reach the device faster. Strongly ordered does not affect anything
> outside ARM, so the bus access won't change.
>
> The only real fix here is to do a read back of the device in question
> to guarantee the write got to the device.
>
>> There are two ports as below from MPU and both needs to be drained.
>> =A0 =A0 =A0 - MPU --> L3 T2ASYNC FIFO
>> =A0 =A0 =A0 - MPU --> DDR T2ASYNC FIFO
>>
>> Without the interconnect barriers, many issues have been observed
>> leading to system freeze, CPU deadlocks, random crashes with
>> register accesses, synchronization loss on initiators operating
>> on both interconnect port simultaneously.
>
> We had these issues for omap3 too. Adding a few read backs solved
> those kinds of issues.
>
No. Don't mix things. OMAP3 behaviour is a interconnect level and
it was single interconnect channel.

The issue here is a BUG in the asynchronous bridges and OMAp4 has
two separate channels at interconnect level form MPU side as mentioned
above.

Both of these patches I have passed it through Russell and Caralin befo=
re
including them here.

Regards
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
