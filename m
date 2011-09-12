From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v6 00/25] gpio/omap: driver cleanup and fixes
Date: Mon, 12 Sep 2011 09:39:33 -0700
Message-ID: <87r53lk94q.fsf@ti.com>
References: <1314798161-19523-1-git-send-email-tarun.kanti@ti.com>
	<87ty8pz384.fsf@ti.com>
	<CAC83ZvKoSsGNMDoHNeCOZXk9mOZxcKjT_vMjnXGQn6F52YNDKg@mail.gmail.com>
	<CAC83ZvLN1ucD6R11ga3x7caaPgnEjYPYTehE7xfPf59XSjKYpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:38394 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751560Ab1ILQjj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Sep 2011 12:39:39 -0400
Received: by mail-gx0-f173.google.com with SMTP id 26so4484307gxk.4
        for <linux-omap@vger.kernel.org>; Mon, 12 Sep 2011 09:39:38 -0700 (PDT)
In-Reply-To: <CAC83ZvLN1ucD6R11ga3x7caaPgnEjYPYTehE7xfPf59XSjKYpQ@mail.gmail.com>
	(Tarun Kanti DebBarma's message of "Sat, 10 Sep 2011 06:24:53 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

"DebBarma, Tarun Kanti" <tarun.kanti@ti.com> writes:

> [...]
>>> Please rebase onto that branch so these changes can be tested along with
>>> changes already queued for v3.2.
>> Ok.
> I am not able to git pull
> git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git
> Looks like there is problem with git.kernel.org?

Until the kernel.org infrastructure has recovered, you can use my backup
tree from gitorious[1].  The for_3.2/gpio-cleanup branch is available there.

Kevin

[1] git://gitorious.org/khilman/linux-omap-pm.git
