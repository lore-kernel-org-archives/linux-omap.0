From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH 0/4] Updates on mcbsp driver (take #2)
Date: Fri, 13 Jun 2008 09:31:33 +0300
Message-ID: <20080613093133.b91dbcfb.jarkko.nikula@nokia.com>
References: <1210022587-7756-1-git-send-email-edubezval@gmail.com>
	<5e088bd90805190726v69f5d7coc9eebb65d915ff7a@mail.gmail.com>
	<a0580c510805190809l58f507eck62a13f659524b969@mail.gmail.com>
	<20080520142128.3498f258.jarkko.nikula@nokia.com>
	<5e088bd90806121214q33f24c51t3dad859fc6b04a74@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:53644 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753404AbYFMGbb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Jun 2008 02:31:31 -0400
In-Reply-To: <5e088bd90806121214q33f24c51t3dad859fc6b04a74@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Steve Sakoman <sakoman@gmail.com>
Cc: ext Eduardo Valentin <edubezval@gmail.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Chandra shekhar <x0044955@ti.com>, Eduardo Valentin <eduardo.valentin@indt.org.br>

On Thu, 12 Jun 2008 12:14:08 -0700
"ext Steve Sakoman" <sakoman@gmail.com> wrote:

> Jarkko,
> 
> I've been using this patch with good results while developing an alsa
> soc driver for the 35XX EVM and beagleboard.
> 
> Do you have plans to to officially submit this patch (or a more recent
> version of it)?
> 
This is nice to hear :-)

Definitely it will be submitted. Currently not possible since McBSP
changes are not in mainstream yet but I'll do early patch releases when
needed so people can do their development.

Eduardo, any news adding support for additional ports in McBSP? It would
be nice to add those five 2430 & 3430 ports at once to omap-mcbsp.c.


Jarkko
