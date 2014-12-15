From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [GIT PULL] rpmsg for 3.19
Date: Mon, 15 Dec 2014 10:16:25 +0200
Message-ID: <CAK=Wgbbq5zCjuii2SQoB-erLTT_oOQAfmVe9CNuDuDB4=CkPmg@mail.gmail.com>
References: <CAK=WgbZJX1GxB-nDwYtS3Qw-TY32QBkywsCaajnCqPXhZ=HQCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:47273 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751317AbaLOIQq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Dec 2014 03:16:46 -0500
Received: by mail-ie0-f177.google.com with SMTP id rd18so10263825iec.22
        for <linux-omap@vger.kernel.org>; Mon, 15 Dec 2014 00:16:45 -0800 (PST)
In-Reply-To: <CAK=WgbZJX1GxB-nDwYtS3Qw-TY32QBkywsCaajnCqPXhZ=HQCg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Anna, Suman" <s-anna@ti.com>, linux-arm <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

[Resending in plain text mode - sorry]

The following changes since commit 5d01410fe4d92081f349b013a2e7a95429e4f2c9:

  Linux 3.18-rc6 (2014-11-23 15:25:20 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ohad/rpmsg.git
tags/rpmsg-3.19-next

for you to fetch changes up to b1b9891441fa33fd0d49b5cb3aa7f04bca1cc1db:

  rpmsg: use less buffers when vrings are small (2014-11-26 18:24:36 +0200)

----------------------------------------------------------------
A single patch from Suman Anna which makes rpmsg
use less buffers when small vrings are being used.

----------------------------------------------------------------
Suman Anna (1):
      rpmsg: use less buffers when vrings are small

 drivers/rpmsg/virtio_rpmsg_bus.c | 44 +++++++++++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 14 deletions(-)
