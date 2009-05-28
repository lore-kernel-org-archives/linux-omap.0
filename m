From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: "Dummy" regulator possible?
Date: Thu, 28 May 2009 15:18:43 +0100
Message-ID: <20090528141843.GE19523@sirena.org.uk>
References: <1243500315.32558.27.camel@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:55885 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753421AbZE1OSm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 May 2009 10:18:42 -0400
Content-Disposition: inline
In-Reply-To: <1243500315.32558.27.camel@tubuntu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, May 28, 2009 at 11:45:15AM +0300, Tomi Valkeinen wrote:

> Is it possible to create a dummy regulator, so that the device driver
> could always ask for Vcc supply, and get it, even when it's connected to
> a always-on regulator?

This is exactly the use case that the fixed voltage regulator is
intended for - drivers/regulator/fixed.c.
