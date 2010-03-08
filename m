From: Pablo Bitton <pablo.bitton@gmail.com>
Subject: probe of omap2-nand failed with -16
Date: Mon, 8 Mar 2010 22:04:51 +0200
Message-ID: <7448ec711003081204r6d4fd037o7a87a767a71c54d2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f209.google.com ([209.85.218.209]:34393 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755523Ab0CHUEx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Mar 2010 15:04:53 -0500
Received: by bwz1 with SMTP id 1so3189615bwz.21
        for <linux-omap@vger.kernel.org>; Mon, 08 Mar 2010 12:04:51 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

I've started working on beagle board.

Using pre-compiled kernel (angstrom) - i've got nand driver loaded and running.

When I am trying to compile my own kernel from the source, I get error:

>> probe of omap2-nand failed with -16 (EBUSY)

I've selected all configs for Nand...

Am I missing something? Mux configuration? GPIO's?
Anybody has any idea?



thanks,
--
Pablo
