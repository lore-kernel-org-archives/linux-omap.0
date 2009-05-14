From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH] OMAP: UART: don't initialize membase and mapbase when its
	port is not enabled
Date: Thu, 14 May 2009 17:09:09 +0300
Message-ID: <6ed0b2680905140709x7b01eb45n42f9ca6b6d15894b@mail.gmail.com>
References: <4d34a0a70905140141t3f8e2b08uefb4141f904bfcc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:48138 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752278AbZENOJK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 May 2009 10:09:10 -0400
Received: by fxm2 with SMTP id 2so1329947fxm.37
        for <linux-omap@vger.kernel.org>; Thu, 14 May 2009 07:09:09 -0700 (PDT)
In-Reply-To: <4d34a0a70905140141t3f8e2b08uefb4141f904bfcc@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kim Kyuwon <chammoru@gmail.com>
Cc: OMAP <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, Kyungmin Park <kyungmin.park@samsung.com>, =?EUC-KR?B?seix1L/4?= <q1.kim@samsung.com>, Paul Mundt <paul.mundt@nokia.com>

2009/5/14 Kim Kyuwon <chammoru@gmail.com>:
> Hi All,
>
> We are using two UARTs port in OMAP3430 board shown as following
> =A0UART 1 - not used
> =A0UART 2 - BT
> =A0UART 3 - console ("console=3DttyS2,115200n8" in 'bootargs' of boot=
loader)
>
> Because we are not using UART port 1, I configured our board file as =
following
> =A0735 static struct omap_uart_config omap3_boardname_uart_config __i=
nitdata =3D {
> =A0736 =A0 =A0 =A0 =A0 .enabled_uarts =A0=3D ((1 << 1) | (1 << 2)),
> =A0737 };
> However, I couldn't see any console message.
>
> If I configured like
> =A0735 static struct omap_uart_config omap3_boardname_uart_config __i=
nitdata =3D {
> =A0736 =A0 =A0 =A0 =A0 .enabled_uarts =A0=3D ((1 << 0) (1 << 1) | (1 =
<< 2)),
> =A0737 };
> I could see console messages. But I think this is not the real soluti=
on.
>
> Is it correct to use ttyS2, if I use UART3 as console UART?
>
> Anyway, I kept track of this problem and I'm sending the patch.

In your case UART2 becomes ttyS0 and UART3 becomes ttyS1, so use
"console=3DttyS1" in your bootargs. There is no point exposing UART1 as
ttyS0 in Linux if it's not connected on your board.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
