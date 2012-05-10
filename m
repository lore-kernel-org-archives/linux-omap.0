From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH v4-alt 0/6] GPMC driver migrate one
Date: Thu, 10 May 2012 06:35:23 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E98A339@DBDE01.ent.ti.com>
References: <cover.1335941443.git.afzal@ti.com>
 <20120508213625.GG5088@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43036 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755893Ab2EJGf2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 May 2012 02:35:28 -0400
In-Reply-To: <20120508213625.GG5088@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Tony,

On Wed, May 09, 2012 at 03:06:26, Tony Lindgren wrote:

> > To resolve this and as per your earlier question on whether old along
> > with new interface can be made to work parallely, here is suggestion
> > from my end to deal with it.
> 
> I think this is the only way to keep this all building and booting
> for each patch in the series, no? If so, then we should select this
> option. The first patch should be broken up into more readable patches,
> it seems that you can do that without breaking things.

Bisectability has been maintained in the patches.

Ok, I will proceed by keeping old & new interface together, will
try to achieve it in smaller patches and without hacks.

> > Please let me know whether you are fine in taking patch series
> > as in v4 (that converts all boards at once, with further revisions
> > based on review comments).
> 
> It seems that there are still some pending comments and we need to
> have the hwmod entries merged first by Paul.

Ok, first I will try to get hwmod in.

Regards
Afzal
