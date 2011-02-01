From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH v2 02/13] OMAP: McBSP: Convert McBSP to platform device
 model
Date: Tue, 01 Feb 2011 14:33:47 +0200
Message-ID: <4D47FDAB.5060407@nokia.com>
References: <1296485437-12806-1-git-send-email-kishon@ti.com> <1296485437-12806-3-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:21575 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752348Ab1BAM14 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 Feb 2011 07:27:56 -0500
In-Reply-To: <1296485437-12806-3-git-send-email-kishon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk, broonie@opensource.wolfsonmicro.com, paul@pwsan.com, charu@ti.com, shubhrajyoti@ti.com, b-cousson@ti.com, khilman@deeprootsystems.com, p-basak2@ti.com

On 01/31/2011 04:50 PM, ext Kishon Vijay Abraham I wrote:
> Implement McBSP as platform device and add support for
> registering through platform device layer using resource
> structures.
> 
> Later in this patch series, OMAP2+ McBSP driver would be modified to
> use hwmod framework after populating the omap2+ hwmod database.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  arch/arm/mach-omap1/mcbsp.c             |  383 ++++++++++++++---
>  arch/arm/mach-omap2/mcbsp.c             |  704 +++++++++++++++++++++++++-----
>  arch/arm/plat-omap/devices.c            |   10 +-
>  arch/arm/plat-omap/include/plat/mcbsp.h |   14 +-
>  arch/arm/plat-omap/mcbsp.c              |   60 +++-
>  5 files changed, 966 insertions(+), 205 deletions(-)

Looks good,

Acked-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
