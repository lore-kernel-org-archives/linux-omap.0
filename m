From: <Tero.Kristo@nokia.com>
Subject: getnstimeofday() and suspend
Date: Wed, 13 Aug 2008 15:57:21 +0300
Message-ID: <B71CE868F2BC2847B3F23C5A8EE394305AB785@vaebe110.NOE.Nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:62466 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752941AbYHMM56 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Aug 2008 08:57:58 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m7DCvfBk007111
	for <linux-omap@vger.kernel.org>; Wed, 13 Aug 2008 07:57:56 -0500
Content-class: urn:content-classes:message
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

I noticed an interesting feature in the getnstimeofday() function when
used with suspend. System clock is effectively reset to the value it was
just before suspend. You can see this behavior e.g. with this command
line:

	date && echo mem > /sys/power/state && date

With approx. 2 minutes in suspend state the output for me was this:

/ # date && echo mem > sys/power/state && date
Thu Jan  1 00:13:40 UTC 1970PM: Syncing filesystems ...
done.
Freezing user space processes ... (elapsed 0.00 seconds) done.
Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
Suspending console(s)
Successfully put all powerdomains to target state
Restarting tasks ... done.
Thu Jan  1 00:13:42 UTC 1970

I.e., the calendar clock was only advanced 2 seconds. The time you spend
in suspend does not matter, the end result is the same, it will reset
the time to the value it was before suspend.

Is this behavior intended?

-Tero
