From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: 2.6.29 and SDP3430
Date: Thu, 9 Apr 2009 22:34:20 +0100
Message-ID: <20090409213420.GA7042@sirena.org.uk>
References: <782515bb0904082345j2a44da65s909a6834bab07330@mail.gmail.com> <20090409100343.71d34c16.jarkko.nikula@nokia.com> <13B9B4C6EF24D648824FF11BE8967162037BCF18A5@dlee02.ent.ti.com> <7A436F7769CA33409C6B44B358BFFF0CFFB1EEE1@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:44542 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751541AbZDIVec (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Apr 2009 17:34:32 -0400
Content-Disposition: inline
In-Reply-To: <7A436F7769CA33409C6B44B358BFFF0CFFB1EEE1@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: "Woodruff, Richard" <r-woodruff2@ti.com>, Jarkko Nikula <jarkko.nikula@nokia.com>, linux-omap <linux-omap@vger.kernel.org>

On Thu, Apr 09, 2009 at 01:32:27PM -0500, Menon, Nishanth wrote:

> implementor 41 architecture 3 part 30 variant c rev 1
> regulator_init_complete: incomplete constraints, leaving VAUX3 on

That last message shouldn't be a problem - it means that if the machine
init code had requested it the regulator core would've powered off the
VAUX3 regulator since it has no users.
