From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: getting 2.6.25 from git to run on omap35x evm
Date: Thu, 18 Sep 2008 14:27:42 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301A057E48D@dbde02.ent.ti.com>
References: <dbdb2ea60809171136v5a380989mf57aca6ff1df5aba@mail.gmail.com>
	 <ADBD1DC1-66B1-4EE2-92D8-051C5B91FC1C@student.utwente.nl>
 <dbdb2ea60809171223h7ef92c3dg6a4d41f29b9b8c1e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47456 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753611AbYIRI54 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Sep 2008 04:57:56 -0400
In-Reply-To: <dbdb2ea60809171223h7ef92c3dg6a4d41f29b9b8c1e@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: twebb <taliaferro62@gmail.com>, Koen Kooi <k.kooi@student.utwente.nl>
Cc: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

 

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of twebb
> Sent: Thursday, September 18, 2008 12:54 AM
> To: Koen Kooi
> Cc: linux-omap@vger.kernel.org Mailing List
> Subject: Re: getting 2.6.25 from git to run on omap35x evm
> 
> On Wed, Sep 17, 2008 at 2:59 PM, Koen Kooi 
> <k.kooi@student.utwente.nl> wrote:
> >
> > Why 2.6.25? Git has 2.6.26 already and currenly is at 2.6.27rc6, so 
> > why go from one obsolete version to another obsolete one? .27rc is 
> > pretty broken on the EVM atm, ut .26 should work fine.
> >
> Was going with 2.6.25 because once I get basic functionality 
> on the EVM with linux-omap-2.6.25, next step is applying a 
> separate 2.6.25-based patch.  So 2.6.26 should work OK on 
> 35xEVM?  If so, I'll see if patch applies without problems 
> and give it a try.
> 
> Does anyone (TI?) know how far apart their linux-2.6.22.18 
> (SDK 1.0.0) is from the linux-omap-2.6.git

My team is working on supporting OMAP35x with linux-omap-2.6 git.
Some of the patches you notice on this list come for this effort. 

Since the mailine is changing daily, we may not be able to provide the SDK on the latest kernel version. However, patches generated towards SDK development will be posted on this list regularly. Your 'refresh' against the linux-omap-2.6 git should go more smoothly.

> and when they might converge?

I cannot commit on a time frame; but effort has started, and we have made good progress.

> Along these lines, which defconfig to use 
> for OMAP35x EVM:  SDK = omap3evm_defconfig or 
> linux-omap-2.6.25 = omap3_evm_defconfig (different names and 
> different contents)?

If you are importing specific patches over the 2.6.22-18 kernel (from SDK release) then I suggest you use update omap3evm_defconfig (name doesn't matter - but for easy diff).

> 
> Thanks.
> twebb
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in the body of a message to 
> majordomo@vger.kernel.org More majordomo info at  
> http://vger.kernel.org/majordomo-info.html
> 
> 