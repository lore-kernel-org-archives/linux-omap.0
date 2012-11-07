From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: OMAP baseline test results for v3.7-rc4
Date: Wed, 7 Nov 2012 14:56:07 -0600
Message-ID: <509ACAE7.5030707@ti.com>
References: <alpine.DEB.2.00.1211050241410.23228@utopia.booyaka.com> <509A96DA.2010003@ti.com> <alpine.DEB.2.00.1211071728310.20704@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54536 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752093Ab2KGU4N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Nov 2012 15:56:13 -0500
In-Reply-To: <alpine.DEB.2.00.1211071728310.20704@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


On 11/07/2012 11:32 AM, Paul Walmsley wrote:
> On Wed, 7 Nov 2012, Jon Hunter wrote:
> 
>> On 11/04/2012 08:46 PM, Paul Walmsley wrote:
>>
>>> * 4460pandaes: boot fails early
>>>   - Appears to be due to X-loader problems here
>>>   - Need to note the X-loader version so we know it's broken
>>
>> Are you still planning to investigate this further or migrate to a new
>> bootloader?
> 
> Yes.  The problem with the current boot setup is that the new 
> bootloader is breaking as well! :-(
> 
> This can be seen by comparing:
> 
> http://www.pwsan.com/omap/testlogs/test_v3.7-rc1/20121017205513/boot/4460pandaes/4460pandaes_log.txt
> 
> (the old bootloader)
> 
> with
> 
> http://www.pwsan.com/omap/testlogs/test_v3.7-rc4/20121104142910/boot/4460pandaes/4460pandaes_log.txt
> 
> (the new bootloader)
> 
> Dealing with this will require hands-on access, and unfortunately, right 
> now I am traveling and away from my testbed.  Next week, will take a 
> closer look.
> 
>> With 4460 and 3.7-rc4, I am seeing that resume from suspend is not
>> working (not sure when this broke though). I am just curious if anyone
>> else sees this. My u-boot version is v2012.10.
> 
> If you have the chance, it would be useful to know if any of the v3.7-rcs 
> worked.  Otherwise, will look at this next week.

Kevin pointed me to his pm fixes for 3.8 as it is working there and I
have confirmed suspend is fixed on v3.7-rc4 with the rom code fix [1]
Kevin has queued for v3.8.

Cheers
Jon

[1]
http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git;a=commit;h=ff999b8a0983ee15668394ed49e38d3568fc6859
