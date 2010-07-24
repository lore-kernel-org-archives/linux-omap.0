From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [RFC 7/8] TILER-DMM: Main TILER driver implementation.
Date: Sat, 24 Jul 2010 19:23:00 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C625538C@dbde02.ent.ti.com>
References: <1279927348-21750-1-git-send-email-davidsin@ti.com>
	<1279927348-21750-2-git-send-email-davidsin@ti.com>
	<1279927348-21750-3-git-send-email-davidsin@ti.com>
	<1279927348-21750-4-git-send-email-davidsin@ti.com>
	<1279927348-21750-5-git-send-email-davidsin@ti.com>
	<1279927348-21750-6-git-send-email-davidsin@ti.com>
	<1279927348-21750-7-git-send-email-davidsin@ti.com>
	<1279927348-21750-8-git-send-email-davidsin@ti.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C6255357@dbde02.ent.ti.com>
 <AANLkTi=mXGebEmkLNbJuyNwr0yF9Nk-aZWXaWSiMECxh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35073 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751302Ab0GXNxZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 24 Jul 2010 09:53:25 -0400
In-Reply-To: <AANLkTi=mXGebEmkLNbJuyNwr0yF9Nk-aZWXaWSiMECxh@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hari Kanigeri <hari.kanigeri@gmail.com>
Cc: "Sin, David" <davidsin@ti.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Russell King <rmk@arm.linux.org.uk>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "Molnar, Lajos" <molnar@ti.com>

> -----Original Message-----
> From: Hari Kanigeri [mailto:hari.kanigeri@gmail.com]
> Sent: Saturday, July 24, 2010 7:12 PM
> To: Shilimkar, Santosh
> Cc: Sin, David; linux-arm-kernel@lists.arm.linux.org.uk; linux-
> omap@vger.kernel.org; Tony Lindgren; Russell King; Kanigeri, Hari; Oh=
ad
> Ben-Cohen; Hiremath, Vaibhav; Molnar, Lajos
> Subject: Re: [RFC 7/8] TILER-DMM: Main TILER driver implementation.
>=20
> >> +s32 tiler_mmap_blk(struct tiler_block_t *blk, u32 offs, u32 size,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct v=
m_area_struct *vma, u32 voffs)
> >> +{
> >> + =A0 =A0 u32 v, p, len;
> >> +
> >> + =A0 =A0 /* don't allow mremap */
> >> + =A0 =A0 vma->vm_flags |=3D VM_DONTEXPAND | VM_RESERVED;
> > Should we add " VM_LOCKED" as well considering the page swapping =A0=
?
>=20
> -- VM_RESERVED serves this purpose right ?
>
I think you are right.

Regards,
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
