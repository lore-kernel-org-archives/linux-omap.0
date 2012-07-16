From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCHv4 6/8] ARM: OMAP: pm-debug: enhanced usecount debug support
Date: Mon, 16 Jul 2012 17:44:14 +0530
Message-ID: <50040596.9000103@ti.com>
References: <1342189185-5306-1-git-send-email-t-kristo@ti.com>	 <1342189185-5306-7-git-send-email-t-kristo@ti.com>	 <5003F1E9.5080700@ti.com> <1342439156.4672.66.camel@sokoban>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog137.obsmtp.com ([74.125.149.18]:52955 "EHLO
	na3sys009aog137.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751182Ab2GPMOV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Jul 2012 08:14:21 -0400
Received: by yenl3 with SMTP id l3so6352935yen.26
        for <linux-omap@vger.kernel.org>; Mon, 16 Jul 2012 05:14:20 -0700 (PDT)
In-Reply-To: <1342439156.4672.66.camel@sokoban>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: t-kristo@ti.com
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@ti.com, linux-arm-kernel@lists.infradead.org

On Monday 16 July 2012 05:15 PM, Tero Kristo wrote:
>>> >  >
>>> >  >  This patch also provices a way to do printk dumps from kernel code,
>>> >  >  by calling the pm_dbg_dump_X functions. The plan is to call these
>>> >  >  functions once an error condition is detected, e.g. failed suspend.
> ^
> |
> This part is the main motivation for this patch imo.

ah, okay. I missed that part completely.
