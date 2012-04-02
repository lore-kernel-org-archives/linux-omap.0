From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 1/3] ARM: OMAP2+: 32k-counter: Use hwmod lookup to check presence of 32k timer
Date: Mon, 02 Apr 2012 11:35:38 -0700
Message-ID: <87sjgmt211.fsf@ti.com>
References: <1326983304-14619-1-git-send-email-hvaibhav@ti.com>
	<CACVXFVP4J8N271Tww77Btm9fGNiP17MepjswBJ0V-8Z4sNt8Eg@mail.gmail.com>
	<4F672364.3020403@ti.com>
	<79CD15C6BA57404B839C016229A409A83182386C@DBDE01.ent.ti.com>
	<CAMQu2gyFNXgx87Fsq5is88DOkOx-nWK6ohwyFV-CY2uTkZCGMA@mail.gmail.com>
	<79CD15C6BA57404B839C016229A409A83183EA54@DBDE01.ent.ti.com>
	<CAMQu2gyF83HJOE9Rf-fZXXMt=p_WFjFf3DpAeW8L8+htR4E6-g@mail.gmail.com>
	<79CD15C6BA57404B839C016229A409A83183EB47@DBDE01.ent.ti.com>
	<CAMQu2gzYULK+=6-WKQnnQDpzTYW7xKAOZo7obyu2q178jtNE-Q@mail.gmail.com>
	<79CD15C6BA57404B839C016229A409A831840C2E@DBDE01.ent.ti.com>
	<CAMQu2gw7aceHSYSd+UMVS6kHQMqy0_maf8QTJaUMzp9z8822rQ@mail.gmail.com>
	<79CD15C6BA57404B839C016229A409A831840E0C@DBDE01.ent.ti.com>
	<4F7570FC.8000907@ti.com>
	<79CD15C6BA57404B839C016229A409A831840F82@DBDE01.ent.ti.com>
	<CAMQu2gzOkE6LD0WZ_9bKe3J-=Dv89rWaMzvWWvJHPMSPe6MzNg@mail.gmail.com>
	<CACVXFVPbU2OqTN=S0AZCD10KuSBYxqyyRH_xee+WTaCD6VSmMQ@mail.gmail.com>
	<CAMQu2gzuQ-q+3RHsW0=U305jCF-td5-PEXkGZ6WnQTqA1K8oAQ@mail.gmail.com>
	<CACVXFVPu1GEQy+sCgXMB8JCszPBBs8zHRVm94TYb1-y2afkqgw@mail.gmail.com>
	<CAMQu2gwuRpZ133962r3N4Y4K3oQ88ySa=SyoS6v=sSHGA=SGKw@mail.gmail.com>
	<CACVXFVMjSPhF_+CfbF2vD5ts+WtZGjofEWmknB0D1OpTM7geZw@mail.gmail.com>
	<CAMQu2gyEUhDyyng+_oC5NpXHzWMaTGsnCSTTZcMUi2pLV0z8RQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog133.obsmtp.com ([74.125.149.82]:38886 "EHLO
	psmtp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754333Ab2DBSfp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 2 Apr 2012 14:35:45 -0400
Received: by dakh32 with SMTP id h32so2546402dak.23
        for <linux-omap@vger.kernel.org>; Mon, 02 Apr 2012 11:35:41 -0700 (PDT)
In-Reply-To: <CAMQu2gyEUhDyyng+_oC5NpXHzWMaTGsnCSTTZcMUi2pLV0z8RQ@mail.gmail.com>
	(Santosh Shilimkar's message of "Sun, 1 Apr 2012 11:23:44 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Ming Lei <tom.leiming@gmail.com>, Tony Lindgren <tony@atomide.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "johnstul@us.ibm.com" <johnstul@us.ibm.com>, "Balbi, Felipe" <balbi@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>

"Shilimkar, Santosh" <santosh.shilimkar@ti.com> writes:

[...]

> I don't personally like to add features which hardly anybody use and
> fundamentally broken with full kernel.

Let's keep sane defaults, but not make it unreasonable to tweak eaither.

I suggest what has already been mentioned.

Register both timers, but have the sync timer have a higher rating.  On
AMxxx where there is no sync timer, GPtimer will be used.

For those who want to use GPtimer, they can boot using clocksource= to
override the default.

Santosh is right, GPtimer will not work on a PM enabled kernel, but
there are lots of ways to use the cmdline to get a non-working kernel,
so that's OK by me.

Let's just ensure that the boot-defaults are sane.

Kevin




