From: Sid Boyce <sboyce@blueyonder.co.uk>
Subject: Re: EHCI on 2.6.32-rc5-git4 + patches
Date: Tue, 03 Nov 2009 20:35:15 +0000
Message-ID: <4AF09403.8080300@blueyonder.co.uk>
References: <4AEC544A.4000304@blueyonder.co.uk>	 <5A47E75E594F054BAF48C5E4FC4B92AB0309C86298@dbde02.ent.ti.com>	 <4AECCB34.9010003@blueyonder.co.uk>	 <4551feaf0911010742j6b68113cgb2e4246ca8b26237@mail.gmail.com>	 <4AEE19F4.70000@blueyonder.co.uk> <20091102070409.GA17351@nokia.com>	 <4AEF8294.4000108@blueyonder.co.uk> <4551feaf0911021728s6587dffchd716ff1241b0373b@mail.gmail.com>
Reply-To: sboyce@blueyonder.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out2.blueyonder.co.uk ([195.188.213.5]:36910 "EHLO
	smtp-out2.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754237AbZKCUfQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Nov 2009 15:35:16 -0500
In-Reply-To: <4551feaf0911021728s6587dffchd716ff1241b0373b@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Robert Nelson <robertcnelson@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 03/11/09 01:28, Robert Nelson wrote:
>> I tried that and various others to get other than the hub enumerated, no
>> luck so far with kernels I have built - no lights on the hub. I am now
>> rebuilding after following the config for the working narcissus build,
>> EHCI looks much the same, so here's hoping.
>> I have another 16G MMC card I am trying on after cross compiling on a
>> Fedora 12 VirtualBox VM.
>> Regards
>> Sid.
> 
> Hi Sid
> 
> I eventually got ehci working today on my tree on launchpad.  But it's
> not that small of a patch once i added all the mach to plat changes...
> 
> However, this commit made all the difference for me, it's currently
> missing from tmlind's tree, the beagleboard needs it to enable power
> to the ehci..
> 
> http://patchwork.kernel.org/patch/55703/
> 
> Regards,

Thanks, I shall give it a try.
Regards
Sid.

-- 
Sid Boyce ... Hamradio License G3VBV, Licensed Private Pilot
Emeritus IBM/Amdahl Mainframes and Sun/Fujitsu Servers Tech Support
Specialist, Cricket Coach
Microsoft Windows Free Zone - Linux used for all Computing Tasks

