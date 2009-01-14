From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/2] Include TPS6235x based Power regulator support
Date: Wed, 14 Jan 2009 18:10:35 +0000
Message-ID: <20090114181035.GC8108@sirena.org.uk>
References: <1231832468-7132-1-git-send-email-mani.pillai@ti.com> <200901131619.28700.david-b@pacbell.net> <19F8576C6E063C45BE387C64729E739403ECF70CCA@dbde02.ent.ti.com> <200901140955.58616.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:4829 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752940AbZANSKi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Jan 2009 13:10:38 -0500
Content-Disposition: inline
In-Reply-To: <200901140955.58616.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: "Pillai, Manikandan" <mani.pillai@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, Jan 14, 2009 at 09:55:58AM -0800, David Brownell wrote:

> problem vanishes.  Only the tps6235x.c driver, and in this case
> the regulator framework (sigh), care about that platform_data. 

The regulator framework will be fixed in .30.
