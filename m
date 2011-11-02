From: Kevin Hilman <khilman@ti.com>
Subject: Re: [GIT PULL] gpio/omap: minor cleanups for v3.2
Date: Wed, 02 Nov 2011 15:27:25 -0700
Message-ID: <4EB1C3CD.4030907@ti.com>
References: <8739g91dp5.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:59054 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750786Ab1KBW1i (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Nov 2011 18:27:38 -0400
Received: by mail-pz0-f41.google.com with SMTP id 36so1461590pzk.0
        for <linux-omap@vger.kernel.org>; Wed, 02 Nov 2011 15:27:31 -0700 (PDT)
In-Reply-To: <8739g91dp5.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Hi Grant,

On 09/06/2011 03:57 PM, Kevin Hilman wrote:
> Grant,
> 
> Please pull the following OMAP GPIO cleanups for v3.2.
> 
> Just a heads up: we're also working on another large series of cleanup
> for this driver that we'll be trying to merge for v3.2.
> 
> Kevin

I don't see this in linux-next or your gpio/next branch.  Are you
planning to pull this for v3.2?

Kevin

> 
> The following changes since commit fcb8ce5cfe30ca9ca5c9a79cdfe26d1993e65e0c:
> 
>   Linux 3.1-rc3 (2011-08-22 11:42:53 -0700)
> 
> are available in the git repository at:
>   git://gitorious.org/khilman/linux-omap-pm.git for_3.2/gpio-cleanup
> 
> Kevin Hilman (1):
>       gpio/omap: replace MOD_REG_BIT macro with static inline
> 
> Todd Poynor (1):
>       gpio/omap: check return value from irq_alloc_generic_chip
> 
>  drivers/gpio/gpio-omap.c |   59 ++++++++++++++++++++++++++-------------------
>  1 files changed, 34 insertions(+), 25 deletions(-)

