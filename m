From: pekon <pekon@pek-sem.com>
Subject: Re: [PATCH 0/6] OMAP2+: GPMC: NAND fixes for 3.17
Date: Tue, 02 Sep 2014 23:39:39 +0530
Message-ID: <540607E3.4000805@pek-sem.com>
References: <1409666227-20622-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from us2.outbound.mailhostbox.com ([208.91.199.247]:38210 "EHLO
	us2.outbound.mailhostbox.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754088AbaIBSJs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Sep 2014 14:09:48 -0400
In-Reply-To: <1409666227-20622-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org

Hi Roger,

On Tuesday 02 September 2014 07:27 PM, Roger Quadros wrote:
> Hi Tony,
>
> These are some of the issues I found while testing v3.17-rc3.
>
> - Wrong ECC scheme used for am43x GP and EPOS evm. We need to use
> BCH16 instead of BCH8.
>
Thanks for updating ECC scheme for AM43x EVM boards.
Just for background history, BCH16 ECC scheme was not in
mainline when AM43xx NAND DTS patches were accepted. So to
avoid any inter-dependency of patches, BCH8 was used instead.

commit f68e355c86cff91e5266cf937ea24fcba0641900
     ARM: dts: am43xx: add support for parallel NAND flash
     CommitDate: 2 March 2014

commit 9748fff96484cfc8bb382ef1436823aefe065c9c
     mtd: nand: omap: add support for BCH16_ECC - NAND driver updates
     CommitDate: 21 May 2014

For the record, boot-loader (u-boot SPL) on AM43x-EPOS and
AM437x-GP EVM boards should be flashed in BCH16 ECC scheme
as NAND device present on this boards has
- page-size=4KiB
- OOB-size=224B

So ROM code expects BCH16 ECC scheme to load first boot-loader(SPL).


with regards, pekon

------------------------
Powered by BigRock.com

