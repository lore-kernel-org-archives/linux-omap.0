From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Wed, 9 Jun 2010 11:13:47 +0300
Message-ID: <AANLkTikzGkDU1dwNYLVT6p9cPEkaMHKRuc6u0FbTBW7L@mail.gmail.com>
References: <Pine.LNX.4.44L0.1005271253240.3239-100000@iolanthe.rowland.org>
	<AANLkTilUQ2AG76nbK6LwI8_7zw0_yMSoAOr9pmuz7xrt@mail.gmail.com>
	<201005312347.24251.rjw@sisk.pl>
	<AANLkTilvOgSFTDFtXbjJobMZWxgfvsC97TqC7_a_NHBX@mail.gmail.com>
	<alpine.LFD.2.00.1006011411200.2933@localhost.localdomain>
	<AANLkTikZHmF6baP7dEXEGFE8YsbEteRjlhb5wqZX8ll1@mail.gmail.com>
	<alpine.LFD.2.00.1006020905410.2933@localhost.localdomain>
	<AANLkTinDm3FIrbS1jqEzW15THmr1hdd7ox0Mllm1VLjZ@mail.gmail.com>
	<1275471561.27810.30865.camel@twins>
	<AANLkTilLmAb2c9fQwuguzWtjcHfuTZvPUTbUx7vuwFI6@mail.gmail.com>
	<1275474088.27810.31000.camel@twins>
	<20100602221309.6da754e7@schatten.dmk.lab>
	<1275550802.27810.34863.camel@twins>
	<20100603161205.73a2b56d@schatten.dmk.lab>
	<1275578881.27810.35995.camel@twins>
	<AANLkTinBg9W7zeomPbpGEDWkIsfxO9OfFUC0Kq7wafFb@mail.gmail.com>
	<20100605215604.68efc4e5@schatten.dmk.lab>
	<AANLkTilhvUn3PfnHsJTNzhr59xrUyvGlFmnAOnub65sE@mail.gmail.com>
	<20100605225012.771332db@schatten.dmk.lab>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43436 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752986Ab0FIINt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Jun 2010 04:13:49 -0400
In-Reply-To: <20100605225012.771332db@schatten.dmk.lab>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Florian Mickler <florian@mickler.org>
Cc: Peter Zijlstra <peterz@infradead.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, Matthew Garrett <mjg59@srcf.ucam.org>, Alan Stern <stern@rowland.harvard.edu>, Paul@smtp1.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

On Sat, Jun 5, 2010 at 11:50 PM, Florian Mickler <florian@mickler.org> wrote:
> On Sat, 5 Jun 2010 23:06:03 +0300
> Felipe Contreras <felipe.contreras@gmail.com> wrote:
>> How would such stats be calculated? I presume at regular intervals you
>> check which applications are holding suspend blockers and increase a
>> counter.
>>
>> How would you do that with the dynamic PM approach? At regular
>> intervals you check for which applications are running (not idle).
>
> IIRC, the patches discussed have debugging infrastructure in
> them. The kernel does the accounting.

We are not talking about debugging, we are talking about stats shown
in user-space so that users can see the offending apps. It doesn't
matter where the accounting is done, it would be at regular intervals
and there's nothing that prevents the dynamic PM approach to offer
similar stats.

>> > The only difference is, that with suspend blockers, he can than
>> > dismiss the applications permission to block suspend and will not miss
>> > his job interview the next day because his phones battery run
>> > out. And also he can use the application to a certain extent.
>>
>> So the difference is between removing the app, and making it run
>> crappy. I don't think that's a strong argument in favor of suspend
>> blockers.
>>
> If you think a little about it, it is. Because if the app wouldn't be
> usable at all, the bug wouldn't get fixed because the user wouldn't use
> it. Or not?

I'm not sure what's your point here. One user not using a certain
application doesn't prevent bugs to get fixed. In fact, less people
using an app will cause less buzz, and less downloads, and less
positive votes... which might wake up the author to think: hey, maybe
I'm doing something wrong? Maybe I should really listen to those bug
reports.

Anyway, my point is that there's nothing special about 3rd party app
stats with suspend blockers.

-- 
Felipe Contreras
