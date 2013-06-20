From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] ARM: OMAP: Device Tree for 3.11
Date: Thu, 20 Jun 2013 11:05:14 +0200
Message-ID: <201306201105.14675.arnd@arndb.de>
References: <51C23902.1080301@ti.com> <20130620064541.GE5523@atomide.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:55535 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755398Ab3FTJFs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Jun 2013 05:05:48 -0400
In-Reply-To: <20130620064541.GE5523@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Olof Johansson <olof@lixom.net>, Benoit Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Florian Vaussard <florian.vaussard@epfl.ch>, Vaibhav Hiremath <hvaibhav@ti.com>, Eduardo Valentin <eduardo.valentin@ti.com>, Mohammed Afzal <afzal@ti.com>, Paul Walmsley <paul@pwsan.com>, Roger Quadros <rogerq@ti.com>

On Thursday 20 June 2013, Tony Lindgren wrote:
> * Benoit Cousson <b-cousson@ti.com> [130619 16:10]:
> > Hi Tony,
> > 
> > Please pull the following commits for OMAP Device Tree for v3.11.
> > 
> > It does contains as well 2 clock data patches, I hope it will not generate any conflict with Paul's tree. 
> > 
> > Special thanks to Florian for his nice cleanup using the C preprocessor.
> 
> It's best that Arnd and Olof take this pull request directly as we're
> getting so close to the merge window. These patches should be pretty
> much independent of the other branches I've sent, and are needed to
> keep omap4 booting now that we've flipped the switch for omap4 to be  
> DT only.

Ok, I've put it in my queue. About 60 pull requests to take care of
at the moment, so it might take a few days.

	Arnd
