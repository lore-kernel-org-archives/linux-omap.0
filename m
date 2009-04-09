From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: 2.6.29 and SDP3430
Date: Thu, 9 Apr 2009 08:00:02 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE8967162037BCF18A5@dlee02.ent.ti.com>
References: <782515bb0904082345j2a44da65s909a6834bab07330@mail.gmail.com>
 <20090409100343.71d34c16.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36181 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934103AbZDINAO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Apr 2009 09:00:14 -0400
In-Reply-To: <20090409100343.71d34c16.jarkko.nikula@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>, ext Nishanth Menon <menon.nishanth@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>


> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Jarkko Nikula
> Sent: Thursday, April 09, 2009 2:04 AM

> > just messing around with tony's master branch on SDP3430, just did a
> > defconfig and a build with  2007q3-51 codesourcery compiler, I see it
> > hang around:
> >
> Kernels built with this compiler stuck into delay loop calibration.
> No idea why, but 2008q3-66 was working for me.

I wonder if the timer stopped ticking.  If you connect with emulator take a look at GPT1 registers and see if time base is moving.

Another quick test is to shut off tickles, nohz=off.

Calibration code is just is spinning and counting interrupts.

Regards,
Richard W.
