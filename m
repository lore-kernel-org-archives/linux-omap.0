From: Ameya Palande <2ameya@gmail.com>
Subject: Re: tidspbridge git repository
Date: Mon, 23 Mar 2009 09:58:05 +0200
Message-ID: <269694c00903230058j1f25d94btb95101890ba286c3@mail.gmail.com>
References: <DDE834F1D8D96540B7373DFF675BF56C110F2E19F0@NOK-EUMSG-03.mgdnok.nokia.com>
	 <7A436F7769CA33409C6B44B358BFFF0CFF6C9B99@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f169.google.com ([209.85.218.169]:53674 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752043AbZCWH6I convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Mar 2009 03:58:08 -0400
Received: by bwz17 with SMTP id 17so1625040bwz.37
        for <linux-omap@vger.kernel.org>; Mon, 23 Mar 2009 00:58:05 -0700 (PDT)
In-Reply-To: <7A436F7769CA33409C6B44B358BFFF0CFF6C9B99@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: "ameya.palande@nokia.com" <ameya.palande@nokia.com>, "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "hiroshi.doyu@nokia.com" <hiroshi.doyu@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>

On Mon, Mar 23, 2009 at 9:44 AM, Menon, Nishanth <nm@ti.com> wrote:
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of ameya.palande@nokia.com
>> Sent: Monday, March 23, 2009 9:42 AM
>> To: tony@atomide.com
>> Cc: linux-omap@vger.kernel.org; hiroshi.doyu@nokia.com
>> Subject: tidspbridge git repository
>>
>> I have collected latest patches for tidspbridge at:
>> git://gitorious.org/tidspbridge/mainline.git
>>
>> Branch is: tidspbridge
>>
>> It is based on your pm branch.
> Is'nt the old PM branch moved to Kevin's tree[1]?
> Regards,
> Nishanth Menon
> Ref:
> [1] http://git.kernel.org/?p=3Dlinux/kernel/git/khilman/linux-omap-pm=
=2Egit;a=3Dshortlog;h=3Dpm-2.6.28
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>

When I try to fetch pm-2.6.28 from Kevin's tree I always get
following error:

error: Unable to find 58d4e18530da1ca4020c1046709b7d8cdadc639c under
http://www.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.gi=
t
Cannot obtain needed blob 58d4e18530da1ca4020c1046709b7d8cdadc639c
while processing commit a0c296df7fc41bd1e3f209c1bece0ba2ec30bc81.
fatal: Fetch failed.

Command string:
git fetch http://www.kernel.org/pub/scm/linux/kernel/git/khilman/linux-=
omap-pm.git
pm-2.6.28:pm-2.6.28

Cheers,
Ameya.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
