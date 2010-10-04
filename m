From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH 02/14] omap: Map only available sram memory
Date: Tue, 5 Oct 2010 02:44:09 +0300
Message-ID: <AANLkTi=wbRKvjTmVwE+Svx1SGS1HgAh74KcN_Y6Xwmin@mail.gmail.com>
References: <1284716878-27667-1-git-send-email-santosh.shilimkar@ti.com>
	<1284716878-27667-2-git-send-email-santosh.shilimkar@ti.com>
	<1284716878-27667-3-git-send-email-santosh.shilimkar@ti.com>
	<AANLkTi=PM1x7zXbSMRxBHVZ5Z2+4iwebvbiGizca_rC8@mail.gmail.com>
	<20101001225303.GF3117@atomide.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB030CDFE18C@dbde02.ent.ti.com>
	<AANLkTi=zmgSCCg71NsYMte9K-yeyb1i0VxCA4i_9Y8D-@mail.gmail.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB030CDFE61A@dbde02.ent.ti.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB030CDFE85B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:60784 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755470Ab0JDXoL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Oct 2010 19:44:11 -0400
Received: by yxp4 with SMTP id 4so1827119yxp.19
        for <linux-omap@vger.kernel.org>; Mon, 04 Oct 2010 16:44:11 -0700 (PDT)
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB030CDFE85B@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>

> Looks like for you " is_sram_locked" function is failing. There was a patch
> in my series from Vikram which was fixing this API.
>
> Do you have this patch applied when you are trying this out ?
> http://www.spinics.net/linux/lists/arm-kernel/msg98697.html

Well it looks like this only happens on linux-next (was using
next-20101001 version) with this defconfig:
http://notaz.gp2x.de/misc/pnd/config_next_101001_2

this has yours and Vikram's patch you mentioned in. Using
omap2plus_defconfig on linux-next or this "bad" defconfig on
linux-omap boots fine, strange.
