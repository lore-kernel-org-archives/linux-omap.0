From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC/PATCH 00/26] PM: Create the AVS class of drivers
Date: Tue, 22 Nov 2011 16:43:02 +0000
Message-ID: <20111122164302.GI6624@sirena.org.uk>
References: <1321974370-25800-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:36051 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754035Ab1KVQnG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Nov 2011 11:43:06 -0500
Content-Disposition: inline
In-Reply-To: <1321974370-25800-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, paul@pwsan.com, khilman@ti.com, balbi@ti.com, rjw@sisk.pl, Jean Pihet <j-pihet@ti.com>

On Tue, Nov 22, 2011 at 04:05:44PM +0100, jean.pihet@newoldbits.com wrote:

> AVS is a power management technique which controls the operating
> voltage of a device in order to optimize (i.e. reduce) its power
> consumption. The voltage is adapted depending on static factors
> (chip manufacturing process) and dynamic factors (temperature
> depending performance).
> AVS is also called SmartReflex on OMAP devices.

This sounds a lot like what devfreq (which was recently merged) is
supposed to do.  Have you looked at the overlap there?
