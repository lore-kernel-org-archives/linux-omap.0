From: Igor Grinberg <grinberg@compulab.co.il>
Subject: AM3517 (Sitara) MMC2 help
Date: Tue, 24 Aug 2010 15:42:04 +0300
Message-ID: <4C73BE1C.7080503@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:35504 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752366Ab0HXMmK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Aug 2010 08:42:10 -0400
Received: from mail.linux-boards.com ([192.114.83.142] helo=zimbra-mta.compulab.co.il)
	by compulab.site5.com with esmtp (Exim 4.69)
	(envelope-from <grinberg@compulab.co.il>)
	id 1OnspN-0001or-Mg
	for linux-omap@vger.kernel.org; Tue, 24 Aug 2010 07:42:10 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra-mta.compulab.co.il (Postfix) with ESMTP id B58CE7E9168
	for <linux-omap@vger.kernel.org>; Tue, 24 Aug 2010 15:42:08 +0300 (IDT)
Received: from zimbra-mta.compulab.co.il ([127.0.0.1])
	by localhost (zimbra-mta.compulab.co.il [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PohoLH8woxAQ for <linux-omap@vger.kernel.org>;
	Tue, 24 Aug 2010 15:42:08 +0300 (IDT)
Received: from [10.1.1.13] (grinberg-pc.compulab.local [10.1.1.13])
	by zimbra-mta.compulab.co.il (Postfix) with ESMTP id 3AA787E9165
	for <linux-omap@vger.kernel.org>; Tue, 24 Aug 2010 15:42:08 +0300 (IDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

 Hi,

I have am3517 based board and Libertas sdio (4 wires)
wifi connected directly (no transceiver / level shifter) on mmc2
(which is named mmc1 in s/w).

am3517 is configured (h/w) for 3.3V and so is Libertas wifi.

dmesg | grep mmc1 shows:

--------------cut------------------
mux: Setting signal sdmmc1_clk.sdmmc1_clk 0x0000 -> 0x0118
mux: Setting signal sdmmc1_cmd.sdmmc1_cmd 0x0000 -> 0x0118
mux: Setting signal sdmmc1_dat0.sdmmc1_dat0 0x0100 -> 0x0118
mux: Setting signal sdmmc1_dat1.sdmmc1_dat1 0x0100 -> 0x0118
mux: Setting signal sdmmc1_dat2.sdmmc1_dat2 0x0100 -> 0x0118
mux: Setting signal sdmmc1_dat3.sdmmc1_dat3 0x0100 -> 0x0118
mmc1: clock 0Hz busmode 1 powermode 0 cs 0 Vdd 0 width 0 timing 0
mmc1: clock 0Hz busmode 1 powermode 1 cs 0 Vdd 20 width 0 timing 0
mmc1: clock 400000Hz busmode 1 powermode 2 cs 0 Vdd 20 width 0 timing 0
mmc1: starting CMD52 arg 00000c00 flags 00000195                      
mmci-omap-hs mmci-omap-hs.1: mmc1: CMD52, argument 0x00000c00         
mmc1: req done (CMD52): -110: 00000000 00000000 00000000 00000000     
mmc1: starting CMD52 arg 80000c08 flags 00000195                      
mmci-omap-hs mmci-omap-hs.1: mmc1: CMD52, argument 0x80000c08         
mmc1: req done (CMD52): -110: 00000000 00000000 00000000 00000000     
mmc1: clock 400000Hz busmode 1 powermode 2 cs 1 Vdd 20 width 0 timing 0
mmc1: starting CMD0 arg 00000000 flags 000000c0                       
mmci-omap-hs mmci-omap-hs.1: mmc1: CMD0, argument 0x00000000          
mmc1: req done (CMD0): 0: 00000000 00000000 00000000 00000000         
mmc1: clock 400000Hz busmode 1 powermode 2 cs 0 Vdd 20 width 0 timing 0
mmc1: starting CMD8 arg 000001aa flags 000002f5                       
mmci-omap-hs mmci-omap-hs.1: mmc1: CMD8, argument 0x000001aa          
mmc1: req done (CMD8): -110: 00000000 00000000 00000000 00000000      
mmc1: starting CMD5 arg 00000000 flags 000002e1                       
mmci-omap-hs mmci-omap-hs.1: mmc1: CMD5, argument 0x00000000          
mmc1: req failed (CMD5): -110, retrying...
mmci-omap-hs mmci-omap-hs.1: mmc1: CMD5, argument 0x00000000
mmc1: req failed (CMD5): -110, retrying...
mmci-omap-hs mmci-omap-hs.1: mmc1: CMD5, argument 0x00000000
mmc1: req failed (CMD5): -110, retrying...
mmci-omap-hs mmci-omap-hs.1: mmc1: CMD5, argument 0x00000000
mmc1: req done (CMD5): -110: 00000000 00000000 00000000 00000000
mmc1: starting CMD55 arg 00000000 flags 000000f5
mmci-omap-hs mmci-omap-hs.1: mmc1: CMD55, argument 0x00000000
mmc1: req done (CMD55): -110: 00000000 00000000 00000000 00000000
mmc1: starting CMD55 arg 00000000 flags 000000f5
mmci-omap-hs mmci-omap-hs.1: mmc1: CMD55, argument 0x00000000
mmc1: req done (CMD55): -110: 00000000 00000000 00000000 00000000
mmc1: starting CMD55 arg 00000000 flags 000000f5
mmci-omap-hs mmci-omap-hs.1: mmc1: CMD55, argument 0x00000000
mmc1: req done (CMD55): -110: 00000000 00000000 00000000 00000000
mmc1: starting CMD55 arg 00000000 flags 000000f5
mmci-omap-hs mmci-omap-hs.1: mmc1: CMD55, argument 0x00000000
mmc1: req done (CMD55): -110: 00000000 00000000 00000000 00000000
mmc1: starting CMD1 arg 00000000 flags 000000e1
mmci-omap-hs mmci-omap-hs.1: mmc1: CMD1, argument 0x00000000
mmc1: req done (CMD1): -110: 00000000 00000000 00000000 00000000
mmc1: clock 0Hz busmode 1 powermode 0 cs 0 Vdd 0 width 0 timing 0
-------------------cut---------------------

Libertas is powered up and gets reseted properly.
On the oscilloscope, I see some communication going
on the CMD line and stops after some time.

am3517 PSP from TI, does not even registers/enables
the wifi combo found on am3517evm.

Have anybody got the mmc2 working on am3517?
May be with transceiver?

Any help will be appreciated.

Thanks

-- 
Regards,
Igor.

