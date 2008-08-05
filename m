From: Igor Stoppa <igor.stoppa@nokia.com>
Subject: RE: [PATCH] Added support for OMAP35x processor series
Date: Tue, 05 Aug 2008 12:50:45 +0300
Message-ID: <1217929845.16579.164.camel@localhost>
References: <premi@ti.com> <1217591379-1515-1-git-send-email-premi@ti.com>
	 <20080805092523.GK7193@atomide.com>
	 <B85A65D85D7EB246BE421B3FB0FBB593013C9AEC8E@dbde02.ent.ti.com>
Reply-To: igor.stoppa@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:24370 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760415AbYHEJ6G (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Aug 2008 05:58:06 -0400
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593013C9AEC8E@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Premi, Sanjeev" <premi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, 2008-08-05 at 15:09 +0530, ext Premi, Sanjeev wrote:
> This patch is needed to ensure that we can make decisions based on the processor capabilities.
> E.g. OMAP3503 does not contain a DSP. We shouldn't be trying to disable/ manage the clocks for
> DSP on this processor. Same for SGX.

Why can't the detection happen at runtime?

> Enabling NEON is support iby default is just based on the number of requests I have been getting
> from various users.

Huh?


-- 

Cheers, Igor

---

Igor Stoppa
Maemo Software - Nokia Devices R&D - Helsinki
