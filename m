From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v2 2/2] ARM: OMAP4: Register the OPP table only for 4430 device
Date: Thu, 9 Aug 2012 12:53:33 +0530
Message-ID: <CAMQu2gxq2x=Qrr2-bpkDdAu-KVuMBZiZnhv-fzUnv2q02667Jg@mail.gmail.com>
References: <1344496102-24451-1-git-send-email-rnayak@ti.com> <1344496102-24451-3-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:55321 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755551Ab2HIHX4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Aug 2012 03:23:56 -0400
Received: by lbbgg6 with SMTP id gg6so332385lbb.7
        for <linux-omap@vger.kernel.org>; Thu, 09 Aug 2012 00:23:54 -0700 (PDT)
In-Reply-To: <1344496102-24451-3-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: khilman@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Aug 9, 2012 at 12:38 PM, Rajendra Nayak <rnayak@ti.com> wrote:
> The 4430 OPP table was being registered for all other OMAP4 variants
> too, like 4460 and 4470 causing issues with cpufreq driver
> enabled. 4460 and 4470 devices have different OPPs as compared to
> 4430, and they should be populated seperately. As long as that
> happens, let the OPP table registeration happen only on 4430 device.
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
