From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [APPLIED] Overo broken after recent mainline merge
Date: Mon, 23 Mar 2009 16:00:44 +0000
Message-ID: <20090323160043.GA13022@sirena.org.uk>
References: <notify-1237576717@atomide.com> <200903201533.24620.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:56297 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759236AbZCWQAv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Mar 2009 12:00:51 -0400
Content-Disposition: inline
In-Reply-To: <200903201533.24620.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

On Fri, Mar 20, 2009 at 03:33:24PM -0700, David Brownell wrote:

> +				dev_warn(dev, "APPLY REGULATOR HACK for vmmc\n");

...

> +					dev_warn(dev, "APPLY REGULATOR HACK "
> +						"for vmmc_aux\n");

Please remove these hunks, it's not useful to the users to log this.  No
action is required on their part and this is expected behaviour.
