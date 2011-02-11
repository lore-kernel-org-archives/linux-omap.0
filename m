From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH] omap3: cpuidle: Add description field to each C-state.
Date: Fri, 11 Feb 2011 19:07:23 +0200
Message-ID: <20110211190723.b93bcb60.jhnikula@gmail.com>
References: <1297437132-1005-1-git-send-email-santosh.shilimkar@ti.com>
	<1297437132-1005-2-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:61312 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756787Ab1BKRH1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Feb 2011 12:07:27 -0500
Received: by bwz15 with SMTP id 15so3404434bwz.19
        for <linux-omap@vger.kernel.org>; Fri, 11 Feb 2011 09:07:26 -0800 (PST)
In-Reply-To: <1297437132-1005-2-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org

On Fri, 11 Feb 2011 20:42:12 +0530
Santosh Shilimkar <santosh.shilimkar@ti.com> wrote:

> Add a description field to each idle C-state. This helps to give
> better data with PowerTop and one don't have to refer to the code
> to link what Cx means from system point of view while analysing
> PowerTop data.
> 
> No functional change.
> 
Out of curiosity what powertop version is required to get these handy
descriptions visible?

As I see these in /sys/devices/system/cpu/cpu0/cpuidle/stateX/desc it's
fair to give my tested by

Tested-by: Jarkko Nikula <jhnikula@gmail.com>
