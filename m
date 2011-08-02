From: "Leonid Liansky" <lliansky@gmail.com>
Subject: OpenMax issue
Date: Tue, 2 Aug 2011 14:00:35 -0400
Message-ID: <82F7B73BFEC84DD0A55CE2C66442BD6D@leonidlw7>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed	reply-type=original
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:48142 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754799Ab1HBSAj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Aug 2011 14:00:39 -0400
Received: by wwe5 with SMTP id 5so26607wwe.1
        for <linux-omap@vger.kernel.org>; Tue, 02 Aug 2011 11:00:38 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

I am trying to utilize H.264 encoder via OpenMax on Blaze. The problem =
is=20
that I am getting an error from OMX_GetHandle() while using=20
=E2=80=9COMX.TI.DUCATI1.VIDEO.H264E=E2=80=9D as a component name.

I have traced the issue to syslink failing to open =E2=80=9C/dev/syslin=
kipc/Ipc=E2=80=9D=20
file in IpcDrv.c file, IpcDrv_open() function. I get =E2=80=931 as retu=
rn code from=20
open().

When looking at IpcDrv.c logs, I can see that camera application is abl=
e to=20
open the file successfully (although in uses camera component instead o=
f=20
H.264 encoder). But even when trying to initialize=20
=E2=80=9COMX.TI.DUCATI1.VIDEO.CAMERA=E2=80=9D component via OMX_GetHand=
le() I still get the=20
same error from open() in IpcDrv_open().

I am running version 12 of Android (Gingerbread 2.3.3) on Blaze with=20
standard xem3 files for syslink_daemon.

Any advise will be greatly appreciated,
Leo

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
