From: Kevin Hilman <khilman@ti.com>
Subject: Re: Why was the gptimer_wakup from suspend removed?
Date: Mon, 30 Jan 2012 13:36:06 -0800
Message-ID: <87mx94rhyx.fsf@ti.com>
References: <3D8305F5-07DF-4B04-981D-762214113CDB@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:49823 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751932Ab2A3VgK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Jan 2012 16:36:10 -0500
Received: by mail-yx0-f172.google.com with SMTP id m3so2225514yen.31
        for <linux-omap@vger.kernel.org>; Mon, 30 Jan 2012 13:36:09 -0800 (PST)
In-Reply-To: <3D8305F5-07DF-4B04-981D-762214113CDB@gmail.com> (Tasslehoff
	Kjappfot's message of "Tue, 24 Jan 2012 23:45:05 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tasslehoff Kjappfot <tasskjapp@gmail.com>
Cc: linux-omap@vger.kernel.org

Hello,

Tasslehoff Kjappfot <tasskjapp@gmail.com> writes:

> It was removed in:
> http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap.git;a=commit;h=98e182a26bbbf5575457622337684ef61493e864
>
> The commit message says a bit about what was done, but not why.

The reason why was because the way it was implemented was a hack and was
causing problems for some other cleanups, so we removed it.

> I'm trying to get suspend somewhat working on my board. The board is
> based on the beagleboard and uses the 1.8V to charge some external
> equipment. My thought was to suspend, wake occasionally to check if
> the charging is done, and shutdown if it is. 

The kernel now has a way to implement exactly this.  Please have a look
at Documentation/power/charger-manager.txt.

> In 2.6.39 which I'm currently using, it's still there, but since it is
> gone in 3.0 and later I'm wondering if I should not rely on it.

No, you should not rely on it.  For your specific case, there is much
better infrastructure to do exactly what you need.

Kevin
