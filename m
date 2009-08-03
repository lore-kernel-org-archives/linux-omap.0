From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC] [PATCH] ASoC: OMAP: full duplex mode fix
Date: Mon, 3 Aug 2009 10:43:47 +0100
Message-ID: <20090803094346.GA7820@rakim.wolfsonmicro.main>
References: <200908030332.06727.jkrzyszt@tis.icnet.pl>
 <20090803112950.3fb6cda9.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:47684 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753176AbZHCJns (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Aug 2009 05:43:48 -0400
Content-Disposition: inline
In-Reply-To: <20090803112950.3fb6cda9.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, alsa-devel@alsa-project.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, e3-hacking@earth.li

On Mon, Aug 03, 2009 at 11:29:50AM +0300, Jarkko Nikula wrote:
> Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> wrote:

> > +		else
> > +			/* looks like playback already in progress,
> > +			 * start capture by taking it out of error condition */
> > +			omap_mcbsp_pollread(mcbsp_data->bus_id, &buf);

> Minor note: See preferred style for multi-line comments in
> Documentation/CodingStyle. I'm not 100 % sure about the braces but I
> think they are also preferred if there are indented comment lines with
> the single code line.

Indeed; only omit the braces if the *only* thing in the block is a
single statement.
