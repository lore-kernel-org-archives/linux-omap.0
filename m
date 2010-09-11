From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: Suspend to RAM broken on BeagleBoard ?
Date: Sat, 11 Sep 2010 11:00:07 +0200
Message-ID: <20100911110007.5f7b529d@surf>
References: <20100910174814.6e5d439e@surf>
	<87sk1h4640.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:34262 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754205Ab0IKJAN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 11 Sep 2010 05:00:13 -0400
In-Reply-To: <87sk1h4640.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, 10 Sep 2010 14:54:23 -0700
Kevin Hilman <khilman@deeprootsystems.com> wrote:

> It's the CPUfreq driver that's failing to suspend.

Ok.

> Yes, CPUfreq is not supported in l-o master or pm-core (only in the
> full pm branch.)  If you Kconfig out CPUfreq, this failure will go
> away.

Aah, yes, I forgot about this. I know it's temporary, but wouldn't it
be good to disable CPUfreq in omap3_defconfig in this case ?

BTW, I'm now seeing:

[   37.830596] Powerdomain (core_pwrdm) didn't enter target state 1
[   37.830627] Powerdomain (dss_pwrdm) didn't enter target state 1

when the system is woken up.

Concerning the USB issue, no idea ?

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
