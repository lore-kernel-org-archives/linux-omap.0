From: Cliff Brake <cliff.brake@gmail.com>
Subject: Re: omap-pm: omap3_pm_defconfig no longer booting on Overo
Date: Fri, 7 May 2010 18:02:40 -0400
Message-ID: <j2lf96d234e1005071502q5a335634jd493a92ee970995b@mail.gmail.com>
References: <4BD93413.6000409@gmail.com> <8739yckbyy.fsf@deeprootsystems.com>
	 <4BDB9C05.5050307@gmail.com> <4BDC4999.4050003@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f46.google.com ([74.125.82.46]:61051 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753903Ab0EGWCm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 May 2010 18:02:42 -0400
Received: by wwa36 with SMTP id 36so340114wwa.19
        for <linux-omap@vger.kernel.org>; Fri, 07 May 2010 15:02:41 -0700 (PDT)
In-Reply-To: <4BDC4999.4050003@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <menon.nishanth@gmail.com>
Cc: Peter Tseng <tsenpet09@gmail.com>, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org

On Sat, May 1, 2010 at 11:32 AM, Nishanth Menon
<menon.nishanth@gmail.com> wrote:
> DISCLAIMER: I dont have a overo, so no idea if this would work.. but here
> you go..
>
> Attached is a diff which probably will help you with the specific changes
> needed for making pm boot on overo. hope it helps..
>
> a.diff is the change you would probably need for the overo file to fix it up
> once for all
>
> the patch file is cleaning up the unnecessary BUG() in resource34xx.c which
> caused the lockup -> elegant fix will potentially need more cleaning up..
> but lets just leave it at the fact that srf is going to go away in a month
> or so..

Nishanth,

These patches get my overo booting with the PM branch -- can they be
pushed to the pm branch?

Thanks,
Cliff
