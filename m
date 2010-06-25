From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 3/9] omap: generic: introduce a single check_revision
Date: Fri, 25 Jun 2010 08:18:33 -0500
Message-ID: <4C24ACA9.3040505@ti.com>
References: <1277259375-18521-1-git-send-email-nm@ti.com>	<1277259375-18521-4-git-send-email-nm@ti.com> <AANLkTikivRbnADYMUJtzAEbjQt6yCNJLvq66tTIfcmnK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43063 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755711Ab0FYNSf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Jun 2010 09:18:35 -0400
In-Reply-To: <AANLkTikivRbnADYMUJtzAEbjQt6yCNJLvq66tTIfcmnK@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

Grazvydas Ignotas had written, on 06/25/2010 04:31 AM, the following:
> On Wed, Jun 23, 2010 at 5:16 AM, Nishanth Menon <nm@ti.com> wrote:
>> Introduce a single omap generic check_revision that routes the
>> request to the right revision of check_revision.
[...]
> 
>> diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
>> index fca73cd..538e170 100644
>> --- a/arch/arm/plat-omap/common.c
>> +++ b/arch/arm/plat-omap/common.c
>> @@ -89,6 +89,18 @@ void __init omap_reserve(void)
>>        omap_vram_reserve_sdram_lmb();
>>  }
>>
>> +void __init omap_check_revision()
> 
> minor nitpick:
> void __init omap_check_revision(void)?
ack. thanks for catching this.

-- 
Regards,
Nishanth Menon
