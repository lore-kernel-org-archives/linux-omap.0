From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Input: ads7846: add regulator support
Date: Thu, 4 Feb 2010 16:03:26 +0000
Message-ID: <20100204160325.GA29982@rakim.wolfsonmicro.main>
References: <1265290758-2035-1-git-send-email-notasas@gmail.com>
 <20100204142439.GA1139@sirena.org.uk>
 <4B6AE2DB.90809@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:36769 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S933185Ab0BDQD3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Feb 2010 11:03:29 -0500
Content-Disposition: inline
In-Reply-To: <4B6AE2DB.90809@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Rapoport <mike@compulab.co.il>
Cc: Grazvydas Ignotas <notasas@gmail.com>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-omap@vger.kernel.org

On Thu, Feb 04, 2010 at 05:08:11PM +0200, Mike Rapoport wrote:
> Mark Brown wrote:

> > This should not be required.  The regulator API stubs itself out when it
> > is not built so all API calls report as successful.

> And what about boards that have the ads7846 tied to power rail and still
> want to use regulator API for other staff?

That's one of the use cases the fixed voltage regulator is there for
(it's the one that originally caused me to write the driver) - just
define one or more fixed voltage regulators representing the fixed power
rails and hook up the device to that/those.
