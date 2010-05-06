From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 2/2] OMAP: DSS2: Fix omap_dss_probe() error path
Date: Thu, 06 May 2010 11:54:40 -0700
Message-ID: <87wrvguahb.fsf@deeprootsystems.com>
References: <cover.1273146321.git.ext-jani.1.nikula@nokia.com>
	<bce34ed2a9f7206ddeedb2921807c7602cfcaaaa.1273146322.git.ext-jani.1.nikula@nokia.com>
	<cover.1273146321.git.ext-jani.1.nikula@nokia.com>
	<2af519336cb42682d13d46baf0b770edcada3dac.1273146322.git.ext-jani.1.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:62845 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752123Ab0EFSyp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 May 2010 14:54:45 -0400
Received: by vws18 with SMTP id 18so48784vws.19
        for <linux-omap@vger.kernel.org>; Thu, 06 May 2010 11:54:45 -0700 (PDT)
In-Reply-To: <2af519336cb42682d13d46baf0b770edcada3dac.1273146322.git.ext-jani.1.nikula@nokia.com> (Jani Nikula's message of "Thu\,  6 May 2010 14\:59\:03 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jani Nikula <ext-jani.1.nikula@nokia.com>
Cc: Tomi.Valkeinen@nokia.com, linux-fbdev-devel@lists.sourceforge.net, linux-omap@vger.kernel.org

Jani Nikula <ext-jani.1.nikula@nokia.com> writes:

> From: Jani Nikula <ext-jani.1.nikula@nokia.com>
>
> Perform graceful cleanup on errors instead of just bailing out.
>
> Signed-off-by: Jani Nikula <ext-jani.1.nikula@nokia.com>

Tested-by: Kevin Hilman <khilman@deeprootsystems.com>

Nice.  Much cleaner than my previous one.

Tested on my n900, and with failed init, clocks are turned off
and doesn't prevent suspend.

Thanks,

Kevin
