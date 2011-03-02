From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 07/17] omap4: pm: CPU1 wakeup workaround form Low power modes
Date: Wed, 02 Mar 2011 15:44:27 -0800
Message-ID: <87tyflxf38.fsf@ti.com>
References: <1298112158-28469-1-git-send-email-santosh.shilimkar@ti.com>
	<1298112158-28469-8-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:53207 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754352Ab1CBXob (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Mar 2011 18:44:31 -0500
Received: by mail-yi0-f45.google.com with SMTP id 19so199645yib.18
        for <linux-omap@vger.kernel.org>; Wed, 02 Mar 2011 15:44:29 -0800 (PST)
In-Reply-To: <1298112158-28469-8-git-send-email-santosh.shilimkar@ti.com>
	(Santosh Shilimkar's message of "Sat, 19 Feb 2011 16:12:28 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> The SGI(Software Generated Interrupts) are not wakeup capable from
> low power states. This is known limitation on OMAP4 and needs to be
> worked around by using software forced clockdomain wake-up. CPU0 forces
> the CPU1 clockdomain to software force wakeup. After the wakeup, CPU1
> restores its clockdomain hardware supervised mode.
>
> More details can be found in OMAP4430 TRM - Version J
> Section :
> 	4.3.4.2 Power States of CPU0 and CPU1
>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Reviewed-by: Kevin Hilman <khilman@ti.com>

One other thing... 

in subject: s/form/from/

Kevin
