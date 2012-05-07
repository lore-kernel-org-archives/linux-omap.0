From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCH 3/3] ARM: OMAP2+ PM: Add support for TPS62361
Date: Mon, 7 May 2012 09:32:19 -0500
Message-ID: <CAOMWX4foaNJxRqeun-i0XmupmrNPz17DaB11MD4AKUvxu_6o_g@mail.gmail.com>
References: <1336139842-845-1-git-send-email-t-kristo@ti.com>
 <1336139842-845-4-git-send-email-t-kristo@ti.com> <20120504220046.GA20795@senorita.am.dhcp.ti.com>
 <1336376299.2149.249.camel@sokoban>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:34554 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756099Ab2EGOcm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 May 2012 10:32:42 -0400
Received: by wgbfm10 with SMTP id fm10so5228175wgb.34
        for <linux-omap@vger.kernel.org>; Mon, 07 May 2012 07:32:40 -0700 (PDT)
In-Reply-To: <1336376299.2149.249.camel@sokoban>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: t-kristo@ti.com
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org, Vishwanath BS <vishwanath.bs@ti.com>

On Mon, May 7, 2012 at 2:38 AM, Tero Kristo <t-kristo@ti.com> wrote:
>
>> One more point to consider is that with this - we *should* disable
>> VCORE3 and VMEM else we can have weird behavior such as those seen
>> by pandaboard-ES early adopters.
>
> In what case are we seeing such? If the regulators should be disabled,
> maybe we should do it already in bootloader.
We deal with tons of bootloaders - each platform tends to have their
own custom bootloaders. kernel should always assume bootloader guys
screw up and it is upto kernel to ensure that it keeps the platform
stable at all points of time. TWL6030 does detect short if any
LDO/SMPS is not connected but switched on. so it is necessary to
ensure on 4460 that VCORE3 and VMEM are completely switched off in
kernel no matter what the heck the bootloader decides to do.

Regards,
Nishanth Menon
