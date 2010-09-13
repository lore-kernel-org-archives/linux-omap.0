From: Gary Thomas <gary@mlbassoc.com>
Subject: Re: OMAP 3530 McBSP Frame Sync errors
Date: Mon, 13 Sep 2010 05:54:40 -0600
Message-ID: <4C8E1100.6000906@mlbassoc.com>
References: <4C8903CA.9090501@mlbassoc.com> <AANLkTik9ULkprMe9=qGAZj8P0HdaFq9TPfNUGxmBmcwc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hermes.mlbassoc.com ([64.234.241.98]:53659 "EHLO
	mail.chez-thomas.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755080Ab0IMLym (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Sep 2010 07:54:42 -0400
In-Reply-To: <AANLkTik9ULkprMe9=qGAZj8P0HdaFq9TPfNUGxmBmcwc@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 09/13/2010 03:07 AM, Grazvydas Ignotas wrote:
> On Thu, Sep 9, 2010 at 6:56 PM, Gary Thomas<gary@mlbassoc.com>  wrote:
>> I'm trying to use McBSP4 with an external CODEC which is a
>> slave device (i.e. the OMAP generates the Frame Sync pulses)
>> In this mode, the BSP is purely the master of these signals.
>>
>> What can it possibly mean to get Frame Sync errors in this case
>> (I'm reading from the external CODEC)?
>>
>> FYI, my registers look like this:
>>   PCR0: 0x00000f0f
>>   RCR1: 0x00000040, RCR2: 0x00008041
>>   XCR1: 0x00000040, XCR2: 0x00008041
>>   SRGR1: 0x00000f07, SRGR2: 0x0000101f
>>
>> Any ideas or help?
>
> Have you set the right McBSP source clock? It's in DEVCONF1/2 registers.

Yes, the channel works fine, but I only occasionally get errant Frame Sync errors.

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
