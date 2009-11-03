From: Mike Rapoport <mike.rapoport@gmail.com>
Subject: Re: [PATCH 0/5] New mux code for 34xx
Date: Tue, 3 Nov 2009 08:42:23 +0200
Message-ID: <f870da180911022242p2ddbd8f8j94da3fb466966d20@mail.gmail.com>
References: <20091029203124.11843.89983.stgit@localhost>
	 <4AED6321.7020002@compulab.co.il> <20091102185649.GC6692@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f180.google.com ([209.85.223.180]:47957 "EHLO
	mail-iw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751658AbZKCGmT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Nov 2009 01:42:19 -0500
Received: by iwn10 with SMTP id 10so3932665iwn.4
        for <linux-omap@vger.kernel.org>; Mon, 02 Nov 2009 22:42:24 -0800 (PST)
In-Reply-To: <20091102185649.GC6692@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Mike Rapoport <mike@compulab.co.il>, linux-omap@vger.kernel.org

On Mon, Nov 2, 2009 at 8:56 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Mike Rapoport <mike@compulab.co.il> [091101 02:29]:
>> Hi Tony,
>>
>> Tony Lindgren wrote:
>> > Hi all,
>> >
>> > Here's an initial version of the new mux code to play with.
>> > Big thanks to Paul & Benoit for the 34xx mux data!
>>
>> I've tried your patches, they seem to work just fine on CM-T35.
>
> OK cool.
>
>> > To try out the new code, compile a kernel with CONFIG_OMAP_MUX
>> > and CONFIG_DEBUG_FS and these patches. The series is also
>> > availabe in the l-o git in mux branch.
>>
>> [ snip ]
>>
>> >
>> > Comments welcome as always.
>>
>> There are some comments on patches 2 (Add new style pin multiplexing code for
>> omap3) and 3 (Add new style pin multiplexing data for 34xx). No nitpicking for
>> now, but checkpatch.pl is unhappy with the patchset :)
>
> OK, will run checkpatch.pl --strict on them. Thanks for the
> comments!

While on it, can you please update board-cm-t35.c to use CUS package?

> Regards,
>
> Tony
>



-- 
	Sincerely Yours,
		Mike.
