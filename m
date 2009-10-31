From: Senthilnathan KS <k.s.senthilnathan@gmail.com>
Subject: image split issue on omap3530 using kernel 2.6.22
Date: Sat, 31 Oct 2009 18:46:04 +0530
Message-ID: <c30f297a0910310616g7ff36e45w2b7b3d7b176ca2c5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f188.google.com ([209.85.222.188]:57836 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757739AbZJaNP7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 31 Oct 2009 09:15:59 -0400
Received: by pzk26 with SMTP id 26so2415911pzk.4
        for <linux-omap@vger.kernel.org>; Sat, 31 Oct 2009 06:16:04 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi All,

We have an issue in OMAP3530 ISP driver on kernel 2.6.22.  We are
using MT9V023 sensor to capture the video and display it on LCD. The
video image on LCD is getting split after a 2 or 3 hrs run, or if
there is any external disturbance. If the mobile phone which is kept
nearer to camera,  receives the call / SMS, the video is getting
split.

=46ollowing is our observation:

If the camera is working fine, without any split screen, we receive 4
interrupts =96 in the ISP handler.

isp: irqstatus =3D 0x02000100  -        Overflow Error, VD0 Done
isp: irqstatus =3D 0x02160000  -        Overflow Error,  Preview Done,
LSC Done, LSC Pre-fetch Completed
isp: irqstatus =3D 0x03000000  -        Overflow Error,  Resize done
isp: irqstatus =3D 0x02000200  -        Overflow Error,  VD1 Done

Whenever we see the image split issue, we see an additional interrupt.

isp: irqstatus =3D 0x02080100 -         Overflow Error, LSC pre-fetch
error
isp: irqstatus =3D 0x82060000 -         H-Sync, Overflow Error,  LSC
done, pre-fetch completed
isp: irqstatus =3D 0x02000200 -         Overflow Error and VD1 done
isp: irqstatus =3D 0x02100000 -         Overflow Error and Preview done
isp: irqstatus =3D 0x03000000 -         Overflow Error and Resize done

How to recover/avoid this image spilt issue? Are there any patch for
ISP on 2.6.22 kernel?. Can anybody  please help us or suggest to fix
this issue?

Thanks
Senthil
--=20
Thanks and Regards,
Senthilnathan.K.S.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
