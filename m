From: "Semwal, Sumit" <sumit.semwal@ti.com>
Subject: Re: omapfb: no driver for display
Date: Mon, 21 Feb 2011 08:10:25 +0530
Message-ID: <AANLkTin7_0M1EtRk9V=b0sKhSSmuPfiMk99azXVOnrFh@mail.gmail.com>
References: <AANLkTi=f=SKE=QR97ttPnBrpW=2wNGd03+q4agmu6Uap@mail.gmail.com>
 <AANLkTikpCcpkjb8i_8Gk5ey1FtgsaUenmKNDhrtjLqon@mail.gmail.com>
 <AANLkTinoLOyqBCMNKbpcJMhZHnncX1T07nbfsTThA_a4@mail.gmail.com>
 <4D5DF547.7010703@ti.com> <AANLkTik_H0vAEjB8tOyJNC4oDS1+Tp5ick0mq4jhhqMV@mail.gmail.com>
 <AANLkTimt934X7G8DSnqVQ03fbggD9-SHWW3-QPQp+yAq@mail.gmail.com>
 <AANLkTikSU_QgRNahQU3Rrb1KZ0vCNZ4FTz59hOmDaaUD@mail.gmail.com>
 <AANLkTi=piR+YKvJi+_B4fZk6TtQA_drPEAyKKcMa0oZN@mail.gmail.com>
 <AANLkTinUO69HYZUUQ-NzyB_LDLvvfBnLqtSDKimu0xy3@mail.gmail.com>
 <4D5F9F3B.6000507@ti.com> <AANLkTin1=fQOcUTgWNefW2UC-U3Dx38iJOu_sK_TayBD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:57288 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754498Ab1BUCkq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 20 Feb 2011 21:40:46 -0500
Received: by mail-yw0-f47.google.com with SMTP id 8so365755ywg.20
        for <linux-omap@vger.kernel.org>; Sun, 20 Feb 2011 18:40:45 -0800 (PST)
In-Reply-To: <AANLkTin1=fQOcUTgWNefW2UC-U3Dx38iJOu_sK_TayBD@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ming Lei <tom.leiming@gmail.com>
Cc: archit taneja <archit@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, Sung Hee Park <shpark7@stanford.edu>, Bryan Wu <bryan.wu@canonical.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Sat, Feb 19, 2011 at 6:10 PM, Ming Lei <tom.leiming@gmail.com> wrote:
> Hi,
>
> 2011/2/19 archit taneja <archit@ti.com>:
>> Hi,
>>
>> Which board are you on? For all the display devices you add in the board
>> file, you should have the corresponding drivers in the menuconfig set also.
>
> Pandaboard.
DVI support for pandaboard is slated to be in for 2.6.39. There are
around 6-7 patch series which enable it. You could look at the top
patches at:

git://dev.omapzoom.org/pub/scm/anand/linux-omap-usb.git, branch:
display-patches-for-v2.6.38-rc4.

Best regards,
~Sumit.
>
>> For example, in board3430-sdp.c, we add a sharp ls, a dvi and venc panel. We
>> therefore select sharpls and generic dpi panel in menuconfig.
>> and at least DPI and VENC in the interfaces menu.
>
> I also selected all the options above.
>
> thanks,
> --
> Lei Ming
>
