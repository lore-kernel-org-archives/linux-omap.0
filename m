From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH 1/2]  McBSP DMA support for  34xx
Date: Thu, 28 Aug 2008 13:52:02 +0300
Message-ID: <20080828135202.657264e6.jarkko.nikula@nokia.com>
References: <51857.192.168.10.89.1219911960.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:55879 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752272AbYH1Kwq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Aug 2008 06:52:46 -0400
In-Reply-To: <51857.192.168.10.89.1219911960.squirrel@dbdmail.itg.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext chandra shekhar <x0044955@ti.com>
Cc: linux-omap@vger.kernel.org

On Thu, 28 Aug 2008 13:56:00 +0530 (IST)
"ext chandra shekhar" <x0044955@ti.com> wrote:

> This patch supports DMA chaining mode and one time configuration for
> entire transfer to improve performance.
> Signed-off-by: chandra shekhar <x0044955@ti.com>
> ---
>  arch/arm/mach-omap2/mcbsp.c       |  702 ++++++++++++++++++++++++++++
> +++++++++- arch/arm/plat-omap/mcbsp.c        |   19 -
>  include/asm-arm/arch-omap/mcbsp.h |  127 +++++-
>  3 files changed, 811 insertions(+), 37 deletions(-)
> 
Hi

What's the expected use case for DMA chaining mode or existing driver
which would get improved performance? There should have some reason why
this amount of new lines should be added.

Also ideally this should cover also OMAP1's from 16xx onward since they
can link DMA channels together as well?


Jarkko
