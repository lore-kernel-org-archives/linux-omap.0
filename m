From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv2 06/19] ARM: OMAP4: PM: Add SAR backup support towards device OFF
Date: Wed, 16 May 2012 15:58:28 -0700
Message-ID: <87aa177my3.fsf@ti.com>
References: <1336990730-26892-1-git-send-email-t-kristo@ti.com>
	<1336990730-26892-7-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:51450 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760720Ab2EPW6b (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 May 2012 18:58:31 -0400
Received: by dajz8 with SMTP id z8so1747844daj.2
        for <linux-omap@vger.kernel.org>; Wed, 16 May 2012 15:58:30 -0700 (PDT)
In-Reply-To: <1336990730-26892-7-git-send-email-t-kristo@ti.com> (Tero
	Kristo's message of "Mon, 14 May 2012 13:18:37 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

Tero Kristo <t-kristo@ti.com> writes:

> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
>
> The SAR RAM is maintained during Device OFF mode. 

so why is this patch bothering to save and restore it?

-ECONFUSED

> The register layout
> is fixed in SAR ROM. SAR is split into 4 banks with different
> privilege accesses based on device type
>
>  ---------------------------------------------------------------
>  Access mode		Bank	Address Range
>  ---------------------------------------------------------------
>  HS/GP : Public		1	0x4A32_6000 - 0x4A32_6FFF (4kB)
>  HS/GP : Public		2	0x4A32_7000 - 0x4A32_73FF (1kB)
>
>  HS/EMU : Secured
>  GP : Public		3	0x4A32_8000 - 0x4A32_87FF (2kB)
>
>  HS/GP :Secure
>  write once.		4	0x4A32_9000 - 0x4A32_93FF (1kB)
>  ---------------------------------------------------------------
>
> The save process is done entirely by software and restore is done by
> hardware using the auto-restore feature. The restore feature is enabled
> by default and cannot be disabled. The software must save the data
> to be restored in a dedicated location in SAR RAM.

Some general comments:

- can the cluster PM notifier be used for the save path?

- This patch adds lots of data that is immediately removed by the next
  patch.  Probably the two just need to be combined.

- BUG_ON() should not be used unless there is absolutely no recovery
  path, since it casues a full kernel panic.   Instead, some error
  recovery should be added.

Kevin
