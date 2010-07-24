From: Hari Kanigeri <hari.kanigeri@gmail.com>
Subject: Re: [RFC 7/8] TILER-DMM: Main TILER driver implementation.
Date: Sat, 24 Jul 2010 07:41:54 -0600
Message-ID: <AANLkTi=mXGebEmkLNbJuyNwr0yF9Nk-aZWXaWSiMECxh@mail.gmail.com>
References: <1279927348-21750-1-git-send-email-davidsin@ti.com>
	<1279927348-21750-2-git-send-email-davidsin@ti.com>
	<1279927348-21750-3-git-send-email-davidsin@ti.com>
	<1279927348-21750-4-git-send-email-davidsin@ti.com>
	<1279927348-21750-5-git-send-email-davidsin@ti.com>
	<1279927348-21750-6-git-send-email-davidsin@ti.com>
	<1279927348-21750-7-git-send-email-davidsin@ti.com>
	<1279927348-21750-8-git-send-email-davidsin@ti.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C6255357@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:61276 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754652Ab0GXNlz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 24 Jul 2010 09:41:55 -0400
Received: by gwb20 with SMTP id 20so1016804gwb.19
        for <linux-omap@vger.kernel.org>; Sat, 24 Jul 2010 06:41:54 -0700 (PDT)
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C6255357@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "Sin, David" <davidsin@ti.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Russell King <rmk@arm.linux.org.uk>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "Molnar, Lajos" <molnar@ti.com>

>> +s32 tiler_mmap_blk(struct tiler_block_t *blk, u32 offs, u32 size,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct vm_=
area_struct *vma, u32 voffs)
>> +{
>> + =A0 =A0 u32 v, p, len;
>> +
>> + =A0 =A0 /* don't allow mremap */
>> + =A0 =A0 vma->vm_flags |=3D VM_DONTEXPAND | VM_RESERVED;
> Should we add " VM_LOCKED" as well considering the page swapping =A0?

-- VM_RESERVED serves this purpose right ?

>> +
>> + =A0 =A0 /* mapping must fit into vma */
>> + =A0 =A0 BUG_ON(vma->vm_start > vma->vm_start + voffs ||
>> + =A0 =A0 =A0 =A0 =A0 =A0 vma->vm_start + voffs > vma->vm_start + vo=
ffs + size ||
>> + =A0 =A0 =A0 =A0 =A0 =A0 vma->vm_start + voffs + size > vma->vm_end=
);

Hari
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
