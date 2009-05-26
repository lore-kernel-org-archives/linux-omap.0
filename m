From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/8] ARM: OMAP3: mmc-twl4030 uses regulator framework
Date: Tue, 26 May 2009 13:59:38 +0100
Message-ID: <20090526125938.GD8969@sirena.org.uk>
References: <20090525174517.19679.18805.stgit@localhost> <20090525174821.19679.1412.stgit@localhost> <1243291650.10927.15.camel@brutus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:35742 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755662AbZEZM7n (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 May 2009 08:59:43 -0400
Content-Disposition: inline
In-Reply-To: <1243291650.10927.15.camel@brutus>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Ribeiro <drwyrm@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.arm.linux.org.uk, David Brownell <dbrownell@users.sourceforge.net>, linux-omap@vger.kernel.org, Pierre Ossman <drzeus-list@drzeus.cx>

On Mon, May 25, 2009 at 07:47:30PM -0300, Daniel Ribeiro wrote:

> This hack would look less ugly on twl4030reg_probe(). There you can
> disable the regulator without first enabling it.

That might cause issues when running on a platform where someone has
used the MMC regulators for some purpose other than MMC and expects them
to stay on during boot.  It can be done via the machine constraints if
required, though.
