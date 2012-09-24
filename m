From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH] ARM: OMAP: hwmod: align the SmartReflex fck names
Date: Mon, 24 Sep 2012 16:34:24 +0200
Message-ID: <CAORVsuUYh=WuazYePE1PMY9aXn2=Ropp3cOVi3EgqRe34nWz9w@mail.gmail.com>
References: <1348134503-28220-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:46465 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755709Ab2IXOe0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Sep 2012 10:34:26 -0400
Received: by lbbgj3 with SMTP id gj3so6808943lbb.19
        for <linux-omap@vger.kernel.org>; Mon, 24 Sep 2012 07:34:25 -0700 (PDT)
In-Reply-To: <1348134503-28220-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, khilman@ti.com
Cc: Jean Pihet <j-pihet@ti.com>

Hi Paul, Kevin,

On Thu, Sep 20, 2012 at 11:48 AM, Jean Pihet <jean.pihet@newoldbits.com> wrote:
> Rename the smartreflex fck names:
> - for consistency and better readability,
> - for use by the SmartReflex driver, through the hwmod .main_clk
>   field.
>
> Signed-off-by: Jean Pihet <j-pihet@ti.com>

Please discard this version. I have a new version ready after Tony's
comments on the SmartReflex patches [1]

[1] http://marc.info/?l=linux-omap&m=134825443710207&w=2

Re-submitting in a bit.
> ---
>  arch/arm/mach-omap2/clock3xxx_data.c       |   12 ++++++------
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    8 ++++----
>  2 files changed, 10 insertions(+), 10 deletions(-)
>

Regards,
Jean
