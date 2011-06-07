From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 19/27] OMAP: DSS2: Use PM runtime & HWMOD support
Date: Tue, 07 Jun 2011 09:47:45 +0300
Message-ID: <1307429265.1858.6.camel@deskari>
References: <1307095237-14805-1-git-send-email-tomi.valkeinen@ti.com>
	 <1307095237-14805-20-git-send-email-tomi.valkeinen@ti.com>
	 <871uzahnib.fsf@ti.com> <1307122985.2016.72.camel@deskari>
	 <87hb86a5mm.fsf@ti.com> <1307174504.1777.24.camel@lappyti>
	 <4DECCE90.6070201@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:46648 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751160Ab1FGGrx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Jun 2011 02:47:53 -0400
In-Reply-To: <4DECCE90.6070201@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>

On Mon, 2011-06-06 at 14:56 +0200, Cousson, Benoit wrote:

> That terminology in the PRCM just means that an opt clock will not be 
> handled automatically by the PRCM and will require SW control.
> This is not the case for mandatory clock. Upon module enable the PRCM 
> will ensure that all mandatory clocks (functional and interface) are 
> enabled automagically. If the clock is marked as optional it means that 
> the SW will have to enable it explicitly before enabling the module.

Is that correct? This would mean that whenever a hwmod has opt clock, it
needs to implement similar hack functions that are present in this
patch, to be able to enable the opt clock before enabling the hwmod, and
to disable the opt clock after disabling the hwmod.

I'd rather hope the optional clock could be enabled whenever the driver
needs it, between enabling and disabling the hwmod.

If it's required that the opt clocks are enabled before enabling the
hwmod, what is the point of having them as optional and driver
controlled? The hwmod fmwk could as well handle the opt clocks in that
case.

 Tomi


