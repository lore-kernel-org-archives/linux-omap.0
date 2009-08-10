From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Audio on OMAP3
Date: Mon, 10 Aug 2009 10:51:57 +0100
Message-ID: <20090810095156.GA24947@sirena.org.uk>
References: <4A7F068D.6090407@mlbassoc.com> <20090809190452.GC4390@sirena.org.uk> <4A7F32CA.8000108@mlbassoc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:60123 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753305AbZHJJv5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Aug 2009 05:51:57 -0400
Content-Disposition: inline
In-Reply-To: <4A7F32CA.8000108@mlbassoc.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Gary Thomas <gary@mlbassoc.com>
Cc: linux-omap@vger.kernel.org

On Sun, Aug 09, 2009 at 02:34:18PM -0600, Gary Thomas wrote:

> Thanks.  How is this normally configured - ALSA or OSS?

It's all ALSA.  There is some OSS emulation for ALSA.

> What tools have been used (simple busybox system, not Android)?

It's all standard ALSA stuff from the point of view of userspace.
