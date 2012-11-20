From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [PATCH 484/493] arm: remove use of __devexit
Date: Tue, 20 Nov 2012 15:24:25 +0800
Message-ID: <CAMPhdO8z=XBJR-jWMHV0Uq_fAaSG9p1iuh_FYFrSdWnP8KBNDQ@mail.gmail.com>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu> <1353349642-3677-484-git-send-email-wfp5p@virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:44231 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751513Ab2KTHYq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Nov 2012 02:24:46 -0500
In-Reply-To: <1353349642-3677-484-git-send-email-wfp5p@virginia.edu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bill Pemberton <wfp5p@virginia.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <linux@arm.linux.org.uk>, Haojian Zhuang <haojian.zhuang@gmail.com>, Tony Lindgren <tony@atomide.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, davinci-linux-open-source@linux.davincidsp.com, linux-omap@vger.kernel.org, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>

On Tue, Nov 20, 2012 at 2:27 AM, Bill Pemberton <wfp5p@virginia.edu> wrote:
> CONFIG_HOTPLUG is going away as an option so __devexit is no
> longer needed.
>

Acked-by: Eric Miao <eric.y.miao@gmail.com>
