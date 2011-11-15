From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv3 10/11] omap3+: use lp params for calculating clock
 setup times
Date: Tue, 15 Nov 2011 19:22:22 +0200
Message-ID: <1321377742.2854.8.camel@sokoban>
References: <1317835031-8201-1-git-send-email-t-kristo@ti.com>
	 <1317835031-8201-11-git-send-email-t-kristo@ti.com> <87lirv600c.fsf@ti.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59865 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756836Ab1KORW0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Nov 2011 12:22:26 -0500
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id pAFHMP5t004886
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 15 Nov 2011 11:22:25 -0600
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep34.itg.ti.com (8.13.7/8.13.8) with ESMTP id pAFHMPVs016066
	for <linux-omap@vger.kernel.org>; Tue, 15 Nov 2011 11:22:25 -0600 (CST)
Received: from DLEE74.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id pAFHMPYt027641
	for <linux-omap@vger.kernel.org>; Tue, 15 Nov 2011 11:22:25 -0600 (CST)
In-Reply-To: <87lirv600c.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org

Hi Kevin,

Thanks for the comments and sorry for a bit late reply. I was busy with
other stuff but can work on this again.

Anyway, all your comments to all of the patches make sense, and I will
apply the changes to the next version of the set, also merging some of
the patches back together again. One question though, do you want to
have the auto_ret / auto_off support along with these changes? Some of
the code in this set is only used when the auto_ret / auto_off is in,
and it also makes it a bit more easier to test the resulting stuff.

-Tero



