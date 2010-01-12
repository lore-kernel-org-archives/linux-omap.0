From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] Audio suspend/resume status on OMAP3 based
	platforms
Date: Tue, 12 Jan 2010 16:11:10 +0000
Message-ID: <20100112161109.GC17092@sirena.org.uk>
References: <5A47E75E594F054BAF48C5E4FC4B92AB031E1D7807@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:51518 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750741Ab0ALQLL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Jan 2010 11:11:11 -0500
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB031E1D7807@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, Jan 12, 2010 at 09:35:15PM +0530, Aggarwal, Anuj wrote:

> b) same command, when audio loopback is running in 
> background

It'd be helpful to specify what you mean by audio loopback here - I
think you mean something along the lines of 'arecord | aplay -' but
it'd be good to confirm since there's multiple meanings people use for
the term.
