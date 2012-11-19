From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH v2 1/2] ARM: OMAP2+: timer: remove CONFIG_OMAP_32K_TIMER
Date: Mon, 19 Nov 2012 10:27:18 -0600
Message-ID: <50AA5DE6.4080700@ti.com>
References: <1353251201-10990-1-git-send-email-grinberg@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50167 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753136Ab2KSQ1X (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Nov 2012 11:27:23 -0500
In-Reply-To: <1353251201-10990-1-git-send-email-grinberg@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Vaibhav Hiremath <hvaibhav@ti.com>


On 11/18/2012 09:06 AM, Igor Grinberg wrote:
> CONFIG_OMAP_32K_TIMER is kind of standing on the single zImage way.
> Make OMAP2+ timer code independant from the CONFIG_OMAP_32K_TIMER
> setting.
> To remove the dependancy, several conversions/additions had to be done:
> 1) Timer initialization functions are named by the platform
>    name and the clock source in use.
>    This also makes it possible to define and use the GPTIMER as the
>    clock source instead of the 32K timer on platforms that do not have
>    the 32K timer ip block or the 32K timer is not wired on the board.
>    Cirrently, the the timer is chosen in the machine_desc structure on

Nit ...

s/Cirrently/Currently

Otherwise ...

Reviewed-by: Jon Hunter <jon-hunter@ti.com>

Thanks for updating this!

Cheers
Jon
