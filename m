From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ASoC: OMAP: HDMI: Prevent DSS module from going idle
 when playing audio
Date: Fri, 16 Dec 2011 01:27:29 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1112160121250.12660@utopia.booyaka.com>
References: <1324019032-31532-1-git-send-email-ricardo.neri@ti.com>  <alpine.DEB.2.00.1112160107380.12660@utopia.booyaka.com> <1324023504.1859.11.camel@deskari>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:44893 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751229Ab1LPI1a (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Dec 2011 03:27:30 -0500
In-Reply-To: <1324023504.1859.11.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Ricardo Neri <ricardo.neri@ti.com>, b-cousson@ti.com, linux-omap@vger.kernel.org, mythripk@ti.com, s-guiriec@ti.com, lrg@ti.com, peter.ujfalusi@ti.com

On Fri, 16 Dec 2011, Tomi Valkeinen wrote:

> But with DT we can't use func pointers in platform_data either, right?

In the future, if someone wants to run a platform_data-less kernel, 
they'll have to come up with a replacement mechanism for these.  Several 
replacements have been proposed internally, such as having an 
omap_bus/omap_device for devices with OMAP-specific integration, but right 
now there are more pressing crises to deal with...


- Paul
