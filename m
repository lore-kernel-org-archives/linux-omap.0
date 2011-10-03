From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 24/30] ARM: omap2+: ensure that one of omap2/3/4 is selected
Date: Mon, 03 Oct 2011 10:50:45 +0530
Message-ID: <4E89462D.7010208@ti.com>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de> <1317566760-25681-25-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1317566760-25681-25-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Sunday 02 October 2011 08:15 PM, Arnd Bergmann wrote:
> Random configurations can fail if none of the omap families
> in mach-omap2 is selected. This patch automatically selects
> omap2 if the user has not made any other choice.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

OMAP4 would have been a better default but am fine with
OMAP2 too.

Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
