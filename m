From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 03/15] ARM: OMAP: mailbox: Convert to device_initcall
Date: Sat, 3 Nov 2012 21:42:20 +0530
Message-ID: <50954264.50000@ti.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com> <1351859566-24818-4-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43757 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756489Ab2KCQM3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 3 Nov 2012 12:12:29 -0400
In-Reply-To: <1351859566-24818-4-git-send-email-vaibhav.bedia@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Bedia <vaibhav.bedia@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, b-cousson@ti.com, tony@atomide.com

On Friday 02 November 2012 06:02 PM, Vaibhav Bedia wrote:
> The power management code for AM33XX is a late_initcall
> and the PM features depend on the mailbox for IPC.
> In preparation for this, convert the mailbox init to
> a device_initcall.
>
> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> ---
Looks fine
