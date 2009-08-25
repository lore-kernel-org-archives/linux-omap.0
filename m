From: Tar Gz <bsdraisefromhell@gmail.com>
Subject: linux-ldp1.8
Date: Wed, 26 Aug 2009 03:50:10 +0700
Message-ID: <d9ca78710908251350i6359852ajed5b13f948a48dbe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f205.google.com ([209.85.217.205]:41256 "EHLO
	mail-gx0-f205.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756108AbZHYUuJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Aug 2009 16:50:09 -0400
Received: by gxk1 with SMTP id 1so4449768gxk.17
        for <linux-omap@vger.kernel.org>; Tue, 25 Aug 2009 13:50:11 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

Hi all

i' try to running linux ldp-1.8 in the omap 3430

when i start the kernel

.......
Starting Kernel

and stuck at this point

i'm using env like that :

#setenv bootargs console=ttyS0,115200n8 root=/dev/mmcblk0p2 mem=128M rootdelay=2
#mmcinit
#fatload mmc 0 80300000 uImage
#bootm uImage

when i'm change ttyS0 to ttyS2...this is have the same problem...

best regards,
Aldyth M
