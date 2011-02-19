From: archit taneja <archit@ti.com>
Subject: Re: omapfb: no driver for display
Date: Sat, 19 Feb 2011 16:15:15 +0530
Message-ID: <4D5F9F3B.6000507@ti.com>
References: <AANLkTi=f=SKE=QR97ttPnBrpW=2wNGd03+q4agmu6Uap@mail.gmail.com>	<AANLkTikpCcpkjb8i_8Gk5ey1FtgsaUenmKNDhrtjLqon@mail.gmail.com>	<AANLkTinoLOyqBCMNKbpcJMhZHnncX1T07nbfsTThA_a4@mail.gmail.com>	<4D5DF547.7010703@ti.com>	<AANLkTik_H0vAEjB8tOyJNC4oDS1+Tp5ick0mq4jhhqMV@mail.gmail.com>	<AANLkTimt934X7G8DSnqVQ03fbggD9-SHWW3-QPQp+yAq@mail.gmail.com>	<AANLkTikSU_QgRNahQU3Rrb1KZ0vCNZ4FTz59hOmDaaUD@mail.gmail.com>	<AANLkTi=piR+YKvJi+_B4fZk6TtQA_drPEAyKKcMa0oZN@mail.gmail.com> <AANLkTinUO69HYZUUQ-NzyB_LDLvvfBnLqtSDKimu0xy3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50598 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753027Ab1BSKny (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 19 Feb 2011 05:43:54 -0500
In-Reply-To: <AANLkTinUO69HYZUUQ-NzyB_LDLvvfBnLqtSDKimu0xy3@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ming Lei <tom.leiming@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>, Sung Hee Park <shpark7@stanford.edu>, Bryan Wu <bryan.wu@canonical.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Semwal, Sumit" <sumit.semwal@ti.com>

Hi,

Which board are you on? For all the display devices you add in the board 
file, you should have the corresponding drivers in the menuconfig set also.

For example, in board3430-sdp.c, we add a sharp ls, a dvi and venc 
panel. We therefore select sharpls and generic dpi panel in menuconfig.
and at least DPI and VENC in the interfaces menu.


On Saturday 19 February 2011 03:30 PM, Ming Lei wrote:
> Hi,
>
> 2011/2/19 Felipe Contreras<felipe.contreras@gmail.com>:
>> Are you sure? AFAIK early_param is executed _after_ memory blocks are reserved.
>
> Yes, I am sure.
>
> If 'vram=16M' is passed in, I can find the below:
>
>      [    0.000000] Memory: 1008MB = 1008MB total
>
> but if 'vram=8M' is taken, will be
>
>      [    0.000000] Memory: 1016MB = 1016MB total
>
> You may have a try on your board to confirm it.
>
>
> thanks,

