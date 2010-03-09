From: Vimal Singh <vimal.newwork@gmail.com>
Subject: Re: probe of omap2-nand failed with -16
Date: Tue, 9 Mar 2010 12:08:56 +0530
Message-ID: <ce9ab5791003082238m370275afkc1df90b8822e35c8@mail.gmail.com>
References: <7448ec711003081204r6d4fd037o7a87a767a71c54d2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f209.google.com ([209.85.218.209]:62696 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751781Ab0CIGjR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Mar 2010 01:39:17 -0500
Received: by bwz1 with SMTP id 1so3556471bwz.21
        for <linux-omap@vger.kernel.org>; Mon, 08 Mar 2010 22:39:16 -0800 (PST)
In-Reply-To: <7448ec711003081204r6d4fd037o7a87a767a71c54d2@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pablo Bitton <pablo.bitton@gmail.com>
Cc: linux-omap@vger.kernel.org

On Tue, Mar 9, 2010 at 1:34 AM, Pablo Bitton <pablo.bitton@gmail.com> wrote:
> Hi,
>
> I've started working on beagle board.
>
> Using pre-compiled kernel (angstrom) - i've got nand driver loaded and running.
>
> When I am trying to compile my own kernel from the source, I get error:
>
>>> probe of omap2-nand failed with -16 (EBUSY)

This happens because we moved 'gpmc_cs_request' from nand driver
(nand/omap2.c) probe to 'mach-omap2/gpmc-nand.c'.

>
> I've selected all configs for Nand...
>
> Am I missing something? Mux configuration? GPIO's?
> Anybody has any idea?

Yes. You need to adopt gpmc-nand.c for beagle boards.

For help you may have a look into below commits:
1. <http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=commitdiff;h=c2798e9342a1394de966c31703e0410ee3988378>

2. <http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=commitdiff;h=88c8460ac32283e2a25e36e4670ff5ab02f3b521>


-- 
Regards,
Vimal Singh
