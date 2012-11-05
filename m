From: Mark Jackson <mpfj-list@mimc.co.uk>
Subject: Re: OMAP baseline test results for v3.7-rc3
Date: Mon, 05 Nov 2012 16:54:28 +0000
Message-ID: <5097EF44.5030706@mimc.co.uk>
References: <alpine.DEB.2.00.1210300229590.12697@utopia.booyaka.com> <508FB226.20604@mimc.co.uk> <alpine.DEB.2.00.1210301143420.12697@utopia.booyaka.com> <79CD15C6BA57404B839C016229A409A83EB51E84@DBDE01.ent.ti.com> <508FE8BA.1080404@ti.com> <50912A6F.1040501@mimc.co.uk> <79CD15C6BA57404B839C016229A409A83EB563F8@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mercuryimc.plus.com ([80.229.200.144]:36272 "EHLO
	centos1.newflow.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754464Ab2KEQyj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Nov 2012 11:54:39 -0500
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EB563F8@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 31/10/12 13:57, Hiremath, Vaibhav wrote:
> On Wed, Oct 31, 2012 at 19:11:03, Mark Jackson wrote:
>> On 30/10/12 14:48, Vaibhav Hiremath wrote:
>>
>> Okay, so I'm now coming up against a brick wall regarding U-Boot.
>>
>> The Kernel boots fine (as per the tree + patch above) provided I build U-Boot using the
>> v2011.09_AM335xPSP_04.06.00.06 branch from git://arago-project.org/git/projects/u-boot-am33x.git
>>
>> If I try the latest mainline U-Boot (or the TI branch), I just get to "Starting kernel ..." and then
>> hangs.
>>
>> I'm going to raise this query on the U-Boot ML, but can you let me know which U-Boot image you're
>> using ?
>>
> 
> 
> I am using Mainline u-boot and it works for me. Can you paste u-boot boot 
> log and environment variable here?
> 
> Thanks,
> Vaibhav

So I've now spent several days trying to fix this problem, but still no joy.

Did my previous emails give any clue as to where I'm going wrong ?

Thanks for any help you can provide.

Mark J.
