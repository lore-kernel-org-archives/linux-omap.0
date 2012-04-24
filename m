From: Felix Lin <linxz02@ovi.com>
Subject: OMAPDSS basic concepts
Date: Tue, 24 Apr 2012 09:53:32 -0700 (PDT)
Message-ID: <1335286412.11701.YahooMailNeo@web121401.mail.ne1.yahoo.com>
Reply-To: Felix Lin <linxz02@ovi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nm4-vm4.bullet.mail.ne1.yahoo.com ([98.138.91.164]:39152 "HELO
	nm4-vm4.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755504Ab2DXQ6t convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Apr 2012 12:58:49 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hello All,

I'm pretty new to the OMAP DSS and would like to understand how it work=
s under Linux/Android. I have read the TRM and understood that the DSS =
uses DMA to move pixels from the main memory to several hardware pipeli=
nes, with each burst of a few lines. But I am wondering -=20


1 - when will DSS start to move a new frame from the framebuffer to har=
dware pipelines? Is it triggered by some timer, or by some signals from=
 the LCD panel (e.g., VSYNC)?
2 - is it possible to measure/estimate the time taken in DMAing a frame=
?=A0

I also looked into the kernel doc and source code but found no answer. =
I appreciate any comments or pointers.=20


Thanks a lot!

-Felix

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
