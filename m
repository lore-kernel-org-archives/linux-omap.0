From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: arm: pmu: support pmu/perf on OMAP4 - booting problem on pandaboard
Date: Wed, 6 Apr 2011 14:07:43 +0800
Message-ID: <BANLkTikxu3DaxWZ88wgCP2cCZD=kNm-YeQ@mail.gmail.com>
References: <4D95E244.1050400@linux.vnet.ibm.com>
	<BANLkTi=nOR=yX=QgbyCoYUE1U7DPxUCCzw@mail.gmail.com>
	<4D99D251.6000901@linux.vnet.ibm.com>
	<BANLkTikmC_OT5TsN_jfVoUjvvcSsR2p3HA@mail.gmail.com>
	<4D99EB4B.3020303@linux.vnet.ibm.com>
	<BANLkTinQ-QQ7zu2KrhhhdWwnzo=a-KynoQ@mail.gmail.com>
	<4D9AF790.7010504@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:44819 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751187Ab1DFGHp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Apr 2011 02:07:45 -0400
Received: by wya21 with SMTP id 21so962942wya.19
        for <linux-omap@vger.kernel.org>; Tue, 05 Apr 2011 23:07:44 -0700 (PDT)
In-Reply-To: <4D9AF790.7010504@linux.vnet.ibm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Avik Sil <aviksil@linux.vnet.ibm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi Avik,

2011/4/5 Avik Sil <aviksil@linux.vnet.ibm.com>:
> Even after using ioremapped addresses in omap_writel() I'm getting the oops.
> Can you please point me to the location in mainline, where these l3 clocks
> are enabled?

I guess you can find here:

         l3_main_3_ick && l3_instr_ick: arch/arm/mach-omap2/clock44xx_data.c

the clocks are set as ENABLE_ON_INIT.

thanks,
-- 
Ming Lei
