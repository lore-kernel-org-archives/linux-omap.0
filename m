From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: arm: pmu: support pmu/perf on OMAP4 - booting problem on pandaboard
Date: Tue, 5 Apr 2011 10:03:36 +0800
Message-ID: <BANLkTinQ-QQ7zu2KrhhhdWwnzo=a-KynoQ@mail.gmail.com>
References: <4D95E244.1050400@linux.vnet.ibm.com>
	<BANLkTi=nOR=yX=QgbyCoYUE1U7DPxUCCzw@mail.gmail.com>
	<4D99D251.6000901@linux.vnet.ibm.com>
	<BANLkTikmC_OT5TsN_jfVoUjvvcSsR2p3HA@mail.gmail.com>
	<4D99EB4B.3020303@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:41678 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751438Ab1DECDh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Apr 2011 22:03:37 -0400
Received: by gyd10 with SMTP id 10so2403499gyd.19
        for <linux-omap@vger.kernel.org>; Mon, 04 Apr 2011 19:03:36 -0700 (PDT)
In-Reply-To: <4D99EB4B.3020303@linux.vnet.ibm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Avik Sil <aviksil@linux.vnet.ibm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi,

2011/4/5 Avik Sil <aviksil@linux.vnet.ibm.com>:
> #define OMAP4430_CM_L3INSTR_L3_3_CLKCTRL
> OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CORE_INST, 0x0720)
> [...]
>
> Should I use those identifier instead?

Yes, seems right, but you need to use the ioremap addresses of the identifiers.

> Are there other definitions for the identifiers you have used?

As I said  before, these are not needed for mainline, so I didn't try these.


thanks,
-- 
Ming Lei
