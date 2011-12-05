From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH] mdt nand: omap2+ use platform options
Date: Mon, 5 Dec 2011 12:32:05 +0200
Message-ID: <CANOLnON=OCtOGr52ZpQKM=z-Ot3zAXeZ-M9eauxaoBkm=PFBLQ@mail.gmail.com>
References: <CAN8TOE9=ux=suwcQMwJY1XUhp_mnD_DL613ffF1-HTL1OVB2PQ@mail.gmail.com>
	<1322557213-23565-1-git-send-email-j.weitzel@phytec.de>
	<1322728943.2332.13.camel@koala>
	<CANOLnOOE3a0BP0TcLnRAmq5YAiHLZTpkbriDh9WtkkBT7TotFA@mail.gmail.com>
	<1323072677.12068.5.camel@lws-weitzel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:34350 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755553Ab1LEKcH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Dec 2011 05:32:07 -0500
Received: by eeaq14 with SMTP id q14so1742192eea.19
        for <linux-omap@vger.kernel.org>; Mon, 05 Dec 2011 02:32:06 -0800 (PST)
In-Reply-To: <1323072677.12068.5.camel@lws-weitzel>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: J.Weitzel@phytec.de
Cc: dedekind1@gmail.com, linux-mtd@lists.infradead.org, dedekind@infradead.org, tglx@linutronix.de, computersforpeace@gmail.com, linux-omap@vger.kernel.org

On Mon, Dec 5, 2011 at 10:11 AM, Jan Weitzel <J.Weitzel@phytec.de> wrot=
e:
> Sorry, I wasn't carefully enough. I missed 7a559c78 where you removed
> options from struct omap_nand_platform_data. Did you think getting we
> should reintroduce it? I am looking for a good way to get
> NAND_NO_SUBPAGE_WRITE from boardfile to driver.

You could just rename .devsize to .options and use that I guess.


--=20
Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
