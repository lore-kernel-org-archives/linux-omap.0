From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [GIT PULL] remoteproc: a single fix for 3.7
Date: Thu, 29 Nov 2012 10:35:01 +0200
Message-ID: <CAK=WgbZjufLpFevD2BJbceRGS4HQqK9fas=yakDDZ2uUcdrU-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:51536 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751187Ab2K2IfX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Nov 2012 03:35:23 -0500
Received: by mail-la0-f46.google.com with SMTP id p5so8452382lag.19
        for <linux-omap@vger.kernel.org>; Thu, 29 Nov 2012 00:35:21 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Ido Yariv <ido@wizery.com>

Hi Linus,

The following changes since commit 6f0c0580b70c89094b3422ba81118c7b959c7556:

  Linux 3.7-rc2 (2012-10-20 12:11:32 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ohad/remoteproc.git
tags/rproc-3.7-fix

for you to fetch changes up to dab55bbafdb491ce2c3f2d7136e54101e948b911:

  remoteproc: fix error path of ->find_vqs (2012-11-29 10:05:09 +0200)

----------------------------------------------------------------
A single remoteproc fix for an error path issue reported by Ido Yariv.

----------------------------------------------------------------
Ohad Ben-Cohen (1):
      remoteproc: fix error path of ->find_vqs

 drivers/remoteproc/remoteproc_virtio.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)
