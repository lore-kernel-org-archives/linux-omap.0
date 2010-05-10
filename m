From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: omap-pm: omap3_pm_defconfig no longer booting on Overo
Date: Mon, 10 May 2010 09:02:45 -0700
Message-ID: <87eihjlp7e.fsf@deeprootsystems.com>
References: <4BD93413.6000409@gmail.com> <8739yckbyy.fsf@deeprootsystems.com>
	<4BDB9C05.5050307@gmail.com> <4BDC4999.4050003@gmail.com>
	<j2lf96d234e1005071502q5a335634jd493a92ee970995b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:38226 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751866Ab0EJQCt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 May 2010 12:02:49 -0400
Received: by pvb32 with SMTP id 32so44970pvb.19
        for <linux-omap@vger.kernel.org>; Mon, 10 May 2010 09:02:48 -0700 (PDT)
In-Reply-To: <j2lf96d234e1005071502q5a335634jd493a92ee970995b@mail.gmail.com> (Cliff Brake's message of "Fri\, 7 May 2010 18\:02\:40 -0400")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Cliff Brake <cliff.brake@gmail.com>
Cc: Nishanth Menon <menon.nishanth@gmail.com>, Peter Tseng <tsenpet09@gmail.com>, linux-omap@vger.kernel.org

Cliff Brake <cliff.brake@gmail.com> writes:

> On Sat, May 1, 2010 at 11:32 AM, Nishanth Menon
> <menon.nishanth@gmail.com> wrote:
>> DISCLAIMER: I dont have a overo, so no idea if this would work.. but here
>> you go..
>>
>> Attached is a diff which probably will help you with the specific changes
>> needed for making pm boot on overo. hope it helps..
>>
>> a.diff is the change you would probably need for the overo file to fix it up
>> once for all
>>
>> the patch file is cleaning up the unnecessary BUG() in resource34xx.c which
>> caused the lockup -> elegant fix will potentially need more cleaning up..
>> but lets just leave it at the fact that srf is going to go away in a month
>> or so..
>
> Nishanth,
>
> These patches get my overo booting with the PM branch -- can they be
> pushed to the pm branch?
>

Hi Cliff,

The SRF fixup patches are already pushed to the PM branch.  This will
at least allow a non-crashing boot on Overo.  If you want to enable
DVFS on Overo, someone will have to test and validate Nishanth's other
change on Overo and (re)submit with proper changelog etc.

Thanks,

Kevin



