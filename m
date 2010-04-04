From: Tar Gz <bsdraisefromhell@gmail.com>
Subject: [ASK] OMAP 3430 LDP Trouble
Date: Sun, 4 Apr 2010 12:43:00 +0700
Message-ID: <w2yd9ca78711004032243y332ad5la6152f9b5def34b9@mail.gmail.com>
References: <h2vd9ca78711004031033ved1c64az135e06fc43ca72de@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:49812 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750988Ab0DDFnD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 4 Apr 2010 01:43:03 -0400
Received: by vws13 with SMTP id 13so1003769vws.19
        for <linux-omap@vger.kernel.org>; Sat, 03 Apr 2010 22:43:00 -0700 (PDT)
In-Reply-To: <h2vd9ca78711004031033ved1c64az135e06fc43ca72de@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

Hi all,
i'm sorry if my english too bad

I try to porting linux to omap 3430 LDP..but my board have trouble
after i running this command:

nand ecc sw
nand unlock 80000 80000
nand erase 80000 80000

nand ecc hw
nand unlock 0 80000
nand erase 0 80000

and if i try to turn on my board, BT led [blue led] always on and my
minicom can't show anything...and i forget to setting the enviroment
variable mmcinit..

my question is, how to make my board can run normally like before?

best regards,
Aldyth M
