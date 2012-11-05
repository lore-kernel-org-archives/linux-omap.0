From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv9 6/8] ARM: OMAP4: retrigger localtimers after re-enabling gic
Date: Mon, 05 Nov 2012 14:25:59 -0800
Message-ID: <878vafg008.fsf@deeprootsystems.com>
References: <1350552010-28760-1-git-send-email-t-kristo@ti.com>
	<1350552010-28760-7-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:60570 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932139Ab2KEWZ7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Nov 2012 17:25:59 -0500
Received: by mail-pa0-f46.google.com with SMTP id hz1so4255723pad.19
        for <linux-omap@vger.kernel.org>; Mon, 05 Nov 2012 14:25:59 -0800 (PST)
In-Reply-To: <1350552010-28760-7-git-send-email-t-kristo@ti.com> (Tero
	Kristo's message of "Thu, 18 Oct 2012 12:20:08 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, Colin Cross <ccross@android.com>, Sebastien Jan <s-jan@ti.com>

Tero Kristo <t-kristo@ti.com> writes:

> From: Colin Cross <ccross@android.com>
>
> 'Workaround for ROM bug because of CA9 r2pX gic control'
> register change disables the gic distributor while the secondary

Just to clarify: this is referring to PATCH 3/8 of this series, correct?

Kevin
