From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] non-critical omap fixes for v3.1 merge window
Date: Wed, 6 Jul 2011 19:16:12 +0200
Message-ID: <201107061916.13115.arnd@arndb.de>
References: <20110705102349.GE5783@atomide.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:51471 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753218Ab1GFRQV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jul 2011 13:16:21 -0400
In-Reply-To: <20110705102349.GE5783@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>, Thomas Gleixner <tglx@linutronix.de>

On Tuesday 05 July 2011, Tony Lindgren wrote:
> Please pull some fixes from:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git devel-fixes
> 
> These are intented for the merge window, there's no rush for
> these to go in during the -rc cycle this late. I have one fix
> queued for the -rc cycle still that I'll send separately.
> 
> The dmtimer fix in this series has a dependency to the cleanup
> series you pulled earlier.

Pulled and pushed out to arm-soc/omap/fixes.

Thanks,

	Arnd
