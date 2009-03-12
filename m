From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: ioremap bug? (was RE: DSPBRIDGE: segmentation fault after
 reloading dspbridge several times due to a memory leak.)
Date: Thu, 12 Mar 2009 14:32:53 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE8967162037B7D2E7E@dlee02.ent.ti.com>
References: <496565EC904933469F292DDA3F1663E60287CA6EC4@dlee06.ent.ti.com>
	<7A436F7769CA33409C6B44B358BFFF0CFF51DF41@dlee02.ent.ti.com>
 <87zlfq6497.fsf@deeprootsystems.com>
 <7A436F7769CA33409C6B44B358BFFF0CFF51E139@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58099 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750945AbZCLTdI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 15:33:08 -0400
In-Reply-To: <7A436F7769CA33409C6B44B358BFFF0CFF51E139@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Guzman Lugo, Fernando" <x0095840@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Lakhani, Amish" <amish@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>, Ameya Palande <ameya.palande@nokia.com>

> Kevin,
> Some more isolation:
> The l-o master branch does not have an issue, only the pm branch seems to have
> the problem - probably some commit(s?) missing in pm branch. Since bridge is
> based off the pm branch, wont make sense to regress on it :(.

This rings a bell from a couple months back.  I've not followed the thread but recall a recent fix to ioremap.

http://www.mail-archive.com/linux-omap@vger.kernel.org/msg08836.html

Regards,
Richard W.
