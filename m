From: Ganeshan N <nganeshan1@yahoo.com>
Subject: OMAP3: Low DDR Memory bandwidth
Date: Wed, 4 Feb 2009 04:47:41 -0800 (PST)
Message-ID: <703092.95158.qm@web112223.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from n60.bullet.mail.sp1.yahoo.com ([98.136.44.40]:44214 "HELO
	n60.bullet.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751562AbZBDMrn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 4 Feb 2009 07:47:43 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi All,
I am using OMAP3EVM and measuring DDR memory bandwidth. Used "lmbench" =
to measure the bandwidth.=A0 I am getting low bandwidth around 460 MB/S=
 in TI kernel 2.6.22 and getting bandwidth around 800 MB/S in git kerne=
l 2.6.28-rc8.

In kernel 2.6.22, there are two SDRC registers (SDRC_DLLA_CTRL and SDRC=
_POWER_REG), which are getting modified. I have updated code such that =
SDRC values for both the=A0 the kernel 2.6.22 and 2.6.28 are same. Afte=
r this updation there is no improvement in the bandwidth.=A0 The SDRC i=
s running at 166MHz.=A0 I am using same x-loader and u-boot for both th=
e kernel (2.6.22 and 2.6.28).

Can you please suggest some pointers/methods, to increase the=A0DDR mem=
roy bandwidth in 2.6.22=A0TI kernel.

Thanks in advance.

With Regards
Ganeshan



     =20

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
