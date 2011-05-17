From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH] omap:pm: Fix boot-time errors with debugfs disabled
Date: Tue, 17 May 2011 20:10:00 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024CF13F24@dbde02.ent.ti.com>
References: <1305221790-4944-1-git-send-email-premi@ti.com>
 <BANLkTim+3M3Z0C3GTtTQrb2cqk5eSAsR+w@mail.gmail.com>
 <B85A65D85D7EB246BE421B3FB0FBB593024CE66D34@dbde02.ent.ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB593024CF13264@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56730 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755255Ab1EQOkI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 May 2011 10:40:08 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p4HEe4kt000345
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 17 May 2011 09:40:06 -0500
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024CF13264@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Menon, Nishanth" <nm@ti.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Premi, Sanjeev
> Sent: Friday, May 13, 2011 6:18 PM
> To: linux-omap@vger.kernel.org
> Cc: Menon, Nishanth
> Subject: RE: [PATCH] omap:pm: Fix boot-time errors with 
> debugfs disabled

[snip]...[snip]

> > 
> > [sp] I can try this on Panda. Will be able to get one tomorrow.
> 
> 
> Tested same uImage on Panda as well. Just pasting the top header
> here...
> 
> [    0.000000] Linux version 2.6.39-rc4-13782-gd695569-dirty 
> (premi@mylinux) (gcc version 4.5.1 (Sourcery G++ Lite 
> 2010.09-50) ) #6 SMP Thu May 12 21:40:58 IST 2011
> [    0.000000] CPU: ARMv7 Processor [411fc092] revision 2 
> (ARMv7), cr=10c53c7f
> [    0.000000] CPU: VIPT nonaliasing data cache, VIPT 
> aliasing instruction cache
> [    0.000000] Machine: OMAP4 Panda board
> [    0.000000] Memory policy: ECC disabled, Data cache writealloc
> [    0.000000] Truncating RAM at 80000000-bfffffff to 
> -afffffff (vmalloc region overlap).
> [    0.000000] OMAP4430 ES2.1
> 

Kevin,

Wanted to check if you have look at this patch?

~sanjeev

[snip]...[snip]