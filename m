From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: omap dss tft display connection
Date: Thu, 24 Feb 2011 12:39:11 +0200
Message-ID: <1298543951.16119.63.camel@deskari>
References: <AANLkTinPiAg8zVkW6Z0UsvDO57UwFSyVEbbjkwj4=EXh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44720 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752629Ab1BXKjP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Feb 2011 05:39:15 -0500
In-Reply-To: <AANLkTinPiAg8zVkW6Z0UsvDO57UwFSyVEbbjkwj4=EXh@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Belisko Marek <marek.belisko@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, 2011-02-24 at 04:05 -0600, Belisko Marek wrote:
> Hello,
> 
> would be possible to configure dss on omap3530 which is connected to
> 18bit TFT display in such way:
>        8           8            8
> | | | | | | | |-| | | | | | | |-| | | | | | | |
>     6         6         6
> | | | | | |-| | | | | |-| | | | | |
> 
> So no standard connection (2 bits in every color are skipped) but it's
> shifted so last 6 bits remain unused.
> When use generic panel it seems I have no red color (just combination
> of blue and green).
> 
> It is anyway possible to drive such a connection? Or HW needs to ne changed?

Can you explain a bit more what you are trying to do? At least I didn't
quite understand =).

Why don't you use the 18bit TFT with 18 datalines?

 Tomi


