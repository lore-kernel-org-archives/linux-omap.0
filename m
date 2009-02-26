From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [patch/rfc 2.6.29-rc6 2/2] regulator: twl4030 voltage
 enumeration (v2)
Date: Thu, 26 Feb 2009 22:16:58 +0000
Message-ID: <1235686618.31223.107.camel@vega.slimlogic.co.uk>
References: <200902081037.06645.david-b@pacbell.net>
	 <200902231245.44360.david-b@pacbell.net>
	 <200902231254.13990.david-b@pacbell.net>
	 <200902261150.15125.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from slimlogic.co.uk ([89.16.172.20]:48565 "EHLO slimlogic.co.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753678AbZBZWRD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Feb 2009 17:17:03 -0500
In-Reply-To: <200902261150.15125.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Mark Brown <broonie@sirena.org.uk>, lkml <linux-kernel@vger.kernel.org>, OMAP <linux-omap@vger.kernel.org>

On Thu, 2009-02-26 at 11:50 -0800, David Brownell wrote:
> From: David Brownell <dbrownell@users.sourceforge.net>
> 
> Update previously-posted twl4030 regulator driver to export
> supported voltages to upper layers using a new mechanism.
> 
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> ---
> Updates since previous version:  match updated [1/2] interfaces.
> 
> Note that the twl4030 regulator patch referred to will need a
> minor patch to work with the -next tree, because of interface
> change in the regulator framework.
> 
>  drivers/regulator/twl4030-regulator.c |   62 +++++++++++---------------------
>  1 file changed, 23 insertions(+), 39 deletions(-)

Applied.

Thanks

Liam

