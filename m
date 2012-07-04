From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] remoteproc: adopt the driver core's alloc/add/del/put naming
Date: Thu, 5 Jul 2012 01:50:37 +0200
Message-ID: <CACRpkdYr4VFpSLhcy3vst4=ZzTVPG8OKiZvLb_z4VmKmJGrQeg@mail.gmail.com>
References: <1341409019-32166-1-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:49791 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755623Ab2GDXui convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Jul 2012 19:50:38 -0400
Received: by qadb17 with SMTP id b17so3529083qad.19
        for <linux-omap@vger.kernel.org>; Wed, 04 Jul 2012 16:50:37 -0700 (PDT)
In-Reply-To: <1341409019-32166-1-git-send-email-ohad@wizery.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, Stephen Boyd <sboyd@codeaurora.org>, Fernando Guzman Lugo <fernando.lugo@ti.com>, =?ISO-8859-1?Q?Sjur_Br=E6ndeland?= <sjur.brandeland@stericsson.com>

On Wed, Jul 4, 2012 at 3:36 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:

> To make remoteproc's API more intuitive for developers, we adopt
> the driver core's naming, i.e. alloc -> add -> del -> put. We'll also
> add register/unregister when their first user shows up.
>
> Otherwise - there's no functional change here.
>
> Suggested by Russell King <linux@arm.linux.org.uk>.
>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Fernando Guzman Lugo <fernando.lugo@ti.com>
> Cc: Sjur Br=E6ndeland <sjur.brandeland@stericsson.com>
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>

I understand this patch and it's a good thing, so:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
