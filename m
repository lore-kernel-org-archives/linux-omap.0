From: "Andrew Murray" <amurray@mpc-data.co.uk>
Subject: Issue with pm_debug?
Date: Tue, 26 Jan 2010 15:45:13 -0000
Message-ID: <0C997DD87CC88A4F86C897F52650B52B025627F2@MOLSON.mpc-data.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cvs.mpc-ogw.co.uk ([81.2.99.171]:49587 "EHLO
	molson.mpc-data.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754317Ab0AZPpS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Jan 2010 10:45:18 -0500
Content-class: urn:content-classes:message
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,

I've been studying the power management support on the OMAP 35x EVM (Rev
G) and have noticed something which seems inconsistent with the
documentation. 

According to the elinux OMAP Power Management wiki page
(http://elinux.org/OMAP_Power_Management) - setting "sleep_while_idle"
to '1' and setting "enable_off_mode" and "voltage_off_while_idle" to '0'
in the debugfs should result in a kernel which will never hit 'off'
sleep states. 

However in this set up (with both ladder and menu governor) I've found
that in this state the C5 and C6 states are entered (according to
/sys/devices/system/cpu/cpu0/cpuidle/state[5/6]/time). However according
to the sources these states include the off state. 

Also the /debug/pm_debug/time indicates the off state wasn't reached.
Therefore is it just the case that the CPUIdle framework requested C5/6
and the omap driver accepted by actually used another state?

Is this incorrect behaviour? Or is my understanding of power management
implementation incorrect? Any clarifications would be of great value.

I've used the 'pm' branch in the khilman linux-omap-pm repository. (Is
this the most appropriate mailing list?)

Many Thanks,

Andrew Murray

