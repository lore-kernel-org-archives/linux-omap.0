From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv2 04/19] ARM: OMAP4: PM: save/restore all DPLL settings in OFF mode
Date: Wed, 16 May 2012 15:42:55 -0700
Message-ID: <87d363928g.fsf@ti.com>
References: <1336990730-26892-1-git-send-email-t-kristo@ti.com>
	<1336990730-26892-5-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:54379 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760683Ab2EPWm7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 May 2012 18:42:59 -0400
Received: by pbbro12 with SMTP id ro12so1838232pbb.32
        for <linux-omap@vger.kernel.org>; Wed, 16 May 2012 15:42:58 -0700 (PDT)
In-Reply-To: <1336990730-26892-5-git-send-email-t-kristo@ti.com> (Tero
	Kristo's message of "Mon, 14 May 2012 13:18:35 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

Tero Kristo <t-kristo@ti.com> writes:

> From: Rajendra Nayak <rnayak@ti.com>
>
> SAR/ROM code restores only CORE DPLL to its original state
> post wakeup from OFF mode.
> The rest of the DPLL's in OMAP4 platform (MPU/IVA/ABE/USB/PER)
> are saved and restored here during an OFF transition.
>
> [nm@ti.com: minor cleanups]
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

Some general comments:

- the register dump/print doesn't belong here.  If needed, should be a
  debug feature if needed.

- Rather than hooking into omap4_enter_lowpower(), should use
  the cluster PM enter/exit notifier chain.

Kevin
