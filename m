From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: Fwd: next boot: 101 boots: 89 pass, 12 fail (next-20141216)
Date: Thu, 18 Dec 2014 07:24:38 +0530
Message-ID: <CAKohpomnAjwUYGnRvmefXStQLqcWgJ7c+8rZ2iADo23Q=zZCsQ@mail.gmail.com>
References: <E1Y0lcK-00026B-7I@ip-10-35-177-41.ec2.internal>
	<CAMAWPa98kyaUJpt=GLw4cH7fkg+8BkrA0kds=H-2-4fWXy_tqw@mail.gmail.com>
	<54909E30.4040300@ti.com>
	<CAKohponYEqhPjZmk_WH+TbNPLHEM5HWxta7CLUoM5+2iHYw_zw@mail.gmail.com>
	<20141217152857.GA838@kahuna>
	<CAKohponn9Ubk7ze5XVsJ4Gdkosx4YY3e0fNHLwjUYurkOYFqsg@mail.gmail.com>
	<CAGo_u6qeNBSHYtq84QZH76bR_8xztbi2+Q6mXwH-_orTSg1jtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:35220 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751902AbaLRByj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Dec 2014 20:54:39 -0500
Received: by mail-ob0-f175.google.com with SMTP id wp4so482434obc.6
        for <linux-omap@vger.kernel.org>; Wed, 17 Dec 2014 17:54:39 -0800 (PST)
In-Reply-To: <CAGo_u6qeNBSHYtq84QZH76bR_8xztbi2+Q6mXwH-_orTSg1jtQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Kevin Hilman <khilman@kernel.org>, Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 17 December 2014 at 22:13, Nishanth Menon <nm@ti.com> wrote:
> I do realize that i did have different opinion given bootloader screw
> ups. Given that we have discovered a potentially bad configuration (in
> this case for some reason almost ALL TI platforms "have bad
> configuration" - could be due to recent clock code changes or what
> ever), just killing boot does not make sense to me as purely
> bootloader being the cause may not always be the case for that path to
> go wrong.

Sorry, I still *disagree*.

Its not about bootloaders getting screwed up.. Yes, bootloader was indeed
running at a frequency not listed in kernel. But we *tried* our best to get
that resolved and we failed to change frequency.

We *shouldn't* allow kernel to move a inch further. It might be dangerous
for the platform to continue further as we are talking about the almighty
CPU. So, the bug is still the right way forward, atleast for me.

--
viresh
