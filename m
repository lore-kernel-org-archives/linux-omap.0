From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCHv3 4/9] ARM: OMAP2+: AM33XX: Reserve memory to comply with EMIF spec
Date: Thu, 08 Aug 2013 13:05:07 -0700
Message-ID: <87vc3ggd8s.fsf@kernel.org>
References: <1375811376-49985-1-git-send-email-d-gerlach@ti.com>
	<1375811376-49985-5-git-send-email-d-gerlach@ti.com>
	<87fvukhwtv.fsf@kernel.org> <5203F21F.3010801@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:42161 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966063Ab3HHUFN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Aug 2013 16:05:13 -0400
Received: by mail-pa0-f46.google.com with SMTP id fa1so3975324pad.19
        for <linux-omap@vger.kernel.org>; Thu, 08 Aug 2013 13:05:12 -0700 (PDT)
In-Reply-To: <5203F21F.3010801@ti.com> (Santosh Shilimkar's message of "Thu, 8
	Aug 2013 15:31:43 -0400")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Dave Gerlach <d-gerlach@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Vaibhav Bedia <vaibhav.bedia@ti.com>

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> On Thursday 08 August 2013 02:16 PM, Kevin Hilman wrote:
>> Dave Gerlach <d-gerlach@ti.com> writes:
>> 
>>> From: Vaibhav Bedia <vaibhav.bedia@ti.com>
>>>
>>> SDRAM controller on AM33XX requires that a modification of certain
>>> bit-fields in PWR_MGMT_CTRL register (ref. section 7.3.5.13 in
>>> AM335x-Rev H) is followed by a dummy read access to SDRAM. This
>>> scenario arises when entering a low power state like DeepSleep.
>>> To ensure that the read is not from a cached region we reserve
>>> some memory during bootup using the arm_memblock_steal() API.
>> 
>> Hmm, sounds to me an awful lot like the existing omap_bus_sync() ?
>>
> All the credit of that awful omap_bus_sync() goes to me since 
> I introduced it. And I keep beating the hardware guys
> who have not left a choice but to introduce the ugly work
> around in software. ;-)

Agreed, but what's even more awful than the current version is
duplicating it in a slightly different way using yet another whole page
mapping for a single read/write location.

Kevin
