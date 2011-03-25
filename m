From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH/RFC 00/19] OMAP: voltage layer cleanup and restructure
Date: Fri, 25 Mar 2011 15:37:26 +0100
Message-ID: <4D8CA8A6.8060102@ti.com>
References: <1300924833-26745-1-git-send-email-khilman@ti.com> <87lj04xe2t.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42654 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752059Ab1CYOhP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Mar 2011 10:37:15 -0400
In-Reply-To: <87lj04xe2t.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsely <paul@pwsan.com>

On 3/25/2011 1:02 AM, Hilman, Kevin wrote:
> Kevin Hilman<khilman@ti.com>  writes:
>
>> This series is the begining of a voltage layer cleanup and restruture
>> with the primary goal of splitting up voltage domain, voltage
>> processor (VP) and voltage controller (VC) code.
>>
>> The RFC part is for the last 3 patches in the series, and for
>> discussion of how/if to split out the SoC specifics.  As an example, I
>> started on the VC and split out some functionality (setting slave i2c
>> addr, setting PMIC register addresses) into hooks that can be
>> implemented in SoC specific code.  I'd appreciate any input on this
>> approach as well as the types of functions/APIs that should exist at
>> this level.
>
> Based on some more discussions with Paul, I decided on a slightly
> different approach based on a suggestion from Paul.
>
> Rather than create the vc3xxx.c/vc4xxx.c files, instead I create the SoC
> specific functions for the VC in the existing SoC specific PRM code
> (prm2xxx_3xxx.c and prm4xxx.c.)

FWIW, I prefer your original approach :-)

I really think we'd better split the PRCM code by functions instead or 
trying to map the HW partitioning which is purely arbitrary most of the 
time.

This is for that reason that I didn't wanted to split CM to CM1 & CM2. 
These 2 partitions are doing exactly the same stuff than what CM used to do.

In this case, the PRM just contain a bunch a various stuff that are not
necessarily related. VP and VC are both standalone IPs, that are just 
located in the PRM because if was convenient for the HW folks.

So having dedicated file for each functions inside the PRCM is for my 
point of view a much better approach for the long term.

Otherwise, we might end up with one big file that will just mimic the 
mess we have inside the HW.


That being said, as soon as we have defined the functions, moving them 
here and there should not be a big deal.

Benoit
