From: Jani Nikula <ext-jani.1.nikula@nokia.com>
Subject: Re: [PATCH 2/2] OMAP: DSS2: Fix omap_dss_probe() error path
Date: Fri, 7 May 2010 15:12:18 +0300 (EEST)
Message-ID: <alpine.DEB.2.00.1005071511010.24263@wnav-qrfxgbc>
References: <cover.1273146321.git.ext-jani.1.nikula@nokia.com> <bce34ed2a9f7206ddeedb2921807c7602cfcaaaa.1273146322.git.ext-jani.1.nikula@nokia.com> <cover.1273146321.git.ext-jani.1.nikula@nokia.com> <2af519336cb42682d13d46baf0b770edcada3dac.1273146322.git.ext-jani.1.nikula@nokia.com>
 <87wrvguahb.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:36976 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750766Ab0EGMMa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 May 2010 08:12:30 -0400
In-Reply-To: <87wrvguahb.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Valkeinen Tomi (Nokia-D/Helsinki)" <Tomi.Valkeinen@nokia.com>, "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



On Thu, 6 May 2010, ext Kevin Hilman wrote:

> Tested on my n900, and with failed init, clocks are turned off
> and doesn't prevent suspend.

Many thanks for testing this, Kevin!

BR,
Jani.

