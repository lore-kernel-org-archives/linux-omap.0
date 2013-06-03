From: Paul Walmsley <paul@pwsan.com>
Subject: Re: Strange OMAP3 LCD display regression - bisected.
Date: Mon, 3 Jun 2013 07:40:51 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1306030739370.4781@utopia.booyaka.com>
References: <20130602165019.655da2eb@notabene.brown>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:36742 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751312Ab3FCHkw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Jun 2013 03:40:52 -0400
In-Reply-To: <20130602165019.655da2eb@notabene.brown>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Rajendra Nayak <rnayak@ti.com>, Mike Turquette <mturquette@ti.com>

Hi Neil,

On Sun, 2 Jun 2013, NeilBrown wrote:

>  Any help anyone could provide here would be greatly appreciated.  I'm happy
>  to run any test patches you would like to suggest.

Just for kicks, you might consider this patch:

http://marc.info/?l=linux-arm-kernel&m=136990713027683&w=2


- Paul
