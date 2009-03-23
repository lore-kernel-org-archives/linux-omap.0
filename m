From: Ameya Palande <2ameya@gmail.com>
Subject: Re: tidspbridge git repository
Date: Mon, 23 Mar 2009 13:22:34 +0200
Message-ID: <269694c00903230422u9bf7636la9d0084782855f96@mail.gmail.com>
References: <DDE834F1D8D96540B7373DFF675BF56C110F2E19F0@NOK-EUMSG-03.mgdnok.nokia.com>
	 <7A436F7769CA33409C6B44B358BFFF0CFF6C9B99@dlee02.ent.ti.com>
	 <269694c00903230058j1f25d94btb95101890ba286c3@mail.gmail.com>
	 <7A436F7769CA33409C6B44B358BFFF0CFF6C9BA1@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:39773 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754700AbZCWLWh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Mar 2009 07:22:37 -0400
Received: by fxm2 with SMTP id 2so1741823fxm.37
        for <linux-omap@vger.kernel.org>; Mon, 23 Mar 2009 04:22:34 -0700 (PDT)
In-Reply-To: <7A436F7769CA33409C6B44B358BFFF0CFF6C9BA1@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: "ameya.palande@nokia.com" <ameya.palande@nokia.com>, "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "hiroshi.doyu@nokia.com" <hiroshi.doyu@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>

On Mon, Mar 23, 2009 at 10:55 AM, Menon, Nishanth <nm@ti.com> wrote:
>
>> -----Original Message-----
>> From: Ameya Palande [mailto:2ameya@gmail.com]
>> Sent: Monday, March 23, 2009 9:58 AM
>>
>> When I try to fetch pm-2.6.28 from Kevin's tree I always get
>> following error:
>>
>> error: Unable to find 58d4e18530da1ca4020c1046709b7d8cdadc639c under
>> http://www.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git
>> Cannot obtain needed blob 58d4e18530da1ca4020c1046709b7d8cdadc639c
>> while processing commit a0c296df7fc41bd1e3f209c1bece0ba2ec30bc81.
>> fatal: Fetch failed.
>>
>> Command string:
>> git fetch http://www.kernel.org/pub/scm/linux/kernel/git/khilman/linux-
>> omap-pm.git
>> pm-2.6.28:pm-2.6.28
>>
> Git protocol works... http seems broken..
>
>
> Regards,
> Nishanth Menon
>

Thanks Nishant!
tidspbridge patchset is now rebased on kevin's pm-2.6.28 branch.

Cheers,
Ameya.
