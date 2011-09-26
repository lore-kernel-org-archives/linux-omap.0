From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 07/11] OMAP2+: board-generic: Add DT support to generic
 board
Date: Mon, 26 Sep 2011 14:35:06 +0200
Message-ID: <4E80717A.3040502@ti.com>
References: <1316809399-19579-1-git-send-email-b-cousson@ti.com> <1316809399-19579-8-git-send-email-b-cousson@ti.com> <20110923230845.GD6324@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54219 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752571Ab1IZMfV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 26 Sep 2011 08:35:21 -0400
In-Reply-To: <20110923230845.GD6324@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "paul@pwsan.com" <paul@pwsan.com>, "Hilman, Kevin" <khilman@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>

On 9/24/2011 1:08 AM, Tony Lindgren wrote:
> * Benoit Cousson<b-cousson@ti.com>  [110923 12:50]:
>> Re-cycle the original board-generic file to support Device Tree
>> for every OMAP2+ variants.
>> Note: Since it is a completely new content in the existing file
>> I removed the original copyright.
>
> I'd suggest just keeping it, maybe just update the comments
> accordingly?

Do you mean keeping it and adding the comment? Or removing it and adding 
the comment?

> That's because Copyrights in general just don't "disappear".

OK, maybe, but I thought it is weird to keep an old copyright just 
because we re-use an already existing file since the content is different.

> And the meaning of the board-generic is still the same as originally,
> that is do the booting based on board-specific data passed from
> the bootloader like the comments say:
>
>> - * Code for generic OMAP2 board. Should work on many OMAP2 systems where
>> - * the bootloader passes the board-specific data to the kernel.
>> - * Do not put any board specific code to this file; create a new machine
>> - * type if you need custom low-level initializations.
>> + * Support for generic OMAP2+ device tree boards.

Regards,
Benoit

