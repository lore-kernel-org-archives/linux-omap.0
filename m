From: Dave Martin <dave.martin@linaro.org>
Subject: Re: [PATCH v2 2/3] ARM: omap4: Correct definition of do_wfi() forCONFIG_THUMB2_KERNEL
Date: Wed, 8 Dec 2010 11:40:13 +0000
Message-ID: <AANLkTik8=8HdzvKS8aLh3=-QncDf3v_kC8PkjnJEvZqS@mail.gmail.com>
References: <1291656937-24992-1-git-send-email-dave.martin@linaro.org>
	<1291656937-24992-3-git-send-email-dave.martin@linaro.org>
	<a86d8e4b47fad17e71d0202f3c469868@mail.gmail.com>
	<AANLkTinPifchS23j5EdrhMBNNdtEfF_KmX=AE9tUiiL=@mail.gmail.com>
	<20101207192906.GA28724@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f172.google.com ([209.85.214.172]:49440 "EHLO
	mail-iw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754758Ab0LHLkO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Dec 2010 06:40:14 -0500
Received: by iwn40 with SMTP id 40so1495584iwn.3
        for <linux-omap@vger.kernel.org>; Wed, 08 Dec 2010 03:40:14 -0800 (PST)
In-Reply-To: <20101207192906.GA28724@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linaro-dev@lists.linaro.org, linux-arm-kernel@lists.infradead.org

On Tue, Dec 7, 2010 at 7:29 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Dec 07, 2010 at 04:50:50PM +0000, Dave Martin wrote:
>> I'll follow up shortly with a patch to the generic ARM Kconfig to ma=
ke
>> this explicit, so that ARCH_OMAP2 and THUMB2_KERNEL can't accidental=
ly
>> be configured together.
>
> That's a rubbish dependency. =A0You may have an ARCH_OMAP2 platform w=
hich
> is Cortex A9, and you only have Cortex A9 support selected. =A0In tha=
t
> case there's no reason to prevent THUMB2_KERNEL being selected.
>
> The right thing to do is to make THUMB2_KERNEL depend on those CPUs
> which are not to be selected - not by making it depend on some platfo=
rm
> configuration option(s) which aren't actually relevent.
>

You're correct on this point-- this was my conclusion also.

If you haven't already, take a look at my other post
http://www.spinics.net/lists/arm-kernel/msg106576.html

Does this address your concern?

Cheers
---Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
