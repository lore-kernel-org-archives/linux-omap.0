From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] ARM: OMAP5: id: Remove ES1.0 support
Date: Tue, 8 Oct 2013 17:34:35 -0400
Message-ID: <52547A6B.4010803@ti.com>
References: <5239AE35.8030406@ti.com> <1379513142-11125-1-git-send-email-nm@ti.com> <5239B3B1.5000004@ti.com> <20131008213129.GT8313@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55571 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754418Ab3JHVe7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Oct 2013 17:34:59 -0400
In-Reply-To: <20131008213129.GT8313@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>, Sricharan R <r.sricharan@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Tuesday 08 October 2013 05:31 PM, Tony Lindgren wrote:
> * Santosh Shilimkar <santosh.shilimkar@ti.com> [130918 07:15]:
>> On Wednesday 18 September 2013 10:05 AM, Nishanth Menon wrote:
>>> OMAP5 ES1.0 was intended as a test chip and has major register level
>>> differences w.r.t ES2.0 revision of the chip. All register defines,
>>> dts support has been solely added for ES2.0 version of the chip.
>>> Further, all ES1.0 chips and platforms are supposed to have been
>>> removed from circulation. Hence, there is no need to further retain
>>> any resemblence of ES1.0 support in id detection code.
>>>
>>> Remove the omap_revision handling and BUG() instead to prevent folks
>>> who mistakenly try an older unsupported chip and report bogus errors.
>>>
>>> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>> Signed-off-by: Nishanth Menon <nm@ti.com>
>>> ---
>>> ref: http://marc.info/?l=linux-omap&m=137951198232339&w=2
>>> based on 3.12-rc1 tag
>>>
>> That was quick ...
>> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> 
> Heh, it was made, but not supposed to be used, and still merged
> to mainline kernel..
> 
You know the history. At least for this silicon we avoided
tons of datafiles merges for ES1.0 which changed completely for
ES2.0. At least during that period people had choice to merge
the data-files based on the board they have to test out ;-)

> I guess this is the way to deal with this issue as we don't have
> really any omap5 es1 support in place. So applying into
> omap-for-v3.13/soc branch.
> 
Thanks !!

Regards,
Santosh

