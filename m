From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v1 00/14] ARM: OMAP5: Add minimal OMAP5 SOC support
Date: Thu, 5 Jul 2012 17:52:06 +0530
Message-ID: <CAMQu2gwjowx1kkkySUqy5JEMB6N27m63T=Zy_ByyU=XnHXqgDA@mail.gmail.com>
References: <1341490136-25901-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:35799 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755240Ab2GEMWa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Jul 2012 08:22:30 -0400
Received: by qcro28 with SMTP id o28so5092305qcr.5
        for <linux-omap@vger.kernel.org>; Thu, 05 Jul 2012 05:22:27 -0700 (PDT)
In-Reply-To: <1341490136-25901-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

On Thu, Jul 5, 2012 at 5:38 PM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> Tony,
>
> The series adds minimal OMAP5 support. OMAP5430 has a dual core Cortex-A15
> based MPU subsystem with 2MB L2 cache. The SOC has many compatible blocks
> with OMAP4 SOCS and hence large part of the peripherals are re-used.
>
> OMAP5432 is another variant of OMAP5430, with a memory controller supporting
> DDR3 and SATA.
>
> Series is generated against cleanup-part2 branch at commit 74dd9ec6.
>
4 patches are repeated with [PATCH x/5] while posting. Just ignore them.

Regards
santosh
