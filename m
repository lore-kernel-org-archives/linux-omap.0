From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: RE: [PATCH v4 1/2] OMAP: DSS2: Introduce dss_features files
Date: Thu, 07 Oct 2010 10:42:11 +0300
Message-ID: <1286437331.28499.1020.camel@tubuntu.research.nokia.com>
References: <1284559794-4771-1-git-send-email-archit@ti.com>
	 <1284559794-4771-2-git-send-email-archit@ti.com>
	 <1286435365.28499.1012.camel@tubuntu.research.nokia.com>
	 <FCCFB4CDC6E5564B9182F639FC356087034B94ADFB@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mgw-sa02.ext.nokia.com ([147.243.1.48]:38261 "EHLO
	mgw-sa02.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751173Ab0JGHmR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Oct 2010 03:42:17 -0400
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC356087034B94ADFB@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Taneja, Archit" <archit@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, 2010-10-07 at 09:37 +0200, ext Taneja, Archit wrote:
> Hi,

> > I only now noticed that you had changed the feature list to a bit array.
> > It was an array of ints previously. Are you sure 32 features is enough?
> > It sounds a bit small to me.
> > 
> >  Tomi
> 
> I was reworking our omap4 tree with the dss_features patch and was able to reach to 11
> features. 32 may be probably enough till omap4, but yeah you are right, we will cross
> 32 at some point in time. I didn't like the array way before, any idea how we can extend
> the bit array method for more than 32 features?

Do you mean 32 will probably be enough for omap2,3 and 4? If so, I think
we can go forward with this. It is a dss_features.c internal detail, and
can be changed easily in the future to accomodate more features.

 Tomi


