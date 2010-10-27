From: =?UTF-8?Q?Enric_Balletb=C3=B2_i_Serra?= <eballetbo@gmail.com>
Subject: How to add an expansion board on IGEP v2 board.
Date: Wed, 27 Oct 2010 10:32:35 +0200
Message-ID: <AANLkTi=_nQu2YZT0+Nq-vGOfu=YufAGC9k+g6GBzYHZH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:33712 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756Ab0J0Icg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Oct 2010 04:32:36 -0400
Received: by qyk10 with SMTP id 10so491027qyk.19
        for <linux-omap@vger.kernel.org>; Wed, 27 Oct 2010 01:32:35 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello all,

I would ask some technical questions, maybe someone can help me. I
would add support for a new expansion board for IGEP v2 board,

The expansion board comes with a EEPROM, the EEPROM is used to
identify the expansion board, my idea is create a new file for
expansion board ( board-igep0020-expansion.c ) and

* on board-igep0020.c
  - Add extern void __init igep2_expansion_init(void);
  - Call igep2_expansion_init on igep2_init()

* on board-igep0020-expansion.c
  - Create  igep2_expansion_init, inside this funciton
    - Add e2prom device and read board id
    - If board ID exists then init all expansion devices

I'm in the right way ? Comments ?

Thanks in advance,
   Enric
