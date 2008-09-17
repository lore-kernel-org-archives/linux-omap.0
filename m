From: twebb <taliaferro62@gmail.com>
Subject: Re: getting 2.6.25 from git to run on omap35x evm
Date: Wed, 17 Sep 2008 16:11:02 -0400
Message-ID: <dbdb2ea60809171311g13631826m4b46a881ebbb1ae5@mail.gmail.com>
References: <dbdb2ea60809171136v5a380989mf57aca6ff1df5aba@mail.gmail.com>
	 <ADBD1DC1-66B1-4EE2-92D8-051C5B91FC1C@student.utwente.nl>
	 <dbdb2ea60809171223h7ef92c3dg6a4d41f29b9b8c1e@mail.gmail.com>
	 <1f11a5490809171236k52fcc05q74ce5dfe1882d5cb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:36482 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752380AbYIQULE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Sep 2008 16:11:04 -0400
Received: by wa-out-1112.google.com with SMTP id j37so2151315waf.23
        for <linux-omap@vger.kernel.org>; Wed, 17 Sep 2008 13:11:03 -0700 (PDT)
In-Reply-To: <1f11a5490809171236k52fcc05q74ce5dfe1882d5cb@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ashwin Bihari <abihari@gmail.com>
Cc: Koen Kooi <k.kooi@student.utwente.nl>, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

On Wed, Sep 17, 2008 at 3:36 PM, Ashwin Bihari <abihari@gmail.com> wrote:
>>
>> Does anyone (TI?) know how far apart their linux-2.6.22.18 (SDK 1.0.0)
>> is from the linux-omap-2.6.git and when they might converge?  Along
>> these lines, which defconfig to use for OMAP35x EVM:  SDK =
>> omap3evm_defconfig or linux-omap-2.6.25 = omap3_evm_defconfig
>> (different names and different contents)?
>>
>
> If you take a look at the http://git.omapzoom.org tree as opposed to
> the official Linux OMAP tree, that things will be more linear to your
> 2.6.22.18 tree. I'm currently moving our 2.6.22.18 codebase to
> 2.6.27-rc3 based on the OMAPZOOM tree and it's faring a lot better
> then when I tried the official tree.
>
> So use OMAPZOOM to quickly jump ahead and once up-to-date you can
> figure out what the next step is to get more towards the official L-O
> tree..
>
> Regards
> ~ Ashwin
>

Great, that's helpful.  Do you know omapzoom linux-2.6.25 to be
somewhat functional with OMAP 35x EVM, or would you suggest going with
something newer like v2.6.26-ti-07252008?  Or must I go to 2.6.27-rc3?
 I assume newer (to a point) would result in better stability on the
35x EVM?

Thanks,
twebb
