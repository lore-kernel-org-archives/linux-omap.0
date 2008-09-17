From: twebb <taliaferro62@gmail.com>
Subject: Re: getting 2.6.25 from git to run on omap35x evm
Date: Wed, 17 Sep 2008 15:23:30 -0400
Message-ID: <dbdb2ea60809171223h7ef92c3dg6a4d41f29b9b8c1e@mail.gmail.com>
References: <dbdb2ea60809171136v5a380989mf57aca6ff1df5aba@mail.gmail.com>
	 <ADBD1DC1-66B1-4EE2-92D8-051C5B91FC1C@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.175]:2306 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755727AbYIQTXb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Sep 2008 15:23:31 -0400
Received: by wf-out-1314.google.com with SMTP id 27so3158857wfd.4
        for <linux-omap@vger.kernel.org>; Wed, 17 Sep 2008 12:23:30 -0700 (PDT)
In-Reply-To: <ADBD1DC1-66B1-4EE2-92D8-051C5B91FC1C@student.utwente.nl>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>
Cc: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

On Wed, Sep 17, 2008 at 2:59 PM, Koen Kooi <k.kooi@student.utwente.nl> wrote:
>
> Why 2.6.25? Git has 2.6.26 already and currenly is at 2.6.27rc6, so why go
> from one obsolete version to another obsolete one? .27rc is pretty broken on
> the EVM atm, ut .26 should work fine.
>
Was going with 2.6.25 because once I get basic functionality on the
EVM with linux-omap-2.6.25, next step is applying a separate
2.6.25-based patch.  So 2.6.26 should work OK on 35xEVM?  If so, I'll
see if patch applies without problems and give it a try.

Does anyone (TI?) know how far apart their linux-2.6.22.18 (SDK 1.0.0)
is from the linux-omap-2.6.git and when they might converge?  Along
these lines, which defconfig to use for OMAP35x EVM:  SDK =
omap3evm_defconfig or linux-omap-2.6.25 = omap3_evm_defconfig
(different names and different contents)?

Thanks.
twebb
