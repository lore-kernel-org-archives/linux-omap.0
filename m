From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 3/3] OMAP2+: voltage: clean up error messages
Date: Mon, 29 Aug 2011 14:15:49 -0700
Message-ID: <87fwkjrkai.fsf@ti.com>
References: <1312907661-24436-1-git-send-email-jhovold@gmail.com>
	<1312907661-24436-3-git-send-email-jhovold@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:52051 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754103Ab1H2VPw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Aug 2011 17:15:52 -0400
Received: by mail-pz0-f49.google.com with SMTP id 6so13924155pzk.36
        for <linux-omap@vger.kernel.org>; Mon, 29 Aug 2011 14:15:52 -0700 (PDT)
In-Reply-To: <1312907661-24436-3-git-send-email-jhovold@gmail.com> (Johan
	Hovold's message of "Tue, 9 Aug 2011 18:34:21 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Johan Hovold <jhovold@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

Hi Johan,

Johan Hovold <jhovold@gmail.com> writes:

> Clean up error messages by adding missing whitespace, reducing excessive
> verbosity, and fixing a few language issues.
>
> Signed-off-by: Johan Hovold <jhovold@gmail.com>

I've got a major voltage layer cleanup series in progess (and just
posted a few series.)  Would you care to rebase this on top my
pm-wip/voldtm branch[1] where those cleanups are being done?

Thanks,

Kevin

[1] git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git pm-wip/voltdm

