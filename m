From: Mark Jackson <mpfj-list@mimc.co.uk>
Subject: Re: DT GPMC SRAM and NOR flash support ?
Date: Fri, 01 Feb 2013 19:39:40 +0000
Message-ID: <510C19FC.8090906@mimc.co.uk>
References: <510BF3D3.3000304@mimc.co.uk> <510BF766.5090608@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mercuryimc.plus.com ([80.229.200.144]:47225 "EHLO
	centos1.newflow.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754566Ab3BATjn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Feb 2013 14:39:43 -0500
In-Reply-To: <510BF766.5090608@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 01/02/13 17:12, Jon Hunter wrote:
> Hi Mark,
>
> On 02/01/2013 10:56 AM, Mark Jackson wrote:
>> There's plenty of DT support going in for NAND flash, but is there any work going on to support NOR
>> flash ?
>
> What board and device are you working that is using NOR? I have a
> OMAP2420 H4 with NOR that I have been doing a bit of maintenance for but
> I don't spend much time on it. Eventually it will have to be done but it
> is always good to know if there is a pressing need.

We have a custom AM335x CPU board (arriving on my desk within the next 
few weeks) that has both NAND and NOR Flash.

>> And how about SRAM chips or other memory mapped devices ?
>
> Not sure about SRAM (trying to think if I have a board with SRAM even),
> but definitely, boards using the GPMC to interface to ethernet chips
> need to be added.

The board also contains an FRAM chip (which is just treated as SRAM).

If you'd anything in the pipeline, I'm glad to help in any testing. 
I've created a custom cape board for the BeagleBone which contains the 
NOR flash and FRAM chips, so I'm not waiting for the new hardware to arrive.

Cheers
Mark J.
