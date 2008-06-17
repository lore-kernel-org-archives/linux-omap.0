From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: [PATCH 0/8] 34XX: PM: Workarounds to get omap3 to retention 2nd.
Date: Tue, 17 Jun 2008 10:28:35 +0300
Message-ID: <87iqw85xlo.fsf@trdhcp146196.ntc.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:31623 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753386AbYFQH3G convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Jun 2008 03:29:06 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: ext Tony Lindgren <tony@atomide.com>, ext Paul Walmsley <paul@pwsan.com>

This patch set contains all workarounds that are needed to get omap3
to retention. Also patch from Tero Kristo to get PM to work if using
serial console is included in this set. Basically all patches in this
set should be reverted one by one as correct fixes are implemented and
applied.

This patch set superseeds earlier version sent 2008-06-09 9:32:40.

--=20
Jouni H=C3=B6gander

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
