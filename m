From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: omapfb: no driver for display
Date: Sat, 19 Feb 2011 20:40:37 +0800
Message-ID: <AANLkTin1=fQOcUTgWNefW2UC-U3Dx38iJOu_sK_TayBD@mail.gmail.com>
References: <AANLkTi=f=SKE=QR97ttPnBrpW=2wNGd03+q4agmu6Uap@mail.gmail.com>
	<AANLkTikpCcpkjb8i_8Gk5ey1FtgsaUenmKNDhrtjLqon@mail.gmail.com>
	<AANLkTinoLOyqBCMNKbpcJMhZHnncX1T07nbfsTThA_a4@mail.gmail.com>
	<4D5DF547.7010703@ti.com>
	<AANLkTik_H0vAEjB8tOyJNC4oDS1+Tp5ick0mq4jhhqMV@mail.gmail.com>
	<AANLkTimt934X7G8DSnqVQ03fbggD9-SHWW3-QPQp+yAq@mail.gmail.com>
	<AANLkTikSU_QgRNahQU3Rrb1KZ0vCNZ4FTz59hOmDaaUD@mail.gmail.com>
	<AANLkTi=piR+YKvJi+_B4fZk6TtQA_drPEAyKKcMa0oZN@mail.gmail.com>
	<AANLkTinUO69HYZUUQ-NzyB_LDLvvfBnLqtSDKimu0xy3@mail.gmail.com>
	<4D5F9F3B.6000507@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:63960 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751376Ab1BSMki (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 19 Feb 2011 07:40:38 -0500
Received: by gxk9 with SMTP id 9so1858124gxk.19
        for <linux-omap@vger.kernel.org>; Sat, 19 Feb 2011 04:40:37 -0800 (PST)
In-Reply-To: <4D5F9F3B.6000507@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: archit taneja <archit@ti.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>, Sung Hee Park <shpark7@stanford.edu>, Bryan Wu <bryan.wu@canonical.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Semwal, Sumit" <sumit.semwal@ti.com>

Hi,

2011/2/19 archit taneja <archit@ti.com>:
> Hi,
>
> Which board are you on? For all the display devices you add in the board
> file, you should have the corresponding drivers in the menuconfig set also.

Pandaboard.

> For example, in board3430-sdp.c, we add a sharp ls, a dvi and venc panel. We
> therefore select sharpls and generic dpi panel in menuconfig.
> and at least DPI and VENC in the interfaces menu.

I also selected all the options above.

thanks,
-- 
Lei Ming
