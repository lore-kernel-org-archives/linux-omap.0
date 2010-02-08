From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH V4] OMAP3: hwmod: support to specify the offset position
 of various SYSCONFIG register bits.
Date: Mon, 8 Feb 2010 12:49:14 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1002081247570.22923@utopia.booyaka.com>
References: <1265644990-14589-1-git-send-email-thara@ti.com> <alpine.DEB.2.00.1002081232390.22923@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:44986 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753593Ab0BHTtP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Feb 2010 14:49:15 -0500
In-Reply-To: <alpine.DEB.2.00.1002081232390.22923@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>


Also, the:

#include <linux/list.h>

has been moved from omap_hwmod_common_data.c to plat/omap_hwmod.h.  This 
is because omap_hwmod_common_data.c does not need this header file at all, 
but plat/omap_hwmod.h does.


- Paul
