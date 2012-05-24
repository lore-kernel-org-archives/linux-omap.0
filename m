From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: usage of sparse or other trick for improved type safety
Date: Thu, 24 May 2012 18:12:34 +0000
Message-ID: <EF62F09C0797D947AD4180A1043C0DF73C423E7B@DLEE10.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48867 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752613Ab2EXSMi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 May 2012 14:12:38 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "tony@atomide.com" <tony@atomide.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, "Menon, Nishanth" <nm@ti.com>, "jean.pihet@newoldbits.com" <jean.pihet@newoldbits.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Pasam, Vijay" <vpasam@ti.com>

Hi Tony,

I am hoping to solicit an opinion from you for OMAP frameworks in general.

In some recent review there was some debate about how it was good practice to form parameters in a way which didn't get misused. Nishanth was having some experience where end users doing custom ports made some hard to find mistakes.

I was wondering if it is useful to create a standard or it's a waste of time.  The knee-jerk reaction to comment is to consider annotations for driver users of api's, then inside the framework trust internals to do the right thing.  Complexity divide between a driver and some frameworks might be similar to user-vs-kernel.

I think example in this case was IVA and other external subsystems commonly got away using stale definitions when managing their own power domains.  Example seemed a little pedantic but it is true that this has broken several times through migrations. At customer fan out it causes a lot of effort which could have been avoided.

Just last week someone was trying to caste away an iomem annotation from external driver based on warning. For me warning was a good thing and forced discussion.

I do recall you pushing what ARM and Linux tress did in this area back into OMAP years back.  Question is if it's worth internalizing more for our ever growing frameworks.

Thanks,
Richard W.

