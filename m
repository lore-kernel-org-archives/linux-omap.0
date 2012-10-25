From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 6/7] watchdog: OMAP: use standard GETBOOTSTATUS interface;
 use platform_data fn ptr
Date: Thu, 25 Oct 2012 21:09:35 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210252109190.4745@utopia.booyaka.com>
References: <20121016012448.21844.92339.stgit@dusk.lan> <20121016013233.21844.1279.stgit@dusk.lan> <50899DB9.8050308@ti.com> <alpine.DEB.2.00.1210252015490.21193@utopia.booyaka.com> <alpine.DEB.2.00.1210252028330.21193@utopia.booyaka.com>
 <20121025205926.GA19439@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:38112 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992597Ab2JYVJf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Oct 2012 17:09:35 -0400
In-Reply-To: <20121025205926.GA19439@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Jon Hunter <jon-hunter@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org

On Thu, 25 Oct 2012, Felipe Balbi wrote:

> should be "exported functions from those drivers directly."

Thanks, will update the patch description.


- Paul
