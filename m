From: Chen Gang <gang.chen@asianux.com>
Subject: Re: [PATCH] arch/arm/plat-omap: initializing dma_lch_count, before
 judging omap_dma_reserve_channels
Date: Fri, 11 Jan 2013 13:03:13 +0800
Message-ID: <50EF9D11.6050801@asianux.com>
References: <50EE9815.2080402@asianux.com> <50EE9C87.6060407@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from intranet.asianux.com ([58.214.24.6]:8545 "EHLO
	intranet.asianux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752552Ab3AKFC0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Jan 2013 00:02:26 -0500
In-Reply-To: <50EE9C87.6060407@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: tony@atomide.com, linux@arm.linux.org.uk, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

=D3=DA 2013=C4=EA01=D4=C210=C8=D5 18:48, Santosh Shilimkar =D0=B4=B5=C0=
:
> 'omap_dma_reserve_channels' when used is suppose to be from command
> line. Hence the proposed fix in the review is the right one.

  ok, thank you for your suggestion.

  I will send patch v2, also mark you as Signed-of-by.

  :-)

--=20
Chen Gang

Asianux Corporation
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
