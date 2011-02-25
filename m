From: "Jan, Sebastien" <s-jan@ti.com>
Subject: Re: [PATCH] OMAP4: PandaBoard: Adding DVI support
Date: Fri, 25 Feb 2011 19:57:23 +0100
Message-ID: <AANLkTikQ25tLoRSynp6xjaJPO0sPpY3RFFS52UsgBuvU@mail.gmail.com>
References: <1297259727-19690-1-git-send-email-raghuveer.murthy@ti.com>
 <AANLkTimwCDYGfeXc=mW-1wyvSj+OGHd_fJMB7Grh60ih@mail.gmail.com>
 <AANLkTimQxC3HgaRs-bBOGChLhvAK69XHCPEGyOcKeOz6@mail.gmail.com> <F55C15BA-2C89-4DB7-9930-5176AA72C2A7@dominion.thruhere.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:50542 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751325Ab1BYS5j (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Feb 2011 13:57:39 -0500
Received: by mail-qy0-f181.google.com with SMTP id 14so1738801qyg.5
        for <linux-omap@vger.kernel.org>; Fri, 25 Feb 2011 10:57:38 -0800 (PST)
In-Reply-To: <F55C15BA-2C89-4DB7-9930-5176AA72C2A7@dominion.thruhere.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <koen@dominion.thruhere.net>
Cc: Bryan Wu <bryan.wu@canonical.com>, "Gadiyar, Anand" <gadiyar@ti.com>, robertcnelson@gmail.com, Raghuveer Murthy <raghuveer.murthy@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Feb 11, 2011 at 4:38 PM, Koen Kooi <koen@dominion.thruhere.net> wrote:
>> I fetched this branch which contains 35 patches on top of 2.6.38-rc4.
>> After fixing some conflict, I applied these 35 patches on our Ubuntu
>> ti-omap-dev kernel. With built-in the DSS2 driver and GENERIC_DPI
>> driver, kernel boots fine on my Panda with Ubuntu GUI. But I have to
>> set the kernel boot command args with omapfb.mode=dvi:1024x768MR-24@60
>> omapdss.def_disp=dvi, pointed out by Sebastien. Without this bootargs,
>> no graphic at all. so as Robert concerned, EDID detection doesn't
>> work. Does that related to I2C driver? I2C driver always tell me
>> timeout in dmesg.
>
> AIUI the i2c bus is only hooked up to the HDMI port, so unless you plug in something there, no dice.

Are you sure? According to the pandaboard user manual, there seem to
be an i2c connection (i2c3): page 31, fig 9:
http://pandaboard.org/sites/default/files/board_reference/A1/Panda_Board_Spec_DOC-21010_REV0_6.pdf
