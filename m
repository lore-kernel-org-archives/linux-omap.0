From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 11/14] OMAP4: PRCM: reorganize existing OMAP4 PRCM header
 files
Date: Tue, 7 Dec 2010 21:43:40 +0100
Message-ID: <4CFE9C7C.6060101@ti.com>
References: <20101207012242.3708.45451.stgit@twilight.localdomain> <20101207012514.3708.87532.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44644 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755054Ab0LGUn4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Dec 2010 15:43:56 -0500
In-Reply-To: <20101207012514.3708.87532.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Nayak, Rajendra" <rnayak@ti.com>

On 12/7/2010 2:25 AM, Paul Walmsley wrote:

[...]

> + *
> + * XXX This file needs to be updated to align on one of "OMAP4", "OMAP44XX",
> + *     or "OMAP4430".

Yep, I was thinking to change that as well. My first thought was OMAP4 
to get a shorter name, but when we will introduce OMAP4440, we might 
have some new entries, that will looks ugly close to OMAP4.
So at the end I will prefer OMAP44XX for the moment and we might renamed 
to OMAP4430 or OMAP4440 for the entries that will diverge.

Do you want to change that for 2.6.38?
It will require some sync with the various users of these defines, but 
that should be doable.

Regards,
Benoit

