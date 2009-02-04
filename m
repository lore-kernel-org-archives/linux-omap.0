From: Ganeshan N <nganeshan1@yahoo.com>
Subject: OMAP3 EHCI USB HS mode performance issue
Date: Tue, 3 Feb 2009 20:20:30 -0800 (PST)
Message-ID: <701709.89130.qm@web112201.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from n68.bullet.mail.sp1.yahoo.com ([98.136.44.44]:23941 "HELO
	n68.bullet.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751358AbZBDEVo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 3 Feb 2009 23:21:44 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi All,
=A0
I am using OMAP3 based board,=A0 running git based kernel 2..6.28, and=A0=
enabled "EHCI HCD (USB 2.0) support",=A0PHY mode.
=A0
EHCI HS performance is measured using Catalyst, USB analyzer.=A0=A0 I s=
upposed to get 480 Mbits/s(theoritically), but getting around 80 Mbits/=
s for write and around 128 Mbits/s for read.=A0 Please suggest me some =
method/option to increase HS USB EHCI performance.
=A0
Thanks in advance=20
Regards
Ganeshan


     =20

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
