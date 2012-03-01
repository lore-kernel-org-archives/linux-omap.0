From: CF Adad <cfadad@rocketmail.com>
Subject: Re: Question: Custom DAI driver for AM35xx using McBSP
Date: Thu, 1 Mar 2012 09:13:08 -0800 (PST)
Message-ID: <1330621988.48456.YahooMailNeo@web125202.mail.ne1.yahoo.com>
References: <1330488712.31452.YahooMailNeo@web125205.mail.ne1.yahoo.com> <1330536469.53752.YahooMailNeo@web125203.mail.ne1.yahoo.com>
Reply-To: CF Adad <cfadad@rocketmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nm20-vm3.bullet.mail.ne1.yahoo.com ([98.138.91.150]:41399 "HELO
	nm20-vm3.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1757211Ab2CARNJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 1 Mar 2012 12:13:09 -0500
In-Reply-To: <1330536469.53752.YahooMailNeo@web125203.mail.ne1.yahoo.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



We have resolved our issue with the help of PaulM at TI.=A0 The driver =
does work, the trouble was with the way the data was being masked in th=
e buffer.=A0 We posted a detailed explanation on the E2E forum (link ab=
ove) that you may review if interested.=A0 Thanks.

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
