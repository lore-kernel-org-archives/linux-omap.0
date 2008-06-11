From: "arun c" <arunedarath@mistralsolutions.com>
Subject: Re: [PATCH 0/3] Adding support for OMAP2EVM(Replacing 2430OSK)
Date: Wed, 11 Jun 2008 20:00:32 +0530
Message-ID: <c656a4d20806110730p256a150bud63f0bb4308ef650@mail.gmail.com>
References: <c656a4d20806110331q4065f7f9i653fe05ebff17cd5@mail.gmail.com>
	 <5555135da289dac56cefe2a4ee46ac03@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.185]:33132 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750956AbYFKOae (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Jun 2008 10:30:34 -0400
Received: by ti-out-0910.google.com with SMTP id b6so832552tic.23
        for <linux-omap@vger.kernel.org>; Wed, 11 Jun 2008 07:30:32 -0700 (PDT)
In-Reply-To: <5555135da289dac56cefe2a4ee46ac03@felipebalbi.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <me@felipebalbi.com>

On Wed, Jun 11, 2008 at 5:00 PM, Felipe Balbi <me@felipebalbi.com> wrote:
>
>
> On Wed, 11 Jun 2008 16:01:12 +0530, "arun c"
> <arunedarath@mistralsolutions.com> wrote:
>> Hi all,
>>
>> The following set of patches adds support for
>> Mistral's OMAP2EVM board.
>>
>> a) First patch replaces 2430OSK board files with omap2evm
>> b) Second patch provides compile support
>> c) Third patch completes the name change
>
> The problem will be with the legacy 2430osk, they still provide
> the old 1437 machine id, right ? If you remove all of it users
> won't be able to boot them until upgrading u-boot.
>

Yes, the old machine id is an issue, but peoples(If anybody is
already using 2430osk) can always download the latest
u-boot from www.mistralsolutions.com and use it.(I don't think mistral
supports the old machine id in U-boot anymore).

> Besides they carry a different processor (2430 on osk and 2530
> on evm). Maybe we keep support for both just sharing all board
> files ?
>

As of now all the code written for 2430osk will run on omap2evm also,
so i don't think there is any major issue
which can happen due to this name change.

> board-n810.c shares everything with board-n800, maybe you
> should do something similar?
>
Moreover its the change related to name change from 2430OSK to
OMAP2EVM.(Not actually related to hardware
change like n800 and n810), and Mistral no longer sell boards with the
name 2430OSK all the boards come out with name
OMAP2EVM. Thats why I want the name change from
2430OSK to OMAP2EVM

Regards,
Arun C



> --
> Best Regards,
>
> Felipe Balbi
> http://felipebalbi.com
> me@felipebalbi.com
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
