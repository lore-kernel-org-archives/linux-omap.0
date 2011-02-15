From: Colin Cross <ccross@google.com>
Subject: Re: [PATCH 2/6] ARM: pm: add generic CPU suspend/resume support
Date: Mon, 14 Feb 2011 17:21:07 -0800
Message-ID: <AANLkTi=6zLxGxabBE4-+qGyRt7-219KE=4CB0jf9D=LG@mail.gmail.com>
References: <20110211161626.GA31356@n2100.arm.linux.org.uk>
	<E1Pnvgw-0002yZ-M0@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:47454 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082Ab1BOBVL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Feb 2011 20:21:11 -0500
Received: from kpbe16.cbf.corp.google.com (kpbe16.cbf.corp.google.com [172.25.105.80])
	by smtp-out.google.com with ESMTP id p1F1L8DE016182
	for <linux-omap@vger.kernel.org>; Mon, 14 Feb 2011 17:21:08 -0800
Received: from vws18 (vws18.prod.google.com [10.241.21.146])
	by kpbe16.cbf.corp.google.com with ESMTP id p1F1K0LJ008457
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Mon, 14 Feb 2011 17:21:07 -0800
Received: by vws18 with SMTP id 18so3681612vws.21
        for <linux-omap@vger.kernel.org>; Mon, 14 Feb 2011 17:21:07 -0800 (PST)
In-Reply-To: <E1Pnvgw-0002yZ-M0@rmk-PC.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Eric Miao <eric.y.miao@gmail.com>, Kukjin Kim <kgene.kim@samsung.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Feb 11, 2011 at 8:17 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> This adds core support for saving and restoring CPU coprocessor
> registers for suspend/resume support. =A0This contains support for su=
spend
> with ARM920, ARM926, SA11x0, PXA25x, PXA27x, PXA3xx, V6 and V7 CPUs.

I would like to use cpu_suspend in a case where the L2 is still
enabled.  When cpu_resume is called, the MMU and cache bits in SCTLR
are disabled, so the reads skip the L2 cache, and the data that was
saved (sleep_save_sp and *sleep_save_sp) is not read back.

Is it possible to call the outer_cache functions from cpu_suspend to
flush sleep_save_sp and the saved data?
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
