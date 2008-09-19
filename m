From: twebb <taliaferro62@gmail.com>
Subject: Re: getting 2.6.25 from git to run on omap35x evm
Date: Fri, 19 Sep 2008 11:24:40 -0400
Message-ID: <dbdb2ea60809190824w507aa4f4j5754b0b73d2664fe@mail.gmail.com>
References: <dbdb2ea60809171136v5a380989mf57aca6ff1df5aba@mail.gmail.com>
	 <ADBD1DC1-66B1-4EE2-92D8-051C5B91FC1C@student.utwente.nl>
	 <dbdb2ea60809171223h7ef92c3dg6a4d41f29b9b8c1e@mail.gmail.com>
	 <1f11a5490809171236k52fcc05q74ce5dfe1882d5cb@mail.gmail.com>
	 <dbdb2ea60809171311g13631826m4b46a881ebbb1ae5@mail.gmail.com>
	 <FCCFB4CDC6E5564B9182F639FC356087022A2BAB54@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.168]:5539 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751827AbYISPYl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Sep 2008 11:24:41 -0400
Received: by wf-out-1314.google.com with SMTP id 27so517643wfd.4
        for <linux-omap@vger.kernel.org>; Fri, 19 Sep 2008 08:24:40 -0700 (PDT)
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC356087022A2BAB54@dbde02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

>>
>> Great, that's helpful.  Do you know omapzoom linux-2.6.25 to be
>> somewhat functional with OMAP 35x EVM, or would you suggest going with
>> something newer like v2.6.26-ti-07252008?  Or must I go to 2.6.27-rc3?
>>  I assume newer (to a point) would result in better stability on the
>> 35x EVM?
>
> On omapzoom.org, I try to test for functionality complete and working for primarily LDP board and also 3430SDP. I have not tested the EVM stuff.
>
> I just completed up merging omapzoom tree to 2.6.27rc6 on branch: branch_2.6.27rc6_migration
> You could have a look at it if that helps.
>

I tried the rc6_migration branch, and after a few hiccups got it
basically running.  However, seeing two problems - one is minor at
this point but the other is a real issue.

#1 (minor) - I'm seeing the following and can't figure out why...
---
DSS:clk set: ask=124000000, tgt=104000000, sup=96000000
Unable to set the DSSfunctional clock to 96000000

 UNABLE to enable dss TV fclk
---
any ideas?

#2 - when any key is pressed on the 35x EVM, I get the following
output continuously...
TWL4030 module irq 369 is disabled but can't be masked!
TWL4030 module irq 369 is disabled but can't be masked!
...

Though it sounds like no one is testing this code against a 35x EVM,
I'm still hoping someone may have a clue about what is going wrong
here.

Thanks,
twebb
