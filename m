From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCHv5 05/15] hwspinlock/omap: add support for dt nodes
Date: Tue, 1 Jul 2014 15:48:59 +0300
Message-ID: <CAK=WgbamDPN9EmKUu3+c3RbsQn1uhz5MGGvpWSSUJSUKyoH8Cw@mail.gmail.com>
References: <1398904476-26200-1-git-send-email-s-anna@ti.com> <1398904476-26200-6-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:58252 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751593AbaGAMtU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Jul 2014 08:49:20 -0400
Received: by mail-la0-f45.google.com with SMTP id hr17so5832471lab.4
        for <linux-omap@vger.kernel.org>; Tue, 01 Jul 2014 05:49:19 -0700 (PDT)
In-Reply-To: <1398904476-26200-6-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Kumar Gala <galak@codeaurora.org>, Tony Lindgren <tony@atomide.com>, Josh Cartwright <joshc@codeaurora.org>, Bjorn Andersson <bjorn@kryo.se>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

Hi Suman,

On Thu, May 1, 2014 at 3:34 AM, Suman Anna <s-anna@ti.com> wrote:
>  static int omap_hwspinlock_probe(struct platform_device *pdev)
>  {
> -       struct hwspinlock_pdata *pdata = pdev->dev.platform_data;
> +       struct device_node *node = pdev->dev.of_node;
>         struct hwspinlock_device *bank;
>         struct hwspinlock *hwlock;
>         struct resource *res;
>         void __iomem *io_base;
>         int num_locks, i, ret;
> +       int base_id = 0;

We shouldn't implicitly assume base_id is zero: let's explicitly
protect against potential subsequent invocations of
omap_hwspinlock_probe.

Thanks,
Ohad.
