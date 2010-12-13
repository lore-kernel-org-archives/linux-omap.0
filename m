From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH/RFC 2/2] OMAP: PM: implement context loss count APIs
Date: Mon, 13 Dec 2010 12:39:27 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1012131224330.15971@utopia.booyaka.com>
References: <1291939712-25487-1-git-send-email-khilman@deeprootsystems.com> <1291939712-25487-2-git-send-email-khilman@deeprootsystems.com> <44f6fc2f0c975af7273975385567acd2@mail.gmail.com> <alpine.DEB.2.00.1012130331570.15971@utopia.booyaka.com>
 <940a49d978e2d610b2349f42d56614cc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:56973 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754207Ab0LMTj2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Dec 2010 14:39:28 -0500
In-Reply-To: <940a49d978e2d610b2349f42d56614cc@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath Sripathy <vishwanath.bs@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org

Vishwa

On Mon, 13 Dec 2010, Vishwanath Sripathy wrote:

> I have no issues with the implementation and I agree. All I am saying is 
> that why can't this implementation be added in omap-pm.c and compile 
> this file instead of omap-pm-noop.c

1. because omap-pm-noop.c needs to not actively break anything when it is 
   used, and this function, unlike most of the other functions in 
   omap-pm-noop.c, has no valid 'no-op' failure mode; and

2. because no one has yet posted a complete, clean, working, 
   SRF-free OMAP PM layer to the lists.  It was the hope several years ago
   when this interface was created that someone else would be capable of 
   doing this.

> when OMAP_PM is enabled.

What is this OMAP_PM that you are referring to?

> I believe this function is useful when off mode is enabled which means 
> OMAP_PM is enabled.

Huh?  Mainline Linux on OMAP can enter off-mode with omap2plus_defconfig 
right now via a runtime debugfs setting.  There is no KConfig setting to 
enable.


- Paul
