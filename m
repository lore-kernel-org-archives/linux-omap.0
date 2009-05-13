From: "Hunter, Jon" <jon-hunter@ti.com>
Subject: RE: ARM: CONFIG_FRAME_POINTER
Date: Wed, 13 May 2009 10:48:09 -0500
Message-ID: <7B4574D56E4ADF438756313E9A172A87396A1E18@dlee01.ent.ti.com>
References: <7B4574D56E4ADF438756313E9A172A87396257F0@dlee01.ent.ti.com>
 <87zldhaoco.fsf@deeprootsystems.com>
 <13B9B4C6EF24D648824FF11BE8967162038BD5DEE0@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42388 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754587AbZEMPsP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 May 2009 11:48:15 -0400
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162038BD5DEE0@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Richard,

> If you follow the link and look at attached png you clearly see compiler
> issue.  I also provided a hack which allowed it to work.  Probably FRAME
> pointer changes code generation to get rid of issue.

Right, with CONFIG_FRAME_POINTER defined the following compiler flags are defined in the top-level Makefile. 

ifdef CONFIG_FRAME_POINTER
KBUILD_CFLAGS   += -fno-omit-frame-pointer -fno-optimize-sibling-calls
else
KBUILD_CFLAGS   += -fomit-frame-pointer
Endif

I believe that this was the difference. 

Cheers
Jon
