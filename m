From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] [PATCH 09/10] ASoC: omap-abe-twl6040: Add missing
 audio route information
Date: Wed, 14 Dec 2011 10:14:08 +0000
Message-ID: <20111214101407.GA25088@sirena.org.uk>
References: <1323856022-24053-1-git-send-email-peter.ujfalusi@ti.com>
 <1323856022-24053-10-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:50942 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753848Ab1LNKOL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Dec 2011 05:14:11 -0500
Content-Disposition: inline
In-Reply-To: <1323856022-24053-10-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Misael Lopez Cruz <misael.lopez@ti.com>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org

On Wed, Dec 14, 2011 at 11:47:02AM +0200, Peter Ujfalusi wrote:
> AUXL/R: connected to FM transmitter on SDP4430
> Vibra: connected to vibrator drivers (only SDP4430)

This is an example of the sort of thing I was talking about with the
platform data - if someone does a variant of SDP4430 with the FM
transmitter removed they'd have to add a completely new board
definition.
