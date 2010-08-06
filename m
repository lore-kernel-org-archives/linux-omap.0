From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Re: [PM-SR][PATCH 02/12] omap3: voltage: make required variables
 static
Date: Fri, 06 Aug 2010 06:02:26 -0500
Message-ID: <4C5BEBC2.4000302@gmail.com>
References: <1281047052-21346-1-git-send-email-nm@ti.com> <1281047052-21346-3-git-send-email-nm@ti.com> <5A47E75E594F054BAF48C5E4FC4B92AB032401CE64@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:59235 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756181Ab0HFLCa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Aug 2010 07:02:30 -0400
Received: by gyg10 with SMTP id 10so2796921gyg.19
        for <linux-omap@vger.kernel.org>; Fri, 06 Aug 2010 04:02:29 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB032401CE64@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>
Cc: "Menon, Nishanth" <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>

On 08/06/2010 02:39 AM, Gopinath, Thara wrote:
>
>
>>> -----Original Message-----
>>> From: Menon, Nishanth
>>> Sent: Friday, August 06, 2010 3:54 AM
>>> To: linux-omap
>>> Cc: Menon, Nishanth; Kevin Hilman; Gopinath, Thara
>>> Subject: [PM-SR][PATCH 02/12] omap3: voltage: make required variables static
>>>
>>> debugfs voltage_dir - used only by voltage layer and no reason for
>>> others to add data to it, so make it static.
>>> volt_mod have no business being exposed as global. make it static
>>> we dont expose omap3_vp_offs to the world and is __init data,
>>> so make it static.
>>>
>>> This fixes sparse warnings:
>>> arch/arm/mach-omap2/voltage.c:42:15: warning: symbol 'voltage_dir' was not declared. Should it be
>>> static?
>>> arch/arm/mach-omap2/voltage.c:49:5: warning: symbol 'volt_mod' was not declared. Should it be static?
>>> arch/arm/mach-omap2/voltage.c:130:27: warning: symbol 'omap3_vp_offs' was not declared. Should it be
>>> static?
>>>
>>> Cc: Kevin Hilman<khilman@deeprootsystems.com>
>>> Cc: Thara Gopinath<thara@ti.com>
>>>
>>> Signed-off-by: Nishanth Menon<nm@ti.com>
>>> ---
>>>
>>> Note: i had initially considered splitting these into three seperate patches,
>>> but these are too trivial.
>>>
>>> arch/arm/mach-omap2/voltage.c |    6 +++---
>>> 1 files changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
>>> index 3431fa3..1a3d00d 100644
>>> --- a/arch/arm/mach-omap2/voltage.c
>>> +++ b/arch/arm/mach-omap2/voltage.c
>>> @@ -39,14 +39,14 @@
>>> #define VP_TRANXDONE_TIMEOUT	300
>>>
>>> #ifdef CONFIG_PM_DEBUG
>>> -struct dentry *voltage_dir;
>>> +static struct dentry *voltage_dir;
>>> #endif
>>>
>>> /* VP SR debug support */
>>> u32 enable_sr_vp_debug;
>>>
>>> /* PRM voltage module */
>>> -u32 volt_mod;
>>> +static u32 volt_mod;
>>>
>>> /* Voltage processor register offsets */
>>> struct vp_reg_offs {
>>> @@ -127,7 +127,7 @@ static struct omap_vdd_info *vdd_info;
>>> static int no_scalable_vdd;
>>>
>>> /* OMAP3 VP register offsets and other definitions */
>>> -struct __init vp_reg_offs omap3_vp_offs[] = {
>>> +static struct __init vp_reg_offs omap3_vp_offs[] = {
>
> This change is no longer valid after the patch converting vdd id's to
> names. Rest of the two changes have been taken in.

huh where???? kevin's pm branch is what I work on and post to l-o. I am 
not interested if others have a private tree that none in this community 
can see or work with - sorry l-o does not provide me an indication on an 
alternate kernel tree for sr development!

Regards,
Nishanth Menon
