From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: RT tests on OMAP3
Date: Thu, 3 Sep 2009 16:44:02 +0200
Message-ID: <50C13C4A-A0E0-4CC8-B4FD-E66B35D79348@student.utwente.nl>
References: <f96d234e0908311350u5d3d7680gfbf46a1c8f9de58f@mail.gmail.com> <f96d234e0908312016v4ffb9765pe06dc53e5e679758@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1075.2)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp2.utsp.utwente.nl ([130.89.2.9]:52735 "EHLO smtp.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753328AbZICOuM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Sep 2009 10:50:12 -0400
In-Reply-To: <f96d234e0908312016v4ffb9765pe06dc53e5e679758@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Cliff Brake <cliff.brake@gmail.com>
Cc: rt-users <linux-rt-users@vger.kernel.org>, Linux OMAP Users <linux-omap@vger.kernel.org>


Op 1 sep 2009, om 05:16 heeft Cliff Brake het volgende geschreven:

> On Mon, Aug 31, 2009 at 4:50 PM, Cliff Brake<cliff.brake@gmail.com>  
> wrote:
>> Hello,
>>
>> I'm trying to run 2.6.31-rc8-rt9-omap1 on a OMAP3 cpu.  So far, it
>> seems fairly unstable:
>>
>> http://www.bec-systems.com/omap-rt-tests/
>>
>> 2.6.31-rc8-rt9 boots and runs well on a PXA270.
>>
>> The following mail also references udev failures:
>> http://lkml.org/lkml/2009/8/11/250
>
> A few more observations:
>
> Applying
>
> http://cgit.openembedded.org/cgit.cgi/openembedded/diff/recipes/linux/linux-omap-2.6.29/0001-implement-TIF_RESTORE_SIGMASK-support-and-enable-the.patch?id=1f0d91e152f16fbd40bb2fb3c44a30d774d4dede

If people want to push that upstream, please do so, I only updated the  
patch to a more recent kernel but don't have the time nor skills to  
make it suitable for upstream.

regards,

KOen
