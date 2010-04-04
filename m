From: "Ghorai, Sukumar" <s-ghorai@ti.com>
Subject: RE: [ASK] OMAP 3430 LDP Trouble
Date: Sun, 4 Apr 2010 21:34:25 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B030D3C8B3F@dbde02.ent.ti.com>
References: <h2vd9ca78711004031033ved1c64az135e06fc43ca72de@mail.gmail.com>
 <w2yd9ca78711004032243y332ad5la6152f9b5def34b9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36267 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754730Ab0DDQEc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 4 Apr 2010 12:04:32 -0400
In-Reply-To: <w2yd9ca78711004032243y332ad5la6152f9b5def34b9@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tar Gz <bsdraisefromhell@gmail.com>, linux-omap <linux-omap@vger.kernel.org>

Aldyth,
1. Do you mean that NAND boot is not working?
2. Does MMC/SD boot working? If yes, boot the platform from MMC/SD using the latest x-loade/ u-boot and flush the same binaries to NAND using the following commands. 
mmcinit 0
nand unlock 80000 80000
nand erase 80000 80000
fatload mmc 0 80000000 u-boot.bin
nand write.i 80000000 80000 ${filesize}
 
nand unlock 0 80000
nand erase 0 80000 
fatload mmc 0 80000000 MLO
nand write.i 80000000 0 ${filesize}

Regards,
Ghorai

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Tar Gz
> Sent: 2010-04-04 11:13
> To: linux-omap
> Subject: [ASK] OMAP 3430 LDP Trouble
> 
> Hi all,
> i'm sorry if my english too bad
> 
> I try to porting linux to omap 3430 LDP..but my board have trouble
> after i running this command:
> 
> nand ecc sw
> nand unlock 80000 80000
> nand erase 80000 80000
> 
> nand ecc hw
> nand unlock 0 80000
> nand erase 0 80000
> 
> and if i try to turn on my board, BT led [blue led] always on and my
> minicom can't show anything...and i forget to setting the enviroment
> variable mmcinit..
> 
> my question is, how to make my board can run normally like before?
> 
> best regards,
> Aldyth M
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
