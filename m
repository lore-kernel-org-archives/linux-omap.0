From: "Syed Mohammed, Khasim" <khasim@ti.com>
Subject: RE: how to use omap 2430 character led
Date: Thu, 7 Aug 2008 15:13:20 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C00208C15A18@dbde02.ent.ti.com>
References: <a4ecca850808060611oc0f627an2a7e1c2a2ee22fb0@mail.gmail.com>
 <a4ecca850808060629o2a9546f4j2f8767d44a0f60@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from calf.ext.ti.com ([198.47.26.144]:41086 "EHLO calf.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758938AbYHGMgd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Aug 2008 08:36:33 -0400
In-Reply-To: <a4ecca850808060629o2a9546f4j2f8767d44a0f60@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: vishal bhoj <vishalbhoj@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of vishal
> bhoj
> Sent: Wednesday, August 06, 2008 6:59 PM
> To: linux-omap@vger.kernel.org
> Subject: Fwd: how to use omap 2430 character led
>
> CAn anyone tell me howto use the character lcd display on omap 2430
> board. i want to test it and use it at assembly level
>
I think you are definitely "NOT" referring to Secondary LCD.

> i am writing it in the memory locations but im not getting any output.
> do we have to do any initializations to run this code on the board ?
> like mux config ? im creating a bin image and trying to run it in the
> ram directly. do i have to initialisze the pad ? i dono much, im a
> newbie to omaps
>
For Character LCD, I think you can refer to the code snippet in u-boot that displays the boot mode NAND/NOR etc on character LCD. Following the exact code base should help you in getting characters displayed on the LCD.

Download u-boot for 2430 SDP from here

In file u-boot/board/omap2430sdp/sys_info.c

Refer to function:  display_board_info(u32 btype)

Regards,
Khasim
http://khasim.blogspot.com

