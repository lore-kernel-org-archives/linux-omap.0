From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH 0/5] V7/Cortex/omap34xx fixes for 2.6.33-rc1: DCC, kexec,
	atags
Date: Mon, 28 Dec 2009 14:55:41 +0900
Message-ID: <aec7e5c30912272155s41ce8914hd03a5e4c740a5b9d@mail.gmail.com>
References: <20091219034151.26198.26570.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f176.google.com ([209.85.211.176]:64100 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751473AbZL1Fzm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Dec 2009 00:55:42 -0500
Received: by ywh6 with SMTP id 6so10185133ywh.4
        for <linux-omap@vger.kernel.org>; Sun, 27 Dec 2009 21:55:41 -0800 (PST)
In-Reply-To: <20091219034151.26198.26570.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi Tony,

On Sat, Dec 19, 2009 at 12:45 PM, Tony Lindgren <tony@atomide.com> wrot=
e:
> Here are some v7 fixes, mostly to make kexec work.
>
> Using 2.6.33-rc1, these fixes, and kexec from kexec-tools
> git repo, I can reboot my n900 in a loop reliably.

Thanks for your work on this. I previously tested kexec on ARM V6 and
V7 and noticed that V7 didn't work. I revisited my V7 test after
becoming aware of your patches. The single patch below unbreaks V7 on
my target system.

> =A0 =A0 =A0arm: Fix cpu_proc_fin() for proc-v7.S and make kexec work

Cheers,

/ magnus
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
