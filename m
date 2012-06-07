From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: Please help! AM35xx mm/slab.c BUG
Date: Thu, 7 Jun 2012 09:32:08 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E995E3B@DBDE01.ent.ti.com>
References: <1338878255.13133.YahooMailNeo@web125205.mail.ne1.yahoo.com>
 <20120605070853.GE12766@atomide.com>
 <1338913755.88514.YahooMailNeo@web125201.mail.ne1.yahoo.com>
 <1338963298.87083.YahooMailNeo@web125204.mail.ne1.yahoo.com>
 <CAMQu2gw2bGNwot_xVPdAsYjZChzzNib2USg8Ci+W5aLbenPnqA@mail.gmail.com>
 <20120606071024.GP12766@atomide.com>
 <1338969083.99043.YahooMailNeo@web125201.mail.ne1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43911 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755120Ab2FGJcS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jun 2012 05:32:18 -0400
In-Reply-To: <1338969083.99043.YahooMailNeo@web125201.mail.ne1.yahoo.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: CF Adad <cfadad@rocketmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

Hi "",

On Wed, Jun 06, 2012 at 13:21:23, CF Adad wrote:

> Thanks again.=A0 I'm really starting to think the GPMC almost has to =
be contributing.

Does adding cycle2cycle delay / bus turnaround prevent the issue ?,

SMSC datasheet mentions about special restrictions on back to back read
and write-read, reading BYTE_TEST should take care of it, not sure whet=
her
driver takes care of all scenarios as per datasheet.

Perhaps cycle2cycledelay would help us achieve it if driver doesn't
take care of it.

Regards
Afzal
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
