From: Ran Shalit <ranshalit@gmail.com>
Subject: nand gpmc - overriden values in kernel
Date: Tue, 14 Oct 2014 13:21:35 +0300
Message-ID: <CAJ2oMhKpHw=PVbw8gzp952sEm2XPZk46SOOgNECsMb-Zmi2nSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:51800 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754570AbaJNKVg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Oct 2014 06:21:36 -0400
Received: by mail-ig0-f180.google.com with SMTP id uq10so13930712igb.13
        for <linux-omap@vger.kernel.org>; Tue, 14 Oct 2014 03:21:36 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,

In omap2_nand_gpmc_retime() the kernel override the gpmc cs
configuration with other values. It resulted in failure of nand
detection in some boards.
Is there any reason for the override of gpmc cs values ?

Thanks,
Ran
