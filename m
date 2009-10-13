From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Re: [PATCH] [RFC] omap: 3630: default cpu_is_omap3630 to zero
Date: Tue, 13 Oct 2009 05:14:09 -0500
Message-ID: <4AD452F1.7000309@gmail.com>
References: <1255380685-26765-1-git-send-email-vikram.pandita@ti.com> <7A436F7769CA33409C6B44B358BFFF0C012A856FA5@dlee02.ent.ti.com> <FCCFB4CDC6E5564B9182F639FC35608702FA0D37E8@dbde02.ent.ti.com> <EAF47CD23C76F840A9E7FCE10091EFAB02BB254E67@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.25]:34384 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754213AbZJMKWD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Oct 2009 06:22:03 -0400
Received: by qw-out-2122.google.com with SMTP id 9so823315qwb.37
        for <linux-omap@vger.kernel.org>; Tue, 13 Oct 2009 03:20:56 -0700 (PDT)
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02BB254E67@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>, "Menon, Nishanth" <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Shilimkar, Santosh said the following on 10/13/2009 05:03 AM:
> Has anybody tried building latest linux-omap master ? The build is breaking for other OMAP processors.
>
> CC      arch/arm/mach-omap2/id.o
> arch/arm/mach-omap2/id.c: In function 'omap3_cpuinfo':
> arch/arm/mach-omap2/id.c:269: error: implicit declaration of function 'cpu_is_omap3630'
> make[1]: *** [arch/arm/mach-omap2/id.o] Error 1
> make: *** [arch/arm/mach-omap2] Error 2
>
> This is because of " 0a9b95f21995aa3cdda82ebc6e77b0b2ab401861"
> 	omap: Introduce OMAP3630
>
> Below patch from Vikram fixes the build break.
>   
ouch.. my bad.. thanks for answering my question. I am guessing we need
this coz of is_omap3630() translation..
Ack for the patch from me.
Regards,
Nishanth Menon
