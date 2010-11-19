From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: Problem using UART3 on Logic Torpedo w/2.6.32
Date: Fri, 19 Nov 2010 16:48:12 +0530
Message-ID: <AANLkTimmgWiyaLUv_1a7uhMp8Ah_eneJrODV-4ARXRCf@mail.gmail.com>
References: <4CE59517.7060408@logicpd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:38239 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752929Ab0KSLSh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Nov 2010 06:18:37 -0500
Received: by wyb28 with SMTP id 28so4323830wyb.19
        for <linux-omap@vger.kernel.org>; Fri, 19 Nov 2010 03:18:36 -0800 (PST)
In-Reply-To: <4CE59517.7060408@logicpd.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Barada <peterb@logicpd.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Peter Barada <peter.barada@logicpd.com>

On Fri, Nov 19, 2010 at 2:35 AM, Peter Barada <peterb@logicpd.com> wrot=
e:
> All,
>
> I have a 2.6.32 kernel based on the L23.i3.3 kernel (2.6.32) from TI,=
 and
> I've run into an interesting problem with UART3 (maps to /dev/ttyS1 o=
n the
> Torpedo board).
>
> On the host I have it hooked up to /dev/ttyS1, so I turn on CTS/RTS a=
nd set
> the baudrate by:
>
> host$ stty 115200 crtscts < /dev/ttyS1
>
> And the same on the target:
>
> OMAP-35x$ stty 115200 crtscts < /dev/ttyS1
>
> To force the board to throttle the serial I slowed down the console t=
o
> 19200:
>
> OMAP-35x$ stty 19200 < /dev/ttyS0
>
> On the target console I capture the data from the host (and show it o=
n the
> serial port):
>
> OMAP-35x$ cat < /dev/ttyS1 | tee /tmp/x
>
> and on the host send the data:
>
> host$ dd if=3D/dev/urandom count=3D100 bs=3D1024 | hexdump -C > /tmp/=
x
> host$ cat /tmp/x > /dev/ttyS1
>
> I'd expect to see something like the following on the target:
>
> 00000000 =A035 2c a6 97 23 35 95 9a =A0fb 91 6d 6e ce f8 32 d7
> =A0|5,..#5....mn..2.|
> 00000010 =A06b 0b cf 66 e6 3a b4 55 =A091 5f 86 8f 41 c9 49 76
> =A0|k..f.:.U._..A.Iv|
> 00000020 =A0e6 cf fa 0a 0e db 69 0c =A0db 14 6b 76 62 4c 5b 9e
> =A0|......i...kvbL[.|
> 00000030 =A098 1b 5f 30 16 d6 ed 96 =A0dc d7 f1 3b 59 a0 ec ac
> =A0|.._0.......;Y...|
> 00000040 =A086 8c 9b 28 21 b8 a0 98 =A0ed cf 96 39 15 a4 7b 9e
> =A0|...(!......9..{.|
> 00000050 =A0bf 01 aa 09 1a 12 1f c3 =A049 b3 92 73 00 84 52 de
> =A0|........I..s..R.|
> 00000060 =A0c0 d3 4b 1d ca 84 04 ea =A060 ef 7f b2 63 36 eb 5e
> =A0|..K.....`...c6.^|
> 00000070 =A028 0c 20 2a 86 a2 36 bb =A0c7 c0 27 da 87 c8 8b 1e =A0|(.
> *..6...'.....|
> 00000080 =A05d b7 04 b3 2c 0b 29 f4 =A08d 4f 5f fe 90 b0 1b 96
> =A0|]...,.)..O_.....|
> 00000090 =A0b8 82 94 ae 92 37 31 03 =A0dc 1b c3 c0 38 b1 16 77
> =A0|.....71.....8..w|
>
> Instead I see:
>
> OMAP-35x# head /tmp/x
> 00000000 =A035 2c a6 97 23 6b 0b ca =A0fb 91 6d 6e ce f8 32 d6 8f
> 41.#5....mn..2.|
> 00000010 =A0.Iv|
> 00f 66 e6 3a b4 55 =A091 5f 8669 0c =A0c9 49 76 =A0|k..f.:.U._..A.|..=
=2E..000020 =A0e6
> cf
> fa 0a 0e db 1b 5f =A0db 14 6b 76 62 4c 5b 9e =A0b 59 a.i...kvbL[.|
> 00000030 =A098.|
> 000030 16 d6 ed 96 =A0dc d7 f1 3b 59 e0 ec ac =A0|.._0.......;Y.....(=
!..0040 =A086
> 8c
> 9b 28 21 b8 a0 98 09d cf 96 39 15 a4 7b 9e =A0|.00 84 ....9..{.|
> 00000050 =A0bf 01000000 1a 12 1f c3 =A049 b3 92 73 a =A060 52 de
> =A0|........I..s..R.|
> .....`60 =A0c0 d3 4b 1d ca 84 04 e0 2a 8ef 7f b2 63 36 eb 5e =A0|..7 =
c8
> 8b...c6.^|
> 00000070 =A028 0c 20000806 a2 36 bb =A0c7 c0 27 da 87 8d 4f 1e =A0|(.
> *..6...'.....|
> 00.)..O_ =A05d b7 04 b3 2c 0b 29 f4 ae 92 =A05f fe 90 b0 1b 96 =A0|].=
=2E.,.).6
> 7.....|
> 00000090 =A0b8 82 94 00a0 =A037 31 03 =A0dc 1b c3 c0 38 b1 7c 77
> =A0|.....71.....8..w|
>
> Looking deeper:
>
> OMAP-35x# hexdump -C /tmp/x | head
> 00000000 =A030 30 30 30 30 30 30 30 =A020 20 33 35 20 32 63 20 =A0|00=
000000 =A035 2c
> |
> 00000010 =A061 36 20 39 37 20 32 33 =A020 36 62 20 30 62 20 63 =A0|a6=
 97 23 6b 0b
> c|
> 00000020 =A061 20 20 66 62 20 39 31 =A020 36 64 20 36 65 20 63 =A0|a =
=A0fb 91 6d 6e
> c|
> 00000030 =A065 20 66 38 20 33 32 20 =A064 36 20 38 66 20 34 31 =A0|e =
f8 32 d6 8f
> 41|
> 00000040 =A02e 23 35 2e 2e 2e 2e 6d =A06e 2e 2e 32 2e 7c 0a 30
> =A0|.#5....mn..2.|.0|
> 00000050 =A030 30 30 30 30 31 30 20 =A020 2e 49 76 7c 0a 30 30 =A0|00=
00010
> =A0.Iv|.00|
> 00000060 =A066 20 36 36 20 65 36 20 =A033 61 20 62 34 20 35 35 =A0|f =
66 e6 3a b4
> 55|
> 00000070 =A020 20 39 31 20 35 66 20 =A038 36 36 39 20 30 63 20 =A0| =A0=
91 5f 8669 0c
> |
> 00000080 =A020 63 39 20 34 39 20 37 =A036 20 20 7c 6b 2e 2e 66 =A0| c=
9 49 76
> =A0|k..f|
> 00000090 =A02e 3a 2e 55 2e 5f 2e 2e =A041 2e 7c 2e 2e 2e 2e 2e
> =A0|.:.U._..A.|.....|
>
> However if I instead use UART2 and replicate the above steps, all is =
well.
> =A0I've looked at the serial signals and CTS/RTS are responding as ex=
pected.
> =A0I tried switching drivers from the 8250 to the OMAP_SERIAL, and th=
e results
> look the same.
>
> Any ideas what is happening?

Can be a problem in UART+ PM path
UART1,2 --> core domain
UART3 --> Per domain

I3.3 you might be missing some PM fixes added later
Can you check with I3.8 ? [If its feasible at your end]

Probably missing these solutions for per domain issues:

http://dev.omapzoom.org/?p=3Dintegration/kernel-omap3.git;a=3Dcommit;h=3D=
54cd24dccf740fa2ad8ff129f81502f796801a71

http://dev.omapzoom.org/?p=3Dintegration/kernel-omap3.git;a=3Dcommit;h=3D=
b8251b24f7e72bb58bb542cefa301d37b63c3e93

Some hints:
Uart commits to look out for between i3.3 and i3.8

http://dev.omapzoom.org/?p=3Dintegration/kernel-omap3.git&a=3Dsearch&h=3D=
refs/heads/L23.i3.8&st=3Dcommit&s=3Duart

http://dev.omapzoom.org/?p=3Dintegration/kernel-omap3.git&a=3Dsearch&h=3D=
refs/heads/L23.I3.3&st=3Dcommit&s=3Duart

--
Regards,
Govindraj.R

>
> --
> Peter Barada
> peterb@logicpd.com
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
