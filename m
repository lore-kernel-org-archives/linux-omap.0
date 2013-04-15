From: Mark Jackson <mpfj-list@mimc.co.uk>
Subject: Re: [PATCH 0/3] Dual EMAC mode implementation of CPSW
Date: Mon, 15 Apr 2013 18:28:25 +0100
Message-ID: <516C38B9.50904@mimc.co.uk>
References: <1360612340-9266-1-git-send-email-mugunthanvnm@ti.com> <516B0098.4040809@mimc.co.uk> <516C33D2.4050105@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mercuryimc.plus.com ([80.229.200.144]:52200 "EHLO
	centos1.newflow.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751550Ab3DOR22 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Apr 2013 13:28:28 -0400
In-Reply-To: <516C33D2.4050105@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mugunthan V N <mugunthanvnm@ti.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On 15/04/13 18:07, Mugunthan V N wrote:
> On 4/15/2013 12:46 AM, Mark Jackson wrote:

<snip>

>>
>> Notice that at the end, the nfs link appears to come back "ok", but
>> the "ps" command never completes.
>>
>> Any ideas of what's going on ?
>
> I have tried ping on both the interface fine. Will verify with ps again
> later in this week.
> Can you provide below details details
> - Are you using EVMsk or custom build EVM?

This is a custom board (based on the BeagleBone design) with dual 
Ethernet, NAND, NOR and FRAM.

The dual emac thing is (one of) the last things to get signed off, so 
I'm willing to assist in tracking this down.

Regards
Mark J.
