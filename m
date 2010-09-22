From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 10/13 v2] OMAP3: serial: Fix uart4 handling for 3630
Date: Wed, 22 Sep 2010 13:26:00 -0700
Message-ID: <87d3s5a5k7.fsf@deeprootsystems.com>
References: <37596.172.24.137.131.1285168469.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:44823 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754626Ab0IVU0E (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Sep 2010 16:26:04 -0400
In-Reply-To: <37596.172.24.137.131.1285168469.squirrel@dbdmail.itg.ti.com>
	(Govindraj R.'s message of "Wed, 22 Sep 2010 20:44:29 +0530 (IST)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Sergio Aguirre <saaguirre@ti.com>, Tony Lindgren <tony@atomide.com>

"Govindraj.R" <govindraj.raja@ti.com> writes:

> This patch makes the following:
>  - Adds missing wakeup padding register handling.
>  - Fixes a hardcode to use PER module ONLY on UART3.
>
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
> ---
>  arch/arm/mach-omap2/serial.c |    8 ++++++--
>  1 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
> index 72b5c98..c1404af 100644
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -57,7 +57,7 @@
>   * disabled via sysfs. This also causes that any deeper omap sleep states are
>   * blocked.
>   */
> -#define DEFAULT_TIMEOUT 0
> +#define DEFAULT_TIMEOUT 5

Oops

Please leave this at zero.

Kevin
