From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [RFC] mtd: nand: Fix bad block identification issue
Date: Wed, 27 Apr 2011 17:45:45 -0700
Message-ID: <4DB8B8B9.4050604@gmail.com>
References: <1303906161-24175-1-git-send-email-parth.saxena@ti.com> <BANLkTi=sq5am1HKeOfYTmYHUm96O08N-jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:62083 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751866Ab1D1Apw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Apr 2011 20:45:52 -0400
Received: by pzk9 with SMTP id 9so1355958pzk.19
        for <linux-omap@vger.kernel.org>; Wed, 27 Apr 2011 17:45:51 -0700 (PDT)
In-Reply-To: <BANLkTi=sq5am1HKeOfYTmYHUm96O08N-jw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, "Basheer, Mansoor Ahamed" <mansoor.ahamed@ti.com>, "Saxena, Parth" <parth.saxena@ti.com>, Artem Bityutskiy <Artem.Bityutskiy@nokia.com>

Hi,

On 4/27/2011 8:45 AM, Grazvydas Ignotas wrote:
> Brian,
> 
> did you really intend to remove badblockbits? Maybe it should go back
> to nand_base.c?

No, I had no intention of the sorts! It surely should not have been
removed in the first place. I will "ack" a patch to revert it, or next
time I'm at my work machine I'll write one myself.

As a defense for myself...I think I was relatively new to git + kernel
hacking at the time I sent this patch. Sorry for the messup.

> On Wed, Apr 27, 2011 at 3:09 PM, Saxena, Parth <parth.saxena@ti.com> wrote:
>> Commit e0b58d0 ("mtd: nand: add ->badblockbits for minimum number
>> of set bits in bad block byte") by Maxim Levitsky added
>> badblockbits to nand_chip to specify minimum number of set bits
>> in bad block byte. The patch initialized badblockbits to 8 in
>> nand_base.c, but later the initialization line got removed by commit
>> c7b28e2("mtd: nand: refactor BB marker detection"). After this all
>> NAND drivers with NAND_SKIP_BBTSCAN are forced to initialize it to 8.
>> Otherwise bad block identification will fail.

Brian
