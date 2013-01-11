From: Chen Gang <gang.chen@asianux.com>
Subject: Re: [PATCH] arch/arm/plat-omap: initializing dma_lch_count, before
 judging omap_dma_reserve_channels
Date: Fri, 11 Jan 2013 13:09:33 +0800
Message-ID: <50EF9E8D.40806@asianux.com>
References: <50EE9815.2080402@asianux.com> <50EE9C87.6060407@ti.com> <50EE9D35.6060300@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from intranet.asianux.com ([58.214.24.6]:56051 "EHLO
	intranet.asianux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751549Ab3AKFIl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Jan 2013 00:08:41 -0500
In-Reply-To: <50EE9D35.6060300@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: tony@atomide.com, linux@arm.linux.org.uk, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

=E4=BA=8E 2013=E5=B9=B401=E6=9C=8810=E6=97=A5 18:51, Santosh Shilimkar =
=E5=86=99=E9=81=93:
> Another thing. please fix the subject line. It should be something li=
ke
> below.
>=20
> ARM: OMAP: Fix the use of uninitialized dma_lch_count

  ok, thank you for your suggestion

  I will use it as subject for patch v2.

  :-)

--=20
Chen Gang

Asianux Corporation
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
