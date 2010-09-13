From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: Suspend to RAM broken on BeagleBoard ?
Date: Mon, 13 Sep 2010 17:39:33 +0200
Message-ID: <20100913173933.5d0a6392@surf>
References: <20100910174814.6e5d439e@surf>
	<87sk1h4640.fsf@deeprootsystems.com>
	<20100911110007.5f7b529d@surf>
	<87eicx1ykp.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:42834 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753006Ab0IMPjj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Sep 2010 11:39:39 -0400
In-Reply-To: <87eicx1ykp.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hello,

On Mon, 13 Sep 2010 07:56:54 -0700
Kevin Hilman <khilman@deeprootsystems.com> wrote:

> Looks like DSS has not been initialized, so is not hitting RET.
> 
> Do you have the DSS driver enabled and built-in?  Without this (and
> until we have DSS converted to hwmod) the DSS HW is not in a state that
> can hit the low power mode.  If the DSS driver is allowed to initialize,
> even without a panel, it should set the DSS HW in a state that will then
> allow RET.

Indeed:

$ grep DSS .config
# CONFIG_OMAP2_DSS is not set

It's not enabled simply because it isn't enabled by omap3_defconfig. So
maybe it should also be fixed for this ?

I have zero knowledge of DSS, but shouldn't the kernel be able to
suspend properly even if the DSS driver is disabled ? But maybe it's
too complicated to have the DSS init sequence required to allow the
system to hit RET outside the DSS driver. Thoughts ?

Regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
