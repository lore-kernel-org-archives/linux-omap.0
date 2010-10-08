From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] Revert "OMAP: mach-omap2: Fix incorrect assignment
 warnings"
Date: Fri, 8 Oct 2010 11:53:18 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1010081152160.6632@utopia.booyaka.com>
References: <AANLkTimCXyTh30iGVd2j8JUcfT2a0+xrT8AqjX=qQ0k+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:44422 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932552Ab0JHRxU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Oct 2010 13:53:20 -0400
In-Reply-To: <AANLkTimCXyTh30iGVd2j8JUcfT2a0+xrT8AqjX=qQ0k+@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap@vger.kernel.org, "G, Manjunath Kondaiah" <manjugk@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

On Fri, 8 Oct 2010, Jean Pihet wrote:

> The intent behind the original patch was to fix some compiler
> warnings, which I do not have on my side. Is the problem dependent on
> the setup and config used?

It's probably a warning from sparse --

https://sparse.wiki.kernel.org/index.php/Main_Page

Maybe it will show up if you

make C=2

?


- Paul
