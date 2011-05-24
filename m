From: Ashok Babu <ashok3d@gmail.com>
Subject: Fwd: Self modifying code in ARM 11 architectures
Date: Tue, 24 May 2011 15:48:35 +0530
Message-ID: <BANLkTimyju7eEgtCpb_U6s8LNHk-_FGK4Q@mail.gmail.com>
References: <BANLkTi=mVsYiubqtJO2BmWvExMvUFRg6dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:46087 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754818Ab1EXKSg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 May 2011 06:18:36 -0400
In-Reply-To: <BANLkTi=mVsYiubqtJO2BmWvExMvUFRg6dg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm@vger.kernel.org

Hi All,

I am no success in booting up the ARM1176 processor with the
linux-2.6.32 kernel.
While googling about the ARM=A0Harvard=A0architecture, I came to know t=
hat
we have to flush/invalidate the D-Cache and I-Cache
when using the self modifying codes.

So here my questions/doubts :
1) Is'nt it the kernel itself is self modifying code with lots of
function pointers ?
=A0 =A0 If yes, how is synchronization b/w d-cache and i-cache handled =
in
the kernel ?
2) Can this be the reason for the kernel not booting for me ?
=A0 =A0 Because If i disable the I-Cache in the config, then the kernel
boots up without any issues.
Any pointers on this will be of great help.

Thanks & Best Regards
Ashok
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
