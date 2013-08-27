From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2] gpio: Enable pcf857x GPIO expander for Device Tree
Date: Tue, 27 Aug 2013 05:20:45 +0200
Message-ID: <CACRpkda5Q-Zs8A2VFPvMc9519QWJ3EH08g4Do0se6BcLEg+rug@mail.gmail.com>
References: <1370527523-1030-1-git-send-email-archit@ti.com>
	<1377498081-16358-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f54.google.com ([209.85.219.54]:34400 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752298Ab3H0DUq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Aug 2013 23:20:46 -0400
Received: by mail-oa0-f54.google.com with SMTP id o6so4713899oag.27
        for <linux-omap@vger.kernel.org>; Mon, 26 Aug 2013 20:20:45 -0700 (PDT)
In-Reply-To: <1377498081-16358-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Mon, Aug 26, 2013 at 8:21 AM, Archit Taneja <archit@ti.com> wrote:

> Add code to parse the GPIO expander Device Tree node and extract platform data
> out of it, and populate the struct 'pcf857x_platform_data' maintained by the
> driver. This enables devices to reference the gpio expander from Device Tree.
>
> Add DT binding info in Documentation.
>
> Signed-off-by: Archit Taneja <archit@ti.com>
> ---
> - v2 posted after quite a while, sorry for the delay!
>
> Changes in v2:
> - second gpeio-cell description corrected in Documentation
> - interrupt controller description removed for now, will be added in a follow
>   up patch
> - n_latch description updated

The devicetree portions of this patch needs to be reviewed by
devicetree@vger.kernel.org, so please repost including that
list.

Yours,
Linus Walleij
