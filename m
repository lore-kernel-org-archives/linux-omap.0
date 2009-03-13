From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [alsa-devel] [PATCH] SoC: Move headset jack registration to
	device initialization for SDP3430
Date: Fri, 13 Mar 2009 12:43:57 +0000
Message-ID: <20090313124356.GA8989@sirena.org.uk>
References: <2C7D3DF36ADFFC479B44490D912B616705ECF129A3@dlee07.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:1992 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752759AbZCMMoQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Mar 2009 08:44:16 -0400
Content-Disposition: inline
In-Reply-To: <2C7D3DF36ADFFC479B44490D912B616705ECF129A3@dlee07.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Lopez Cruz, Misael" <x0052729@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, Mar 12, 2009 at 09:45:27PM -0500, Lopez Cruz, Misael wrote:

> the card is registed. As a consequence of jack device registered
> properly, the jack is detected as an input device.

> Signed-off-by: Misael Lopez Cruz <x0052729@ti.com>

Applied, thanks.
