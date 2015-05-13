From: Kevin Hilman <khilman@kernel.org>
Subject: Re: regression with today's linux-next
Date: Wed, 13 May 2015 13:39:44 -0700
Message-ID: <CAMAWPa8U_ESvBUV5fvoFcRLtP5nK0qkVEtA+x7Xa_xUTG1ho_A@mail.gmail.com>
References: <20150513182738.GA28201@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:37662 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754415AbbEMUjs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 May 2015 16:39:48 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 6F42520437
	for <linux-omap@vger.kernel.org>; Wed, 13 May 2015 20:39:47 +0000 (UTC)
Received: from mail-wi0-f175.google.com (mail-wi0-f175.google.com [209.85.212.175])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 15A012041A
	for <linux-omap@vger.kernel.org>; Wed, 13 May 2015 20:39:46 +0000 (UTC)
Received: by wicmc15 with SMTP id mc15so514133wic.1
        for <linux-omap@vger.kernel.org>; Wed, 13 May 2015 13:39:44 -0700 (PDT)
In-Reply-To: <20150513182738.GA28201@saruman.tx.rr.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Alexander Duyck <alexander.h.duyck@redhat.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

On Wed, May 13, 2015 at 11:27 AM, Felipe Balbi <balbi@ti.com> wrote:

> your commit 9451980a6646 (net: Use cached copy of pfmemalloc to avoid
> accessing page) regresses most OMAP-based boards with a NULL pointer
> dereference.
>
> Below you can find git bisect log and a serial console capture of the
> problem.

FWIW, I can confirm the boot failure and had bisected down to the same commit.

Kevin
