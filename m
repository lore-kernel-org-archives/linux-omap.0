From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: [PATCH 1/3] ARM: OMAP2+: 32k-counter: Use hwmod lookup to check
 presence of 32k timer
Date: Sat, 31 Mar 2012 16:39:36 +0800
Message-ID: <CACVXFVPu1GEQy+sCgXMB8JCszPBBs8zHRVm94TYb1-y2afkqgw@mail.gmail.com>
References: <1326983304-14619-1-git-send-email-hvaibhav@ti.com>
	<1326983304-14619-2-git-send-email-hvaibhav@ti.com>
	<87mx9ej8fp.fsf@ti.com>
	<CACVXFVOqmC0OhT-Dim8dL9pWnmGwO2-Awc4V2Jziyf7DHQdYcQ@mail.gmail.com>
	<79CD15C6BA57404B839C016229A409A83181EF3F@DBDE01.ent.ti.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f52.google.com ([209.85.210.52]:47121 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756144Ab2CaIjh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 31 Mar 2012 04:39:37 -0400
Received: by dake40 with SMTP id e40so442975dak.11
        for <linux-omap@vger.kernel.org>; Sat, 31 Mar 2012 01:39:36 -0700 (PDT)
In-Reply-To: <CAMQu2gzuQ-q+3RHsW0=U305jCF-td5-PEXkGZ6WnQTqA1K8oAQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "Hiremath, Vaibhav" <hvaibhav@ti.com>, "Hilman, Kevin" <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "johnstul@us.ibm.com" <johnstul@us.ibm.com>, "Balbi, Felipe" <balbi@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>

On Sat, Mar 31, 2012 at 2:30 PM, Shilimkar, Santosh
> Since you need to recompile the kernel, you can very much tweak the
> clocksource to use GPTIMER with sysl clock. Support for that is still
> in place.

With current kernel, running 'make menuconfig' can do it, but after applying
Hiremath's patch[1], I have to edit the source code manually to get it, so looks
this kind of tweaking is not friendly enough, :-(

[1], http://marc.info/?l=linux-arm-kernel&m=133311647410324&w=2

Thanks,
-- 
Ming Lei
