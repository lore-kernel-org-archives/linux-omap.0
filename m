From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: omapfb: no driver for display
Date: Sat, 19 Feb 2011 18:00:50 +0800
Message-ID: <AANLkTinUO69HYZUUQ-NzyB_LDLvvfBnLqtSDKimu0xy3@mail.gmail.com>
References: <AANLkTi=f=SKE=QR97ttPnBrpW=2wNGd03+q4agmu6Uap@mail.gmail.com>
	<AANLkTikpCcpkjb8i_8Gk5ey1FtgsaUenmKNDhrtjLqon@mail.gmail.com>
	<AANLkTinoLOyqBCMNKbpcJMhZHnncX1T07nbfsTThA_a4@mail.gmail.com>
	<4D5DF547.7010703@ti.com>
	<AANLkTik_H0vAEjB8tOyJNC4oDS1+Tp5ick0mq4jhhqMV@mail.gmail.com>
	<AANLkTimt934X7G8DSnqVQ03fbggD9-SHWW3-QPQp+yAq@mail.gmail.com>
	<AANLkTikSU_QgRNahQU3Rrb1KZ0vCNZ4FTz59hOmDaaUD@mail.gmail.com>
	<AANLkTi=piR+YKvJi+_B4fZk6TtQA_drPEAyKKcMa0oZN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:58519 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752591Ab1BSKAv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 19 Feb 2011 05:00:51 -0500
Received: by yxt3 with SMTP id 3so1952988yxt.19
        for <linux-omap@vger.kernel.org>; Sat, 19 Feb 2011 02:00:50 -0800 (PST)
In-Reply-To: <AANLkTi=piR+YKvJi+_B4fZk6TtQA_drPEAyKKcMa0oZN@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: archit taneja <archit@ti.com>, Sung Hee Park <shpark7@stanford.edu>, Bryan Wu <bryan.wu@canonical.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Semwal, Sumit" <sumit.semwal@ti.com>

Hi,

2011/2/19 Felipe Contreras <felipe.contreras@gmail.com>:
> Are you sure? AFAIK early_param is executed _after_ memory blocks are reserved.

Yes, I am sure.

If 'vram=16M' is passed in, I can find the below:

    [    0.000000] Memory: 1008MB = 1008MB total

but if 'vram=8M' is taken, will be

    [    0.000000] Memory: 1016MB = 1016MB total

You may have a try on your board to confirm it.


thanks,
-- 
Lei Ming
