From: Maxim Podbereznyy <lisarden@gmail.com>
Subject: latest kernel for am35xx
Date: Wed, 30 May 2012 11:51:39 +0300
Message-ID: <CAP3+TEr8vsnZPhAhgH-w7jAjWZTNQgWvsQ3cn_uz4TaX8c-Zgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:59333 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932264Ab2E3Ivk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 May 2012 04:51:40 -0400
Received: by lbbgm6 with SMTP id gm6so2800014lbb.19
        for <linux-omap@vger.kernel.org>; Wed, 30 May 2012 01:51:39 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi!

I need to use the latest kernel at a am3517 based board where
Craneboard schematic was used as a reference. In addition to Cranboard
scheme I have wl1271 chip added and therefore I need a kernel - one of
the latests to support wireless feature.

The job I did:
1) used kernel from Craneboard (Mistral repository) - 2.6.32, no wl1271 support
2) OMAPPSP_04.02.00.07 - 2.6.37, tps65910 driver is broken
3) AM335x PSP 04.06.00.07 - does not compile for am3517evm

Can anybody suggest some alive kernel tree where tps65910 and wl1271
chips are supported? Having am3517evm or am3517crane board files would
be a great help!

Thanks in advance!
Max
