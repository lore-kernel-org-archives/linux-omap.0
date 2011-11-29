From: kanagesh radhakrishnan <rkanagesh@gmail.com>
Subject: High Speed devices on OTG port in Host mode with OMAP4460 ES 1.0
Date: Tue, 29 Nov 2011 17:11:52 +0530
Message-ID: <CADgYr3Ah-mceFxS7Gqfw=ENCGQAHeMxbqydANTk4qL+ya7i3mA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:48342 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751411Ab1K2Llx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Nov 2011 06:41:53 -0500
Received: by ywa9 with SMTP id 9so3979288ywa.19
        for <linux-omap@vger.kernel.org>; Tue, 29 Nov 2011 03:41:52 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello All,

I am working with a custom hardware platform based on OMAP4460
(ES1.0).=A0 The Linux kernel that I have used with the platform is
L27.G.3 release from git.omapzoom.org

Hardware Setup:

* The OTG port of the OMAP4460 is interfaced to a High Speed USB Hub.
* It is also interfaced to a Mini-AB connector (with a mux in hardware
that enables selection between the two).
* The objective is to use the OTG port of the OMAP4460 in Host mode
and get the High speed hub working.

Issue:

* I am unable to get the High Speed USB Hub to detect and work with
the OTG Port in Host mode.
* This is also the case when I connect an external, Self powered High
Speed USB hub using the Mini-AB connector.

Tests Run:

When I connect an external Self powered Full Speed Hub to the OTG port
(through the Mini-AB connector) the OMAP4460 is able to detect the hub
and enumerate it.=A0 On connecting USB flash drives to the USB Hub,
Linux detects insertion, enumerates the USB flash drives and mounts
them.

I have also connected the external, Self powered High Speed hub to the
OTG port of the OMAP4430 Pandaboard, with the OTG port configured in
Host mode.=A0 This works fine, OMAP4430 detects, enumerates and mounts
the USB Flash drives connected to the High speed Hub.=A0 The kernel use=
d
on the OMAP4430 Pandaboard is the same (L27.G.3 from git.omapzoom.org)

Has the OTG port on the OMAP4460 been tested in host mode with a High
Speed device?
How do I force the OTG port when configured in host mode to work in
=46ull speed mode?

Thank you for your time.

Warm regards,
Kanagesh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
