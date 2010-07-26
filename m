From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH] [ARM] video/omap2/tdo35s: fix visual artefacts
Date: Mon, 26 Jul 2010 11:03:25 +0300
Message-ID: <1280131405.2427.11.camel@tubuntu.research.nokia.com>
References: <1278931370-19912-1-git-send-email-grinberg@compulab.co.il>
	 <4C4705DB.4000402@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:39726 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753335Ab0GZIDx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Jul 2010 04:03:53 -0400
In-Reply-To: <4C4705DB.4000402@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Igor Grinberg <grinberg@compulab.co.il>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Mike Rapoport <mike@compulab.co.il>

On Wed, 2010-07-21 at 16:36 +0200, ext Igor Grinberg wrote:
> ping!

Man has to have his vacation!

> > TDO35S samples the data on the falling adge of the pixel clock,
> > therefore the data strobe should be on the raising edge.

Looks fine to me, except I'd like the patch subject to be in line with
the other patches (ie. prefixed by OMAP: DSS2: ...), and I think it
should describe the change more precisely, perhaps something like "fix
the video signal".

I can make those changes as I apply it to my tree, if it's ok to you.

 Tomi


