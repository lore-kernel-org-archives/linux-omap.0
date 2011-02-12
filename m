From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [PATCH 3/5] ARM: l2x0: Errata fix for flush by Way operation can
 cause data corruption
Date: Sat, 12 Feb 2011 17:17:51 -0600
Message-ID: <AANLkTimjXG5-kEW=1vodnGo3Ct_xOS_HihdqN0TeL9ba@mail.gmail.com>
References: <1297510187-31547-1-git-send-email-santosh.shilimkar@ti.com>
	<1297510187-31547-4-git-send-email-santosh.shilimkar@ti.com>
	<AANLkTimkqZ5datA+7shggbWz3+j=TDg5beUkQK=b1AmK@mail.gmail.com>
	<13596bec9184b117d6a1d02da8e017bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from exprod5og117.obsmtp.com ([64.18.0.149]:42632 "EHLO
	exprod5og117.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752982Ab1BLXRy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 12 Feb 2011 18:17:54 -0500
Received: from il93mgrg01.am.mot-mobility.com ([10.22.94.167])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p1CNGto7023614
	for <linux-omap@vger.kernel.org>; Sat, 12 Feb 2011 18:16:55 -0500 (EST)
Received: from mail-vx0-f170.google.com (mail-vx0-f170.google.com [209.85.220.170])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p1CNGspv023607
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-omap@vger.kernel.org>; Sat, 12 Feb 2011 18:16:55 -0500 (EST)
Received: by vxc38 with SMTP id 38so2354242vxc.15
        for <linux-omap@vger.kernel.org>; Sat, 12 Feb 2011 15:17:52 -0800 (PST)
In-Reply-To: <13596bec9184b117d6a1d02da8e017bf@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>

On Sat, Feb 12, 2011 at 11:59 AM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
>> -----Original Message-----
>> From: Andrei Warkentin [mailto:andreiw@motorola.com]
>> Sent: Saturday, February 12, 2011 11:20 PM
>> To: Santosh Shilimkar
>> Cc: linux-omap@vger.kernel.org; khilman@ti.com; tony@atomide.com;
>> linux-arm-kernel@lists.infradead.org; Catalin Marinas
>> Subject: Re: [PATCH 3/5] ARM: l2x0: Errata fix for flush by Way
>> operation can cause data corruption
>>
> [....]
>
>>
>> Can these PL310 errata fixes be made more generic? PL310 is present
>> in
>> non-OMAP platforms too, which lack the TI hypervisor. And these
>> platforms might have the same PL310 rev, and suffer the same
>> glitches.
>> While ideally there is some kind of hypervisor_ops to modify the
>> protected register, at the very least there should be the generic
>> debug_write handling the =A0"I =A0can write all PL310 regs" case. If
>> you're interested I have a patch someplace that tried to do this,
>> hopefully I can still find it.
>
> They are kind of generic. If you look at it, the only change
> Which is arch specific is the implementation of "debug_writel" functi=
on.
> Today this code is not in generic PL310 code, but
> OMAP specific.
>
> May be we can make this as exported function pointer, which
> arch's can populate.
>
> Will that work for you ?
>
> Regards,
> Santosh
>

Ie something like the following.... what do you think???

#define L2X0_DCR (0xF40)

static void debug_writel(unsigned long val)
{
#ifdef CONFIG_ARCH_OMAP4
       omap_smc1(0x100, val);
#else
       writel_relaxed(val, l2x0_base + L2X0_DCR);
#endif
}
=2E..
=2E..

       /* clean all ways */
       spin_lock_irqsave(&l2x0_lock, flags);
#ifdef CONFIG_PL310_ERRATA_727915
       debug_writel(DCR_DWB | DCR_DCL); <---- not 0x3, but self-documen=
ting
#endif
       writel_relaxed(l2x0_way_mask, l2x0_base + L2X0_CLEAN_INV_WAY);
       cache_wait_way(l2x0_base + L2X0_CLEAN_INV_WAY, l2x0_way_mask);
       cache_sync();
#ifdef CONFIG_PL310_ERRATA_727915
       debug_writel(0x00);
#endif
       spin_unlock_irqrestore(&l2x0_lock, flags);
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
