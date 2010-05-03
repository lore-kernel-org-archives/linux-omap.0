From: Peter Tseng <tsenpet09@gmail.com>
Subject: Re: ARM suspend to disk?
Date: Mon, 03 May 2010 01:11:25 -0400
Message-ID: <4BDE5AFD.9070506@gmail.com>
References: <4BD881A7.2020402@gmail.com> <87y6g6w373.fsf@deeprootsystems.com>	<p2kf96d234e1004301446l255a8cb4h7287e2502934e9fd@mail.gmail.com> <87iq78d295.fsf@deeprootsystems.com> <EAF47CD23C76F840A9E7FCE10091EFAB02C5217E11@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:38331 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752491Ab0ECFLP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 May 2010 01:11:15 -0400
Received: by vws19 with SMTP id 19so1459533vws.19
        for <linux-omap@vger.kernel.org>; Sun, 02 May 2010 22:11:14 -0700 (PDT)
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C5217E11@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Cliff Brake <cliff.brake@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 05/01/2010 03:12 AM, Shilimkar, Santosh wrote:
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Kevin
>> Hilman
>> Sent: Saturday, May 01, 2010 3:36 AM
>> To: Cliff Brake
>> Cc: Peter Tseng; linux-omap@vger.kernel.org
>> Subject: Re: ARM suspend to disk?
>>
>> Cliff Brake <cliff.brake@gmail.com> writes:
>>
>>> On Thu, Apr 29, 2010 at 1:58 PM, Kevin Hilman
>>> <khilman@deeprootsystems.com> wrote:
>>>
>>>> What do you expect to gain from suspend-to-disk + snapshot boot that
>>>> you don't already get from suspend-to-RAM using off-mode?
>>>>
>>>> On OMAP, with off-mode enabled, a suspend to RAM puts the entire OMAP
>>>> into full-chip off, and essentially reboots the ARM when waking up
>>>> from suspend (or idle) already.
>>>
>>> What does the resume process look like in off mode?  Does the resume
>>> pass through the bootloader?  If so, are the bits that detects resume
>>> from "off" available in U-boot?
>>
>> No, it does not pass through the boot loader.
>>
>> In general terms, resume from off-mode is the same to "normal" resume (from
>> retention) except that some additional state has to be restored before
>> continuing where you left off since the ARM core (as well as most the
>> OMAP itself) was turned off.
>>
> On suspend to disk topic, Raghu under Romit's guidance did a 
> prototype few months back as part of his internship using some of the earlier
> ARM work. The whole system snapshot was stored to the MMC card and one 
> can take that MMC card on another board and continue from where it was suspended.
> 
> We should have these patches somewhere.
> 

It would be interesting to see these. Are you able to find these patches
somewhere?

Peter
