From: Kevin Hilman <khilman@ti.com>
Subject: Re: Can i submit B&N Nook Color generic kernel support patches?
Date: Fri, 08 Apr 2011 07:30:23 -0700
Message-ID: <874o683jeo.fsf@ti.com>
References: <BANLkTinCyzCzBUOTOCV5tQoQmxajpAH=MA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:47204 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753031Ab1DHOai (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Apr 2011 10:30:38 -0400
Received: by mail-iy0-f173.google.com with SMTP id 10so4237145iym.32
        for <linux-omap@vger.kernel.org>; Fri, 08 Apr 2011 07:30:27 -0700 (PDT)
In-Reply-To: <BANLkTinCyzCzBUOTOCV5tQoQmxajpAH=MA@mail.gmail.com> (Abimanyu
	Gottumukkala's message of "Fri, 8 Apr 2011 19:17:28 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Abimanyu Gottumukkala <me@abimanyu.in>
Cc: linux-omap@vger.kernel.org

Hello,

Abimanyu Gottumukkala <me@abimanyu.in> writes:

> I am working on porting B&N Nook color source to generic kernel (non
> Android). Can i submit my ported code to omap-linux git?

Absolutely!

Support for new platforms is always welcome.  This platform is based on
the OMAP36xx (3621 I think), so you might look at other 36xx-based
platforms (like Zoom3) as a starting point for your platform support.

It will also be good to be familiar with the differences between a 3621
and a 3630 and use OMAP features so any differences in the parts can be
determined at runtime (see omap_has_* in <plat/cpu.h> for example.)

Thanks,

Kevin
