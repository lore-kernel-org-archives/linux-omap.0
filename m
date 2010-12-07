From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: Re: OMAP HSMMC problems with off-mode
Date: Tue, 07 Dec 2010 21:51:53 +0200
Message-ID: <4CFE9059.1080202@nokia.com>
References: <alpine.DEB.2.00.1012071101590.13430@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:37645 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752518Ab0LGTwK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 7 Dec 2010 14:52:10 -0500
In-Reply-To: <alpine.DEB.2.00.1012071101590.13430@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Madhusudhan Chikkature <madhu.cr@ti.com>, =?ISO-8859-1?Q?Beno=EEt_C?= =?ISO-8859-1?Q?ousson?= <b-cousson@ti.com>, Kishore Kadiyala <kishore.kadiyala@ti.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "sawant@ti.com" <sawant@ti.com>, "Kristo Tero (Nokia-D/Tampere)" <Tero.Kristo@nokia.com>

On 07/12/10 20:21, ext Paul Walmsley wrote:
>
> Madhusudhan,
>
> On my OMAP35xx BeagleBoard here, HSMMC is non-functional after returning
> from dynamic off-mode.  The MMC LED turns on and stays on, and the process
> hangs, although the rest of the system still seems to run.  Looks like
> you're listed as the maintainer for this code.  Do you know why this is,
> and what can be done to fix it?

It is at least because omap_pm_get_dev_context_loss_count() is not
implemented.  Tero Kristo was looking at that recently.

>
> This is using linux-omap master at commit
> a04fd22204b13ce34a3f8a8157f83c44d64f8da9, using omap2plus_defconfig with
> DSS configured in.  My boot and root partitions are on MMC.  Following are
> the commands I used to reproduce this problem.
>
>
> regards
>
> - Paul
>
> echo 1>  /debug/pm_debug/sleep_while_idle
> echo 1>  /debug/pm_debug/enable_off_mode
> echo 5>  /sys/devices/platform/omap/omap-hsuart.0/sleep_timeout
> echo 5>  /sys/devices/platform/omap/omap-hsuart.1/sleep_timeout
> echo 5>  /sys/devices/platform/omap/omap-hsuart.2/sleep_timeout
>
>

