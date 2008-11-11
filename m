From: "Ramesh Gupta Guntha" <grgupta77@gmail.com>
Subject: Re: [BRIDGE] bridgedriver load/unload problem
Date: Tue, 11 Nov 2008 12:18:34 +0530
Message-ID: <3a2dabf50811102248j27be7ca4tb8ba4dc8910e1d7c@mail.gmail.com>
References: <20081110.135917.46194187.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.191]:12950 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754895AbYKKGsg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Nov 2008 01:48:36 -0500
Received: by mu-out-0910.google.com with SMTP id g7so3255007muf.1
        for <linux-omap@vger.kernel.org>; Mon, 10 Nov 2008 22:48:34 -0800 (PST)
In-Reply-To: <20081110.135917.46194187.Hiroshi.DOYU@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: Ramesh <x0023949@ti.com>, linux-omap@vger.kernel.org, vpasam@ti.com

Hi Hiroshi,

On 11/10/08, Hiroshi DOYU <Hiroshi.DOYU@nokia.com> wrote:
> Hi,
>
> I got the following error, has anyone got the similar problem?
>
> custom:~# cat test.sh
> #!/bin/sh
>
> modprobe bridgedriver \
>    base_img=./ddspbase_tiomap3430.dof64P && \
>    ./ping.out 1 && \
>    rmmod bridgedriver
>
> custom:~# ./test.sh
> DSP device detected !!
> DSPNodeCreate succeeded
> DSPNode_registerNotify succeeded
> DSPNode_run succeeded
> Ping: Id 1.000000 Msg 0.000000 Mem 15408.000000
> custom:~#
> custom:~# ./test.sh
> DSP device detected !! Unable to handle kernel paging request at virtual address be5e7017
>
> pgd = c0004000
> [be5e7017] *pgd=00000000
> Internal error: Oops: 805 [#1] PREEMPT

I am not able to reproduce this issue. Is it consistent at your end?

What is the bridge patch set you are using for this?

Please let me know your comments.

thanks
Ramesh
