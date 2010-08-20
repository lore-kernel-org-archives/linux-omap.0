From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: NAND ECC in linux-omap
Date: Thu, 19 Aug 2010 17:27:33 -0700
Message-ID: <8762z6f7re.fsf@deeprootsystems.com>
References: <AANLkTimABq72N98Ca6yJ9FgYnyDpod3qRPoTypkDn-4A@mail.gmail.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B030E8188DB@dbde02.ent.ti.com>
	<AANLkTik4+gApkw5fQ561QnJPLX5ED7oN3oU0P6F0+Gsv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:49869 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752331Ab0HTA1g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Aug 2010 20:27:36 -0400
Received: by pzk26 with SMTP id 26so994341pzk.19
        for <linux-omap@vger.kernel.org>; Thu, 19 Aug 2010 17:27:36 -0700 (PDT)
In-Reply-To: <AANLkTik4+gApkw5fQ561QnJPLX5ED7oN3oU0P6F0+Gsv@mail.gmail.com>
	(Cliff Brake's message of "Wed, 18 Aug 2010 11:45:31 -0400")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Cliff Brake <cliff.brake@gmail.com>
Cc: "Ghorai, Sukumar" <s-ghorai@ti.com>, Linux OMAP Users <linux-omap@vger.kernel.org>, "Kamat, Nishant" <nskamat@ti.com>

Cliff Brake <cliff.brake@gmail.com> writes:

> On Wed, Aug 18, 2010 at 12:14 AM, Ghorai, Sukumar <s-ghorai@ti.com> wrote:
>> [Ghorai]
>> 1. Can you send the git tree link and branch you are referring?
>
> git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git
> branch: pm
> 95e42b92313f229cbc9fc81bf68fe60aaee515aa
>
> I'm pretty sure this branch tracks linux-omap.  

Yes, it does.

> I have not tested
> linux-omap yet (git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git:master)

the PM branch has nothing NAND/MTD related in it, so the problem should
be the same on linux-omap, but should be tested there as well to
eliminate any possible PM interactions.

Kevin
