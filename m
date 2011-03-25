From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH/RFC 08/19] OMAP2+: powerdomain: add voltagedomain to
 struct powerdomain
Date: Fri, 25 Mar 2011 10:05:28 +0100
Message-ID: <AANLkTinc=oQv1uuv_=HZHTdrKiaGzTG0nk-Bimjet2_2@mail.gmail.com>
References: <1300924833-26745-1-git-send-email-khilman@ti.com>
	<1300924833-26745-9-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:57218 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752599Ab1CYJF2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Mar 2011 05:05:28 -0400
Received: by qyg14 with SMTP id 14so545478qyg.19
        for <linux-omap@vger.kernel.org>; Fri, 25 Mar 2011 02:05:28 -0700 (PDT)
In-Reply-To: <1300924833-26745-9-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsely <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>

On Thu, Mar 24, 2011 at 1:00 AM, Kevin Hilman <khilman@ti.com> wrote:
> Each powerdomain is associated with a powerdomain. =A0Add an entry to
Do you mean '... with a voltage domain'?

> struct powerdomain where the enclosing voltagedomain can be
> referenced.
>
> Modeled after similar relationship between clockdomains and powerdoma=
ins.
>
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
> =A0arch/arm/mach-omap2/powerdomain.h | =A0 =A07 +++++++
> =A01 files changed, 7 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/=
powerdomain.h
> index 027f40b..cc03a0d 100644
> --- a/arch/arm/mach-omap2/powerdomain.h
> +++ b/arch/arm/mach-omap2/powerdomain.h
> @@ -24,6 +24,8 @@
>
> =A0#include <plat/cpu.h>
>
> +#include "voltage.h"
> +
> =A0/* Powerdomain basic power states */
> =A0#define PWRDM_POWER_OFF =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x0
> =A0#define PWRDM_POWER_RET =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x1
> @@ -78,6 +80,7 @@ struct powerdomain;
> =A0/**
> =A0* struct powerdomain - OMAP powerdomain
> =A0* @name: Powerdomain name
> + * @voltdm: voltagedomain containing this powerdomain
> =A0* @omap_chip: represents the OMAP chip types containing this pwrdm
> =A0* @prcm_offs: the address offset from CM_BASE/PRM_BASE
> =A0* @prcm_partition: (OMAP4 only) the PRCM partition ID containing @=
prcm_offs
> @@ -98,6 +101,10 @@ struct powerdomain;
> =A0*/
> =A0struct powerdomain {
> =A0 =A0 =A0 =A0const char *name;
> + =A0 =A0 =A0 union {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 const char *name;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct voltagedomain *ptr;
> + =A0 =A0 =A0 } voltdm;
> =A0 =A0 =A0 =A0const struct omap_chip_id omap_chip;
> =A0 =A0 =A0 =A0const s16 prcm_offs;
> =A0 =A0 =A0 =A0const u8 pwrsts;
> --
> 1.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
