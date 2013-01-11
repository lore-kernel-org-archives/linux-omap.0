From: Chen Gang <gang.chen@asianux.com>
Subject: Re: [PATCH] arch/arm/plat-omap: initializing dma_lch_count, before
 judging omap_dma_reserve_channels
Date: Fri, 11 Jan 2013 19:24:21 +0800
Message-ID: <50EFF665.9050607@asianux.com>
References: <50EE9815.2080402@asianux.com> <50EE9C87.6060407@ti.com> <50EF9D11.6050801@asianux.com> <50EFBEB3.4080207@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from intranet.asianux.com ([58.214.24.6]:6920 "EHLO
	intranet.asianux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752469Ab3AKLXc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Jan 2013 06:23:32 -0500
In-Reply-To: <50EFBEB3.4080207@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: tony@atomide.com, linux@arm.linux.org.uk, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

=E4=BA=8E 2013=E5=B9=B401=E6=9C=8811=E6=97=A5 15:26, Santosh Shilimkar =
=E5=86=99=E9=81=93:
> On Friday 11 January 2013 10:33 AM, Chen Gang wrote:
>> =EF=BF=BD=EF=BF=BD 2013=EF=BF=BD=EF=BF=BD01=EF=BF=BD=EF=BF=BD10=EF=BF=
=BD=EF=BF=BD 18:48, Santosh Shilimkar =D0=B4=EF=BF=BD=EF=BF=BD:
>>> 'omap_dma_reserve_channels' when used is suppose to be from command
>>> line. Hence the proposed fix in the review is the right one.
>>
>>    ok, thank you for your suggestion.
>>
>>    I will send patch v2, also mark you as Signed-of-by.
>>
> Acked-by: is just fine.
>=20
>=20
>=20
  thanks, I have send patch v2 for it, since it is a new subject, so
still use [PATCH] instead of [PATCH v2].

  the subject of the new patch (which has sent) is:
    [PATCH] ARM: OMAP: Fix the use of uninitialized dma_lch_count

  please check, thanks.

--=20
Chen Gang

Asianux Corporation
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
