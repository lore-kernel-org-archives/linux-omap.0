From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: TFTP on beagle board
Date: Tue, 17 Nov 2009 07:36:26 +0100
Message-ID: <4B02446A.9070908@googlemail.com>
References: <2cd4ff050911161845k7b67f940mdf486e358d05d33c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:36965 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752447AbZKQGgh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Nov 2009 01:36:37 -0500
Received: by bwz27 with SMTP id 27so10482bwz.21
        for <linux-omap@vger.kernel.org>; Mon, 16 Nov 2009 22:36:42 -0800 (PST)
In-Reply-To: <2cd4ff050911161845k7b67f940mdf486e358d05d33c@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mai Daftedar <mai.daftedar@gmail.com>
Cc: linux-omap@vger.kernel.org, U-Boot user list <u-boot@lists.denx.de>

Mai Daftedar wrote:
> Hi all,
>    I was wondering how can we configure the u-boot with the TFTP
> capability on the beagle board at runtime..

For this you will need ethernet support in U-Boot. There are two (?) 
options to achieve this: Add support for USB ethernet dongle in U-Boot 
or use a Beagle expansion card with ethernet.

Regarding USB ethernet dongle, there are some basic USB patches for 
Beagle U-Boot on the list. But I'm not sure how much work it is to 
enable them to support USB ethernet.

For ethernet on expansion board, there is TinCanTool's Zippy board 
[1]. To access ethernet on this board from U-Boot, an U-Boot OMAP3 SPI 
driver is missing.

Both options are not ready, yet, and need some development work. Any 
help is greatly appreciated!

Cheers

Dirk

Btw.: I added U-Boot list, it is the better place to discuss this.

[1] 
http://www.tincantools.com/product.php?productid=16147&cat=0&page=1&featured
