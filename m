From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: VDD2 OPP and DSS
Date: Wed, 2 Mar 2011 09:18:20 +0200
Message-ID: <20110302091820.0ffd5c5e.jhnikula@gmail.com>
References: <1299048012.2226.10.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:59653 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750918Ab1CBHRB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Mar 2011 02:17:01 -0500
Received: by eyx24 with SMTP id 24so1954444eyx.19
        for <linux-omap@vger.kernel.org>; Tue, 01 Mar 2011 23:17:00 -0800 (PST)
In-Reply-To: <1299048012.2226.10.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Tero Kristo <tero.kristo@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Vishwanath BS <vishwanath.bs@ti.com>

On Wed, 2 Mar 2011 08:40:12 +0200
Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:

> Hi Paul and Tero,
> 
> Some months ago there were discussions in Nokia about the problem with
> VDD2 OPP and DSS fck. The problem was (if I recall right) that the
> lowest VDD2 OPP cannot be used if DSS fck is over some certain limit (it
> was around 100MHz). If I understood correctly, this was also discussed
> with Paul.
> 
> Do you remember this (and did I remember it right =)? What is the status
> of this?
> 
At least lower OPP breaks DSS on N900 and Beagle if display is on while
entering into lower OPP.

This made me thinking that should initial round of
"[PATCH 10/13] OMAP3: Add voltage dependency table for VDD1."
use only OMAP3430_VDD_CORE_OPP3_UV for core voltage until there's some
dynamic/DSS voltage domain support in DSS?

http://marc.info/?l=linux-omap&m=129889365901937&w=2

That way, I believe, the DVFS has shorter path to mainline and makes
easier to add driver specific support & hooks. DVFS is not only power
savings but users are interesting about additional performance too.

https://bugs.meego.com/show_bug.cgi?id=13833

-- 
Jarkko
