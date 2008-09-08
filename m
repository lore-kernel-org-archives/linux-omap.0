From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [alsa-devel] [PATCH 3/5] ALSA: ASoC: Add support for TWL4030 audio codec (rev 3)
Date: Mon, 8 Sep 2008 10:56:14 +0100
Message-ID: <20080908095607.GC790@sirena.org.uk>
References: <1220769704-16705-1-git-send-email-sakoman@gmail.com> <1220769704-16705-2-git-send-email-sakoman@gmail.com> <1220769704-16705-3-git-send-email-sakoman@gmail.com> <1220769704-16705-4-git-send-email-sakoman@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:3785 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753608AbYIHJ4S (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Sep 2008 05:56:18 -0400
Content-Disposition: inline
In-Reply-To: <1220769704-16705-4-git-send-email-sakoman@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: sakoman@gmail.com
Cc: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, Steve Sakoman <steve@sakoman.com>

On Sat, Sep 06, 2008 at 11:41:42PM -0700, sakoman@gmail.com wrote:

> +
> +config SND_SOC_TWL4030
> +	tristate
> +	depends on SND_SOC && I2C
> +

Sorry, didn't notice earlier: this should depend on whatever the config
option is for the TWL4030 core driver rather than on I2C since it
doesn't actually interact with I2C directly.  Although in most
applications this won't make much odds since the machine driver will
select the codec driver and select ignores the dependencies anyway.
