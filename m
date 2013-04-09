From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v3 2/4] ARM: OMAP4+: PM: Consolidate OMAP4 PM code to
 re-use it for OMAP5
Date: Tue, 9 Apr 2013 11:43:50 +0530
Message-ID: <5163B19E.30105@ti.com>
References: <1365166743-5940-1-git-send-email-santosh.shilimkar@ti.com> <1365166743-5940-3-git-send-email-santosh.shilimkar@ti.com> <20130405213433.GF10155@atomide.com> <5162A093.7090808@ti.com> <20130408164228.GK10155@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47393 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752605Ab3DIGL5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 9 Apr 2013 02:11:57 -0400
In-Reply-To: <20130408164228.GK10155@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: khilman@deeprootsystems.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Monday 08 April 2013 10:12 PM, Tony Lindgren wrote:
> * Santosh Shilimkar <santosh.shilimkar@ti.com> [130408 03:51]:
>> On Saturday 06 April 2013 03:04 AM, Tony Lindgren wrote:
>>> * Santosh Shilimkar <santosh.shilimkar@ti.com> [130405 06:01]:
>>>> OMAP5 has backward compatible PRCM block and it's programming
>>>> model is mostly similar to OMAP4. Same is going to be maintained
>>>> for future OMAP4 based SOCs. Hence consolidate the OMAP4 power
>>>> management code so that it can be re-used on OMAP5 and later devices.
>>>>
>>>> While at it, update the kernel-doc for omap4_pm_init().
>>>>
>>>> Acked-by: Nishanth Menon <nm@ti.com>
>>>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>>> ---
>>>>  arch/arm/mach-omap2/Makefile                       |    9 +--
>>>>  arch/arm/mach-omap2/{pm44xx.c => pm_omap4plus.c}   |   58 ++++++++++++++++----
>>>>  .../mach-omap2/{sleep44xx.S => sleep_omap4plus.S}  |    0
>>>>  3 files changed, 53 insertions(+), 14 deletions(-)
>>>>  rename arch/arm/mach-omap2/{pm44xx.c => pm_omap4plus.c} (83%)
>>>>  rename arch/arm/mach-omap2/{sleep44xx.S => sleep_omap4plus.S} (100%)
>>>
>>> I suggest you leave out the rename. That just adds churn and has
>>> flame potential.
>>>
>> OK. I can leave that mow but have to do renames anyways when
>> I add OMAP5 support. OMAP54XX support inside pm44xx.c and sleep44x.S
>> will be really odd.
> 
> Well that should be just fine if the hardware is the same.
>  
>> Let me know if you have concern on renaming it while OMAP5 support
>> gets added ?
> 
> If the rename is done, it should have a clear reason to do it in
> a separate patch. IMHO it's just fine to have omap4 in some name and
> then assume that at least some follow up SoCs also use that code.
> In the worst case we may end up renaming things many times:
>
Agree. omap4_* is just fine and thats why many omap4_* are not renamed.
Here the files were calling specific family of OMAP4 i.e OMAP44XX and
hence the rename was appropriate.
 
> omap-xyz.c -> omap2-xyz.c -> omap2plus-xyz.c -> omap2-to-4-xyz.c ->
> omap2-to-4-and-am35xx-xyz.c etc :)
> 
pm_omap4plus.c and sleep_omap4plus.S was chosen specifically considering
the OMAP4+ devices share the PRCM IP. But PRCM_IP itself isn't new so
calling by IP wasn't an option.

> If we rename something, the description should have a clear reason
> for doing it like "To avoid confusing between PM code that does not
> have support for bootrom assisted off-idle on SMP omaps with PM code
> that's not bootrom assisted, let's rename foo to.."
> 
> For the naming, the only safe naming convention is to use something
> actually describing the piece of hardware. Maybe some combination
> of bootrom-assisted-off-idle + SMP in this case if there's no actual
> name for this hwblock?
> 
As I said, the IP has been there from OMAP2XX days. Here the case that
IP version is very similar between OMAP4, OMAP5. DRA(next SOC) and its
derivatives. Hence can share most of the code. I thought this was good
enough reason considering at least 4 family of SOC's can make use
of the code.

It has nothing to do with SMP etc specifically and rather the similarity
between the PM infrastructure on the mentioned SOCs. 

Let me know if you can suggested better name than what I chose ?

Regards,
Santosh
