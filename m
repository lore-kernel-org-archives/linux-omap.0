From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 0/2] ARM: OMAP: Couple of misc fixes for 3.3
Date: Mon, 6 Feb 2012 15:03:27 +0530
Message-ID: <CAMQu2gyXA7Bj1d5fPJLZ6yC+0o3TM1K8+2qQFU1J2W_zQbDwWg@mail.gmail.com>
References: <1328191435-18652-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:39480 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754050Ab2BFJds convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 6 Feb 2012 04:33:48 -0500
Received: by mail-qw0-f51.google.com with SMTP id 41so3704831qan.17
        for <linux-omap@vger.kernel.org>; Mon, 06 Feb 2012 01:33:47 -0800 (PST)
In-Reply-To: <1328191435-18652-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Tony,

On Thu, Feb 2, 2012 at 7:33 PM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> Patches are tested on OMAP4430 SDP.
>
> The following changes since commit 62aa2b537c6f5957afd98e29f96897419e=
d5ebab:
>
> =A0Linux 3.3-rc2 (2012-01-31 13:31:54 -0800)
>
> Rajendra Nayak (1):
> =A0ARM: OMAP: Get rid of reset for system timer
>
> Santosh Shilimkar (1):
> =A0ARM: OMAP4: Move the barrier memboclk_steal() as part of reserve
> =A0 =A0callback
>
Can you please queue these two fixes if you are ok
with them ?

Regards
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
