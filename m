From: Fernando Governatore <fergc@uol.com.br>
Subject: McBSP in Multi Channel mode
Date: Thu, 7 May 2009 15:18:34 -0300
Message-ID: <29e1ddd50905071118i28bd16b8ub715cd2b5dafaca8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.24]:17504 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753399AbZEGSSy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 May 2009 14:18:54 -0400
Received: by qw-out-2122.google.com with SMTP id 5so694716qwd.37
        for <linux-omap@vger.kernel.org>; Thu, 07 May 2009 11:18:54 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,

I'm new to kernel development and so I'm a bit confused on how to do
things here. I need to use the McBSP with Multi-Channel enabled and
using DMA to transfer the data.

The data will be PCM sound and I will have 4 cards attached to this
McBSP. I'm using OMAP35xx.

>From what I've seen, I have to change the files:
 - arch/arm/plat-omap/mcbsp.c
 - arch/arm/mach-omap2/mcbsp.c
to support multi channel. Is that it? or I would need more changes?

Is there something that I would need to change in DMA implementation?
Do you know where I can get an example or documentation?

Thanks,
Fernando
