From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 1/9] omap4: powerdomain: Add supported INACTIVE power
 state
Date: Sun, 6 Feb 2011 13:42:23 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1102061335400.7672@utopia.booyaka.com>
References: <1296813544-25170-1-git-send-email-santosh.shilimkar@ti.com> <1296813544-25170-2-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:36009 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753896Ab1BFUmY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 6 Feb 2011 15:42:24 -0500
In-Reply-To: <1296813544-25170-2-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, b-cousson@ti.com, rnayak@ti.com, linux-arm-kernel@lists.infradead.org

Hi

On Fri, 4 Feb 2011, Santosh Shilimkar wrote:

> On OMAP4, one can explicitly program INACTIVE as the power state of
> the logic area inside the power domain. Techincally PD state programmed
> to ON and if all the clock domains within the PD are idled, is equivalent
> tp PD programmed to INACTIVE and all the clock domains within the PD are
> idled. There won't be any power difference in above two.
> 
> This patch adds the support to allow power domain INACTIVE programming
> which is supported on OMAP4.
> 
> The powerdomain autogen script is updated accordingly.

Continuing the discussion here:

   http://www.mail-archive.com/linux-omap@vger.kernel.org/msg43509.html

1. It appears that the OMAP4 powerdomain ON-ACTIVE state is a new state 
for OMAP4, and does not exist as such on previous chips (unless the 
PRM_VOLTCTRL.AUTO_* bits are all disabled)

2. It also appears that the OMAP4 powerdomain ON-INACTIVE state 
is equivalent to the OMAP3 powerdomain ON state (again, assuming that the 
PRM_VOLTCTRL.AUTO_SLEEP bit is set on OMAP3).

Could you please comment on whether these statements are true or false?


- Paul
