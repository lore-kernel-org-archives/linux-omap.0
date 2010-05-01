From: "Chen, Ming" <ming.chen@authentec.com>
Subject: Cannot wakeup the SDP2430 sometimes, related to console input.
Date: Sat, 1 May 2010 00:01:24 -0400
Message-ID: <5ACCFDF5BCF2C34DB62D54EFA1FDF70007657A89@corp-mail01.auth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.authentec.com ([205.149.130.20]:44808 "EHLO
	smtp.authentec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709Ab0EAEAb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 1 May 2010 00:00:31 -0400
Received: from smtp1.authentec.com (localhost [127.0.0.1])
	by smtp.authentec.com (Spam & Virus Firewall) with ESMTP id 8485A156238
	for <linux-omap@vger.kernel.org>; Sat,  1 May 2010 00:00:30 -0400 (EDT)
Received: from smtp1.authentec.com (corp-mail01.auth.org [10.40.40.96]) by smtp.authentec.com with ESMTP id nI3W5GSXLpiThdeB for <linux-omap@vger.kernel.org>; Sat, 01 May 2010 00:00:30 -0400 (EDT)
Content-class: urn:content-classes:message
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi All,

Recently I was working on the power management code of=A0the Linux=A0(a=
nd Android).=A0My hardware platform is a TI SDP2430 board.=A0I found th=
e board cannot=A0wakeup from suspend state (through=A0a key press) some=
times. The issue was found on Android (which I ported to the board) fir=
st. Then I reproduced it on Linux. The steps are as follows:

1: boot up the omap linux kernel.
2: # echo mem > /sys/power/state
=A0PM: Syncing filesystems ... done.
=A0Freezing user space processes ... (elapsed 0.00 seconds) done.
=A0Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
=A0Suspending console(s) (use no_console_suspend to debug)
3: press a key on the twl4030 keypad, the system can wake up normally.
4: wait a few seconds, the system goes into suspend automatically.
5: press a key, the system wakes up again.
6: # ajdklfjalfjdklajfdklalghkaljhglkajklajlkjalghlkgahkajhgdkjahgkahgk=
jPM: Syncing filesystems ... done.
=A0Freezing user space processes ... (elapsed 0.00 seconds) done.
=A0Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
=A0Suspending console(s) (use no_console_suspend to debug)
7: press a key, the system never wakes up.
=A0
Is that=A0the console inputs in step 6 make the system crash?=20
The kernel version is 2.6.29 with=A0OMAP and Android patches. The conso=
le is configured to 8250_SERIAL.

I know there is a pm branch of the linux omap kernel. Should I try it f=
or this issue?

Thanks in advance for any helps.

Best regards,
Ming

NOTE: The information in this message is intended for the personal and =
confidential use of the designated recipient(s) named above. To the ext=
ent the recipient(s) is/are bound by a non-disclosure agreement, or oth=
er agreement that contains an obligation of confidentiality, with Authe=
nTec, then this message and/or any attachments shall be considered conf=
idential information and subject to the confidentiality terms of that a=
greement.  If the reader of this message is not the intended recipient =
named above, you are notified that you have received this document in e=
rror, and any review, dissemination, distribution or copying of this me=
ssage is strictly prohibited. If you have received this document in err=
or, please delete the original message and notify the sender immediatel=
y.=0D
=0D
Thank You!=0D
=0D
AuthenTec, Inc.  http://www.authentec.com=0D

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
