From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: watchdog pdev id set to -1
Date: Tue, 22 Feb 2011 21:59:23 +0000
Message-ID: <20110222215923.GB28740@sirena.org.uk>
References: <FCCFB4CDC6E5564B9182F639FC3560870370061699@dbde02.ent.ti.com> <20110218105635.GB10489@legolas.emea.dhcp.ti.com> <FCCFB4CDC6E5564B9182F639FC35608703700616CE@dbde02.ent.ti.com> <20110218111237.GE10489@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:57410 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750990Ab1BVV7Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Feb 2011 16:59:25 -0500
Content-Disposition: inline
In-Reply-To: <20110218111237.GE10489@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: "Koyamangalath, Abhilash" <abhilash.kv@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, Feb 18, 2011 at 01:12:37PM +0200, Felipe Balbi wrote:

> On Fri, Feb 18, 2011 at 04:39:48PM +0530, Koyamangalath, Abhilash wrote:
> > I understand, but is there a subtle reason why are starting from
> > an erroneous-looking -1 rather than a more natural 0 (or 1 ?).

> -1 means no ID. The IDs are zero-based, so we can't use zero. Just
> change that value and see how things change on sysfs and dmesg then you
> will know what I'm talking about. That's just an implementation decision
> of using -1 to signify "no ID needed".

Though looking at the report it looks like the omap_device print that's
done during boot is doing the wrong thing here and displaying the -1
instead of masking it from the print which is what's expected.
