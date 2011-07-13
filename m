From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCHv2 0/5] OMAP SMPS regulator driver
Date: Thu, 14 Jul 2011 08:22:30 +0900
Message-ID: <20110713232228.GC9770@opensource.wolfsonmicro.com>
References: <1310565638-13140-1-git-send-email-t-kristo@ti.com>
 <87r55uxay2.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:53207 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752717Ab1GMXWh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Jul 2011 19:22:37 -0400
Content-Disposition: inline
In-Reply-To: <87r55uxay2.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, lrg@ti.com, Paul Walmsley <paul@pwsan.com>

On Wed, Jul 13, 2011 at 12:00:37PM -0700, Kevin Hilman wrote:

> Actually, I'd prefer it stay in drivers/regulator.  We're trying to move
> driver-type stuff out of arch/arm/* into the right place in drivers/*.
> In fact, I wonder if our VP/VC layers might better live under
> drivers/regulator also.

Well, if they don't look hideous in the API then sure.  I'd guess it's
probably a case of lifting the implementation APIs that Tero's driver is
calling up into the regulator driver he's writing.
