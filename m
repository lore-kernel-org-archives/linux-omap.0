From: =?windows-1251?Q?=CC=E8=F5=E0=E8=EB?= <dotnetfx@bk.ru>
Subject: omap16xxcam module
Date: Tue, 20 May 2008 22:31:56 +0400
Message-ID: <4833191C.7010204@bk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fallback.mail.ru ([194.67.57.14]:32803 "EHLO mx4.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752400AbYETScb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 May 2008 14:32:31 -0400
Received: from mx6.mail.ru (mx6.mail.ru [194.67.23.26])
	by mx4.mail.ru (mPOP.Fallback_MX) with ESMTP id 437C710C8346
	for <linux-omap@vger.kernel.org>; Tue, 20 May 2008 22:32:29 +0400 (MSD)
Received: from [88.147.138.69] (port=4141 helo=[192.168.1.3])
	by mx6.mail.ru with asmtp
	id 1JyWcv-000OBW-00
	for linux-omap@vger.kernel.org; Tue, 20 May 2008 22:31:57 +0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi, there. I work with OMAP5912 OSK. I've found some bugs in latest
(16/05/08) snapshot of git tree in omap16xxcam module. Here they are:

-------------------------omap16xxcam.c---------------------------------=
----------

///////////////////////////////////////////////////////////////////////=
//////////////////////

In function: omap16xx_cam_link_open

line 176: OMAP_DMA_CLNK_CTRL_REG(data->dma_channel_number1) =3D
data->dma_channel_number2; - udefined. I've looked into dma.h, and I
think that OMAP_DMA_CLNK_CTRL_REG should be replaced with
OMAP1_DMA_CLNK_CTRL. But even after all it'll be an error line, the
error is:

drivers/media/video/omap/omap16xxcam.c:176: error: lvalue required as
left operand of assignment.

line 178: the same error.

///////////////////////////////////////////////////////////////////////=
///////////////////

In function: omap16xxcam_start_dma

line 342:  s/OMAP_DMA_CLNK_CTRL_REG/OMAP1_DMA_CLNK_CTRL/g

line 352: s/OMAP_DMA_CCR_REG/OMAP1_DMA_CCR/g

///////////////////////////////////////////////////////////////////////=
///////////////////

Here "make" command log after all changes in source:

drivers/media/video/omap/omap16xxcam.c: In function =91omap16xx_cam_lin=
k_open=92
drivers/media/video/omap/omap16xxcam.c:177: error: lvalue required as
left operand of assignment
drivers/media/video/omap/omap16xxcam.c:179: error: lvalue required as
left operand of assignment
drivers/media/video/omap/omap16xxcam.c: In function =91omap16xxcam_star=
t_dma=92
drivers/media/video/omap/omap16xxcam.c:342: error: lvalue required as
left operand of assignment
drivers/media/video/omap/omap16xxcam.c:352: error: lvalue required as
left operand of assignment
make[4]: *** [drivers/media/video/omap/omap16xxcam.o] Error 1
make[3]: *** [drivers/media/video/omap] Error 2
make[2]: *** [drivers/media/video] Error 2
make[1]: *** [drivers/media] Error 2
make: *** [drivers] Error 2

-------------------------omap16xxcam.c---------------------------------=
----------

But even after all changes, if you'll comment error lines, just for a
test it will not successfully build. The error log will looks like this=
:

------------------------------cut--------------------------------------=
-----
ERROR: "v4l2_int_ioctl_1" [drivers/media/video/omap/omapcamera.ko]
undefined!
ERROR: "v4l2_int_ioctl_0" [drivers/media/video/omap/omapcamera.ko]
undefined!
make[1]: *** [__modpost] Error 1
make: *** [modules] Error 2
------------------------------cut--------------------------------------=
-----

Any ideas ?


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
