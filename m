From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH 04/13] OMAP: hwmod: Fix the missing braces
Date: Wed, 23 Jun 2010 18:19:09 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1006231818490.1550@utopia.booyaka.com>
References: <1277336563-24988-1-git-send-email-khilman@deeprootsystems.com> <1277336563-24988-5-git-send-email-khilman@deeprootsystems.com> <5A47E75E594F054BAF48C5E4FC4B92AB032366AD26@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:48839 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752666Ab0FXATL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Jun 2010 20:19:11 -0400
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB032366AD26@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>, Sergei Shtylyov <sshtylyov@mvista.com>

On Thu, 24 Jun 2010, Gadiyar, Anand wrote:

> Kevin Hilman wrote:
> > Sent: Wednesday, June 23, 2010 6:43 PM
> > To: linux-omap@vger.kernel.org
> > Cc: paul@pwsan.com; Cousson, Benoit; Sergei Shtylyov
> > Subject: [PATCH 04/13] OMAP: hwmod: Fix the missing braces
> > 
> > From: Benoit Cousson <b-cousson@ti.com>
> > 
> > As reported by Sergei, a couple of braces were missing after
> > the WARM removal patch.
> 
> s/WARM/WARN?

Thanks, just fixed that in the patch description.


- Paul
