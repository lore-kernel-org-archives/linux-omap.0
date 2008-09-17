From: "Ashwin Bihari" <abihari@gmail.com>
Subject: Re: getting 2.6.25 from git to run on omap35x evm
Date: Wed, 17 Sep 2008 19:02:34 -0400
Message-ID: <1f11a5490809171602w3b106288ib900bc1e232a1481@mail.gmail.com>
References: <dbdb2ea60809171136v5a380989mf57aca6ff1df5aba@mail.gmail.com>
	 <ADBD1DC1-66B1-4EE2-92D8-051C5B91FC1C@student.utwente.nl>
	 <dbdb2ea60809171223h7ef92c3dg6a4d41f29b9b8c1e@mail.gmail.com>
	 <1f11a5490809171236k52fcc05q74ce5dfe1882d5cb@mail.gmail.com>
	 <dbdb2ea60809171311g13631826m4b46a881ebbb1ae5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.169]:35997 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754635AbYIQXCg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Sep 2008 19:02:36 -0400
Received: by wf-out-1314.google.com with SMTP id 27so3235056wfd.4
        for <linux-omap@vger.kernel.org>; Wed, 17 Sep 2008 16:02:34 -0700 (PDT)
In-Reply-To: <dbdb2ea60809171311g13631826m4b46a881ebbb1ae5@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: twebb <taliaferro62@gmail.com>
Cc: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

On Wed, Sep 17, 2008 at 4:11 PM, twebb <taliaferro62@gmail.com> wrote:
> On Wed, Sep 17, 2008 at 3:36 PM, Ashwin Bihari <abihari@gmail.com> wrote:
>>>
>>> Does anyone (TI?) know how far apart their linux-2.6.22.18 (SDK 1.0.0)
>>> is from the linux-omap-2.6.git and when they might converge?  Along
>>> these lines, which defconfig to use for OMAP35x EVM:  SDK =
>>> omap3evm_defconfig or linux-omap-2.6.25 = omap3_evm_defconfig
>>> (different names and different contents)?
>>>
>>
>> If you take a look at the http://git.omapzoom.org tree as opposed to
>> the official Linux OMAP tree, that things will be more linear to your
>> 2.6.22.18 tree. I'm currently moving our 2.6.22.18 codebase to
>> 2.6.27-rc3 based on the OMAPZOOM tree and it's faring a lot better
>> then when I tried the official tree.
>>
>> So use OMAPZOOM to quickly jump ahead and once up-to-date you can
>> figure out what the next step is to get more towards the official L-O
>> tree..
>>
>> Regards
>> ~ Ashwin
>>
>
> Great, that's helpful.  Do you know omapzoom linux-2.6.25 to be
> somewhat functional with OMAP 35x EVM, or would you suggest going with
> something newer like v2.6.26-ti-07252008?  Or must I go to 2.6.27-rc3?
>  I assume newer (to a point) would result in better stability on the
> 35x EVM?
>
> Thanks,
> twebb
>

The EVM is a board option in this tree, so you're going to have the
best possible luck with the latest and greatest code base. I have a
custom board based on the OMAP3530. So I'm actually adding a new
board-type and the necessary pieces appropriate for my platform.

Regards
~ Ashwin
