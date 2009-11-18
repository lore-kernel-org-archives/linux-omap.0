From: Sid Boyce <sboyce@blueyonder.co.uk>
Subject: Re: Is the OMAP patch process badly flawed?
Date: Wed, 18 Nov 2009 03:20:45 +0000
Message-ID: <4B03680D.6010808@blueyonder.co.uk>
References: <20091116160402.deb0cc82.sfr@canb.auug.org.au>	 <4B0213AC.6050502@blueyonder.co.uk>	 <4B02A583.8090602@blueyonder.co.uk> <94a0d4530911171407r6e1f378al9acb3b985196158b@mail.gmail.com>
Reply-To: sboyce@blueyonder.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out3.blueyonder.co.uk ([195.188.213.6]:41314 "EHLO
	smtp-out3.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753908AbZKRDUq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Nov 2009 22:20:46 -0500
Received: from [172.23.170.147] (helo=anti-virus03-10)
	by smtp-out3.blueyonder.co.uk with smtp (Exim 4.52)
	id 1NAb6B-0000G1-6x
	for linux-omap@vger.kernel.org; Wed, 18 Nov 2009 03:20:51 +0000
Received: from [94.171.130.58] (helo=[192.168.10.2])
	by asmtp-out1.blueyonder.co.uk with esmtpa (Exim 4.52)
	id 1NAb6A-00050T-PC
	for linux-omap@vger.kernel.org; Wed, 18 Nov 2009 03:20:50 +0000
In-Reply-To: <94a0d4530911171407r6e1f378al9acb3b985196158b@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 17/11/09 22:07, Felipe Contreras wrote:
> On Tue, Nov 17, 2009 at 3:30 PM, Sid Boyce <sboyce@blueyonder.co.uk> wrote:
>> I'm curious - I download, build and test kernels on x86 and x86_64
>> platforms, -rc, -rc-git and -git all build and run.
> 
> [...]
> 
>> I would expect patches sent upstream would result in all the basics for
>> long established platforms to be fully covered. Appreciating that
>> development is quite fast paced with mods and supporting new platforms.
>> Could someone please enlighten me?
> 
> Previously all the linux-omap work had to be queued through the
> linux-arm tree, that made it a bit difficult to push things to the
> mainline, but now Tony is sending the pull requests directly to Linus,
> so maybe kernels post 2.6.32 will be much better.
> 
I certainly hope so, it would be nice for the mainline to catch up so we
can work from the one code base.

> However, the only way to make sure that there's good OMAP support in
> Linux is for the community to actively test the mainline and make sure
> the patches are properly pushed and queued, and regressions are found
> quickly, not only on the linux-omap tree, but linux-usb, fbdev, etc.
> Unfortunately we haven't done such a great job on that, perhaps
> because many people use old "stable" aka "frozen" kernels, but things
> are improving.
> 
> Cheers.
> 

Thanks, I use vanilla kernels exclusively on my x86 and x86_64 boxes,
looking for anything that's regressed or broken with API changes.
Regards
Sid.
-- 
Sid Boyce ... Hamradio License G3VBV, Licensed Private Pilot
Emeritus IBM/Amdahl Mainframes and Sun/Fujitsu Servers Tech Support
Specialist, Cricket Coach
Microsoft Windows Free Zone - Linux used for all Computing Tasks

