From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH] OMAP2 OneNAND GPIO fix
Date: Tue, 16 Dec 2008 10:39:09 +0200
Message-ID: <20081216103909.60b9ba67.jarkko.nikula@nokia.com>
References: <200812111759.15180.jpihet@mvista.com>
	<20081215234058.GC19551@atomide.com>
	<200812160919.24771.jpihet@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:49181 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998AbYLPIjy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Dec 2008 03:39:54 -0500
In-Reply-To: <200812160919.24771.jpihet@mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Jean Pihet <jpihet@mvista.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

On Tue, 16 Dec 2008 09:19:24 +0100
"ext Jean Pihet" <jpihet@mvista.com> wrote:

> On Tuesday 16 December 2008 00:40:59 Tony Lindgren wrote:
> > * Jean Pihet <jpihet@mvista.com> [081211 09:02]:
> > > Hi,
> > >
> > > Here is a patch to have the OMAP2 OneNAND driver compile on the latest
> > > tree. I do not know if this has been addressed already, here is a patch.
> >
> > Looks like I already applied similar fixes. These are queued up for
> > mainline too BTW.
> Ok. My patch also changes the request and free omap calls to the standard 
> version. I can generate a new patch if needed.
> 
IRCC gpiolib conversion patches are already going. Tony?


Jarkko
