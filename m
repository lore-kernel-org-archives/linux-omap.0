From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [alsa-devel] [PATCH 1/3] ASoC: Add GPIO support for jack
	reporting interface
Date: Tue, 3 Mar 2009 00:43:20 +0000
Message-ID: <20090303004319.GA10159@sirena.org.uk>
References: <2C7D3DF36ADFFC479B44490D912B616705EC8B1C03@dlee07.ent.ti.com> <20090226115243.GC4229@sirena.org.uk> <2C7D3DF36ADFFC479B44490D912B616705ECC76DF8@dlee07.ent.ti.com> <20090227130502.GA4415@sirena.org.uk> <2C7D3DF36ADFFC479B44490D912B616705ECC77374@dlee07.ent.ti.com> <20090302113845.GA19744@sirena.org.uk> <2C7D3DF36ADFFC479B44490D912B616705ECC77862@dlee07.ent.ti.com> <20090302225527.GA6390@sirena.org.uk> <2C7D3DF36ADFFC479B44490D912B616705ECD6D789@dlee07.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:1983 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751387AbZCCAna (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Mar 2009 19:43:30 -0500
Content-Disposition: inline
In-Reply-To: <2C7D3DF36ADFFC479B44490D912B616705ECD6D789@dlee07.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Lopez Cruz, Misael" <x0052729@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, Mar 02, 2009 at 06:03:12PM -0600, Lopez Cruz, Misael wrote:

> Then, when to trigger the callback? Every time jack status is going to
> be updated?

Yes.  Note that if we're going to add a callback it should be done as a
separate patch since it's a separate feature.  It's probably as well to
get the GPIO jack detection and support for your system merged and then
worry about any callback separately.
