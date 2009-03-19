From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [alsa-devel] [PATCH] ASoC: Declare Headset as Mic and
	Headphone widgets for SDP3430
Date: Thu, 19 Mar 2009 12:01:25 +0000
Message-ID: <20090319120124.GD1598@sirena.org.uk>
References: <2C7D3DF36ADFFC479B44490D912B616705ECF95F43@dlee07.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:46043 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751204AbZCSMB2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Mar 2009 08:01:28 -0400
Content-Disposition: inline
In-Reply-To: <2C7D3DF36ADFFC479B44490D912B616705ECF95F43@dlee07.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Lopez Cruz, Misael" <x0052729@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, Mar 19, 2009 at 01:07:34AM -0500, Lopez Cruz, Misael wrote:
> Headset was declared previously as a Headphone widget connecting
> HSMIC and HSOL/HSOR pins of TWL4030 codec in SDP430 machine driver.
> The capture path becomes invalid as the Headphone widget is not a
> valid input endpoint.

Applied, thanks.
