From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCHv3 9/9] ARM: OMAP2+: AM33XX: Hookup AM33XX PM code into
 OMAP builds
Date: Thu, 8 Aug 2013 10:53:45 -0400
Message-ID: <5203B0F9.9090603@ti.com>
References: <1375811376-49985-1-git-send-email-d-gerlach@ti.com> <1375811376-49985-10-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33115 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934262Ab3HHOyR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Aug 2013 10:54:17 -0400
In-Reply-To: <1375811376-49985-10-git-send-email-d-gerlach@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@linaro.org>, Vaibhav Bedia <vaibhav.bedia@ti.com>

On Tuesday 06 August 2013 01:49 PM, Dave Gerlach wrote:
> From: Vaibhav Bedia <vaibhav.bedia@ti.com>
> 
> With all the requisite changes in place we can now
> enable the basic PM support for AM335x. This patch
> updates the various OMAP files to enable suspend-resume
> on AM335x.
> 
> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> ---
>  arch/arm/mach-omap2/Kconfig         |    7 +++++--
>  arch/arm/mach-omap2/Makefile        |    2 ++
>  arch/arm/mach-omap2/board-generic.c |    1 +
>  arch/arm/mach-omap2/common.h        |   10 ++++++++++
>  arch/arm/mach-omap2/io.c            |    5 +++++
>  arch/arm/mach-omap2/pm.c            |    3 ++-
>  arch/arm/mach-omap2/pm.h            |    5 +++++
>  arch/arm/mach-omap2/sram.c          |   10 +++++++++-
>  arch/arm/mach-omap2/sram.h          |    2 ++
>  9 files changed, 41 insertions(+), 4 deletions(-)
> 
The patch looks fine but too many changes in one patch
than my liking. No strong preference though.

Acked-by: Santosh Shilikar<santosh.shilimkar@ti.com>

