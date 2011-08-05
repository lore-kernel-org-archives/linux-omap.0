From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] OMAP: omap_device: make latency autoadjust messages debug
Date: Fri, 05 Aug 2011 07:52:44 -0700
Message-ID: <874o1vvrk3.fsf@ti.com>
References: <1311599904-5981-1-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:43820 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754495Ab1HEOws (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Aug 2011 10:52:48 -0400
Received: by mail-pz0-f45.google.com with SMTP id 33so6600632pzk.32
        for <linux-omap@vger.kernel.org>; Fri, 05 Aug 2011 07:52:47 -0700 (PDT)
In-Reply-To: <1311599904-5981-1-git-send-email-notasas@gmail.com> (Grazvydas
	Ignotas's message of "Mon, 25 Jul 2011 16:18:24 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Steve Sakoman <steve@sakoman.com>

Grazvydas Ignotas <notasas@gmail.com> writes:

> During normal system operation warning messages similar to this
> are appearing quite often:
> omap_device: omap4-keypad.-1: new worst case activate latency 0: 61035
>
> This doesn't seem to be reporting a problem, nor is it very useful for
> non-developers, so reduce it to debug level.

Yeah, this is really only useful for PM developers, so making it debug
is fine.

> Cc: Steve Sakoman <steve@sakoman.com>
> Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
> ---
> Applies on top of git://git.pwsan.com/linux-2.6 prcm-devel-3.1
> + Kevin's "OMAP: omap_device: replace pr_* prints with dev_*".

Adding it to my omap_device queue for v3.2:
git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_3.2/omap_device

Kevin
