From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 13/14] omap: mailbox: simplify omap_mbox_register()
Date: Fri, 11 Jun 2010 18:19:15 +0300
Message-ID: <AANLkTiniZF39voWYAsgb5FNF8Yi59V3NCZFLOBCGFUo-@mail.gmail.com>
References: <1274548465-20208-1-git-send-email-felipe.contreras@gmail.com>
	<1274548465-20208-14-git-send-email-felipe.contreras@gmail.com>
	<20100524.174233.26958915.Hiroshi.DOYU@nokia.com>
	<AANLkTinAKOZwGSDsQv5VKXBrr1BSQw-9w5Dcq2Z_96M0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:38742 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753726Ab0FKPTS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Jun 2010 11:19:18 -0400
Received: by bwz7 with SMTP id 7so396955bwz.19
        for <linux-omap@vger.kernel.org>; Fri, 11 Jun 2010 08:19:16 -0700 (PDT)
In-Reply-To: <AANLkTinAKOZwGSDsQv5VKXBrr1BSQw-9w5Dcq2Z_96M0@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com

On Fri, Jun 11, 2010 at 6:17 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Mon, May 24, 2010 at 5:42 PM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com> wrote:
>> From: ext Felipe Contreras <felipe.contreras@gmail.com>
>> Subject: [PATCH v3 13/14] omap: mailbox: simplify omap_mbox_register()
>> Date: Sat, 22 May 2010 19:14:24 +0200
>>
>>> No need to dynamically register mailboxes one by one.
>>
>> Can you squash this into [PATCH 10/14]?
>>
>> I think that the "struct omap_mbox **list" would make more sense
>> without those reworking of modifications in this patch.
>
> I don't know, I'm looking at the patch and I think it's much more
> difficult to figure out what's happening.

I forgot to mention: what I will do is put one patch after the other.

-- 
Felipe Contreras
