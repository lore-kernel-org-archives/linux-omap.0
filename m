From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH] Added support for OMAP35x processor series
Date: Tue, 5 Aug 2008 15:35:35 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593013C9AECC6@dbde02.ent.ti.com>
References: <premi@ti.com> <1217591379-1515-1-git-send-email-premi@ti.com>
	 <20080805092523.GK7193@atomide.com>
	 <B85A65D85D7EB246BE421B3FB0FBB593013C9AEC8E@dbde02.ent.ti.com>
 <1217929845.16579.164.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from soda.ext.ti.com ([198.47.26.145]:41732 "EHLO soda.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755042AbYHEKMe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Aug 2008 06:12:34 -0400
In-Reply-To: <1217929845.16579.164.camel@localhost>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "igor.stoppa@nokia.com" <igor.stoppa@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> Why can't the detection happen at runtime?
No mechanism as of now.

~sanjeev

-----Original Message-----
From: Igor Stoppa [mailto:igor.stoppa@nokia.com]
Sent: Tuesday, August 05, 2008 3:21 PM
To: Premi, Sanjeev
Cc: Tony Lindgren; linux-omap@vger.kernel.org
Subject: RE: [PATCH] Added support for OMAP35x processor series

On Tue, 2008-08-05 at 15:09 +0530, ext Premi, Sanjeev wrote:
> This patch is needed to ensure that we can make decisions based on the processor capabilities.
> E.g. OMAP3503 does not contain a DSP. We shouldn't be trying to
> disable/ manage the clocks for DSP on this processor. Same for SGX.

Why can't the detection happen at runtime?

> Enabling NEON is support iby default is just based on the number of
> requests I have been getting from various users.

Huh?

[sp] Linux releases on OMAP35x based on 2.6.22 are available for download since MAR '08.

--

Cheers, Igor

---

Igor Stoppa
Maemo Software - Nokia Devices R&D - Helsinki
