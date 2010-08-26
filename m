From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 3/3] davinci: Map sram using MT_MEMORY_NONCACHED instead  of MT_DEVICE
Date: Thu, 26 Aug 2010 14:37:28 -0700
Message-ID: <87hbih2gyv.fsf@deeprootsystems.com>
References: <1281262702-27732-1-git-send-email-santosh.shilimkar@ti.com>
	<AANLkTi=9k19RUmfnNBO8AfFj_LtyNtsPPVYC_=-AW5yE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:39249 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751943Ab0HZVhb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Aug 2010 17:37:31 -0400
Received: by pzk9 with SMTP id 9so786084pzk.19
        for <linux-omap@vger.kernel.org>; Thu, 26 Aug 2010 14:37:31 -0700 (PDT)
In-Reply-To: <AANLkTi=9k19RUmfnNBO8AfFj_LtyNtsPPVYC_=-AW5yE@mail.gmail.com>
	(Kevin Hilman's message of "Thu, 19 Aug 2010 11:29:27 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, davinci-linux-open-source@linux.davincidsp.com

Kevin Hilman <khilman@deeprootsystems.com> writes:

> On Sun, Aug 8, 2010 at 3:18 AM, Santosh Shilimkar
> <santosh.shilimkar@ti.com> wrote:
>> On Davinci SRAM is mapped as MT_DEVICE becasue of the section
>> mapping pre-requisite instead of intended MT_MEMORY_NONCACHED
>>
>> Since the section mapping limitation gets fixed with first
>> patch in this series, the MT_MEMORY_NONCACHED can be used now.
>>
>> Have not tested this, so somebody with Davinci hardware can
>> try this out
>>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> Cc: davinci-linux-open-source@linux.davincidsp.com
>> Cc: Kevin Hilman <khilman@deeprootsystems.com>
>
> Acked-by: Kevin Hilman <khilman@deeprootsystems.com>

Also, FYI... while not a very thorough test, I boot-tested this series
on DaVinci (dm355, omapl138) and it worked fine.

I'll include in davinci git (in the davinci-testing branch) so it gets a
bit more testing.

Kevin
