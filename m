From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4 0/2] OMAP: DSS2: Framework to handle omap version
 specific DSS features
Date: Wed, 15 Sep 2010 10:59:21 -0700
Message-ID: <20100915175921.GE4174@atomide.com>
References: <1284559794-4771-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:55153 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753847Ab0IOR71 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Sep 2010 13:59:27 -0400
Content-Disposition: inline
In-Reply-To: <1284559794-4771-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "archit@ti.com" <archit@ti.com>
Cc: tomi.valkeinen@nokia.com, linux-omap@vger.kernel.org

* archit@ti.com <archit@ti.com> [100915 07:00]:
> From: Archit Taneja <archit@ti.com>
> 
> This is a simple approach to prevent scattered cpu_is_omapxxxx checks
> in DSS2 by bringing all omap version specific DSS features/values to one
> single place, initialize them and expose a set of functions to DSS2 driver
> files which return the value/existance of a feature.

Glad to hear. We should absolutely not use cpu_is_omapxxxx checks
anywhere in the drivers. The drivers should be arch independent.
Basically any driver using those is broken from Linux point of view.

The current mess is:

$ grep -r cpu_is_omap drivers/ | wc -l
139

The right way to replace those is to pass feature flags from
the platform_data.

Tony
