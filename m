From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] arch/arm/plat-omap: initializing dma_lch_count, before
 judging omap_dma_reserve_channels
Date: Fri, 11 Jan 2013 12:56:43 +0530
Message-ID: <50EFBEB3.4080207@ti.com>
References: <50EE9815.2080402@asianux.com> <50EE9C87.6060407@ti.com> <50EF9D11.6050801@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36665 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752411Ab3AKH0E (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Jan 2013 02:26:04 -0500
In-Reply-To: <50EF9D11.6050801@asianux.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Chen Gang <gang.chen@asianux.com>
Cc: tony@atomide.com, linux@arm.linux.org.uk, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Friday 11 January 2013 10:33 AM, Chen Gang wrote:
> =D3=DA 2013=C4=EA01=D4=C210=C8=D5 18:48, Santosh Shilimkar =D0=B4=B5=C0=
:
>> 'omap_dma_reserve_channels' when used is suppose to be from command
>> line. Hence the proposed fix in the review is the right one.
>=20
>    ok, thank you for your suggestion.
>=20
>    I will send patch v2, also mark you as Signed-of-by.
>=20
Acked-by: is just fine.

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
