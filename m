From: "Ashwin Bihari" <abihari@gmail.com>
Subject: Re: getting 2.6.25 from git to run on omap35x evm
Date: Wed, 17 Sep 2008 15:36:34 -0400
Message-ID: <1f11a5490809171236k52fcc05q74ce5dfe1882d5cb@mail.gmail.com>
References: <dbdb2ea60809171136v5a380989mf57aca6ff1df5aba@mail.gmail.com>
	 <ADBD1DC1-66B1-4EE2-92D8-051C5B91FC1C@student.utwente.nl>
	 <dbdb2ea60809171223h7ef92c3dg6a4d41f29b9b8c1e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:31445 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752513AbYIQTgh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Sep 2008 15:36:37 -0400
Received: by wa-out-1112.google.com with SMTP id j37so2142728waf.23
        for <linux-omap@vger.kernel.org>; Wed, 17 Sep 2008 12:36:35 -0700 (PDT)
In-Reply-To: <dbdb2ea60809171223h7ef92c3dg6a4d41f29b9b8c1e@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: twebb <taliaferro62@gmail.com>
Cc: Koen Kooi <k.kooi@student.utwente.nl>, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

On Wed, Sep 17, 2008 at 3:23 PM, twebb <taliaferro62@gmail.com> wrote:
> On Wed, Sep 17, 2008 at 2:59 PM, Koen Kooi <k.kooi@student.utwente.nl> wrote:
>>
>> Why 2.6.25? Git has 2.6.26 already and currenly is at 2.6.27rc6, so why go
>> from one obsolete version to another obsolete one? .27rc is pretty broken on
>> the EVM atm, ut .26 should work fine.
>>
> Was going with 2.6.25 because once I get basic functionality on the
> EVM with linux-omap-2.6.25, next step is applying a separate
> 2.6.25-based patch.  So 2.6.26 should work OK on 35xEVM?  If so, I'll
> see if patch applies without problems and give it a try.
>
> Does anyone (TI?) know how far apart their linux-2.6.22.18 (SDK 1.0.0)
> is from the linux-omap-2.6.git and when they might converge?  Along
> these lines, which defconfig to use for OMAP35x EVM:  SDK =
> omap3evm_defconfig or linux-omap-2.6.25 = omap3_evm_defconfig
> (different names and different contents)?
>
> Thanks.
> twebb
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

If you take a look at the http://git.omapzoom.org tree as opposed to
the official Linux OMAP tree, that things will be more linear to your
2.6.22.18 tree. I'm currently moving our 2.6.22.18 codebase to
2.6.27-rc3 based on the OMAPZOOM tree and it's faring a lot better
then when I tried the official tree.

So use OMAPZOOM to quickly jump ahead and once up-to-date you can
figure out what the next step is to get more towards the official L-O
tree..

Regards
~ Ashwin
