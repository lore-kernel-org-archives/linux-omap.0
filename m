From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH v2 09/18] ARM: OMAP4+: PM: Restore CPU power state to ON with clockdomain force wakeup method
Date: Wed, 03 Apr 2013 13:54:41 -0700
Message-ID: <87mwtftjvy.fsf@linaro.org>
References: <1364205910-32392-1-git-send-email-santosh.shilimkar@ti.com>
	<1364205910-32392-10-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f41.google.com ([209.85.160.41]:42400 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760979Ab3DCUyp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Apr 2013 16:54:45 -0400
Received: by mail-pb0-f41.google.com with SMTP id mc17so1063763pbc.14
        for <linux-omap@vger.kernel.org>; Wed, 03 Apr 2013 13:54:45 -0700 (PDT)
In-Reply-To: <1364205910-32392-10-git-send-email-santosh.shilimkar@ti.com>
	(Santosh Shilimkar's message of "Mon, 25 Mar 2013 15:35:01 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nm@ti.com, tony@atomide.com

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> While waking up CPU from off state using clock domain force wakeup, restore
> the CPU power state to ON state before putting CPU clock domain under
> hardware control. Otherwise CPU wakeup might fail. The change is recommended
> for all OMAP4+ devices though the PRCM weakness was observed on OMAP5
> devices first.

Sounds reasonable, but can you describe the "weakness" a little more?

IOW, what exactly happens if this is not done?  It sounds like the CPU
might immediately go back to retention, but how does that happen unless
it does a WFI?

Also, this sounds like a fix to me, and should probably be broken out
accordingly.

Kevin

