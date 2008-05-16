From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: [PATCH 0/9] 34XX: PM: Support for retention on suspend and idle
Date: Fri, 16 May 2008 13:53:29 +0300
Message-ID: <878wyav7ti.fsf@trdhcp146196.ntc.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:45559 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752399AbYEPKyJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 May 2008 06:54:09 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, tony@atomide.com

This patch set adds suspend and pm idle support for omap3. There are
still lots of missing stuff so omap doesn't enter full retention
without workaround patches. Workaround patches are sent in separate
set.

You can try these by applying this set and workaround set. Then boot
the device and do "echo mem > /sys/power/state". Dynamic retention can
be tried by "echo 1 > /sys/power/sleep_while_idle". There is one
pending patch by Felipe Balbi (ARCH: OMAP: MUSB: Do not block sleep)
addition to this and workaround set which is needed dynamic idle to
work. Enabling dynamic idle has nasty side effect that serial console
stops to work. This happens only if you enable it by "echo 1 >
/sys/power/sleep_while_idle"

I have tested these patches on TI 3430 SDP ES2.0 board.
--=20
Jouni H=C3=B6gander

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
