From: Mark Jackson <mpfj-list@mimc.co.uk>
Subject: Re: DT GPMC SRAM and NOR flash support ?
Date: Tue, 05 Feb 2013 16:16:12 +0000
Message-ID: <5111304C.7090706@mimc.co.uk>
References: <510BF3D3.3000304@mimc.co.uk> <510BF766.5090608@ti.com> <510C19FC.8090906@mimc.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mercuryimc.plus.com ([80.229.200.144]:37086 "EHLO
	centos1.newflow.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754248Ab3BEQQN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Feb 2013 11:16:13 -0500
In-Reply-To: <510C19FC.8090906@mimc.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 01/02/13 19:39, Mark Jackson wrote:
> On 01/02/13 17:12, Jon Hunter wrote:
>> Hi Mark,
>>
>> On 02/01/2013 10:56 AM, Mark Jackson wrote:
>>> There's plenty of DT support going in for NAND flash, but is there any work going on to support NOR
>>> flash ?
>>
>> What board and device are you working that is using NOR? I have a
>> OMAP2420 H4 with NOR that I have been doing a bit of maintenance for but
>> I don't spend much time on it. Eventually it will have to be done but it
>> is always good to know if there is a pressing need.
> 
> We have a custom AM335x CPU board (arriving on my desk within the next few weeks) that has both NAND
> and NOR Flash.
> 
>>> And how about SRAM chips or other memory mapped devices ?
>>
>> Not sure about SRAM (trying to think if I have a board with SRAM even),
>> but definitely, boards using the GPMC to interface to ethernet chips
>> need to be added.
> 
> The board also contains an FRAM chip (which is just treated as SRAM).
> 
> If you'd anything in the pipeline, I'm glad to help in any testing. I've created a custom cape board
> for the BeagleBone which contains the NOR flash and FRAM chips, so I'm not waiting for the new
> hardware to arrive.

I've experimented with trying to add a mtd-physmap device, but no joy.

I'm guessing that the current mtd-physmap code is (in some way) currently incompatible with the GPMC
device ?

Mark J.


