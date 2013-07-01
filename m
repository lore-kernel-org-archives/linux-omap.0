From: Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: linux-next: panda build failed at arch/arm/mach-omap2/omap4-restart.c
Date: Mon, 1 Jul 2013 13:44:49 +0530
Message-ID: <CA+G9fYtYV6htwVP9aTM+Pc0jFyowDoTdiykxF0cY8RAwcpmKVQ@mail.gmail.com>
References: <CA+G9fYv_9EQUmpRNPUwioSwJVXnXJC5odEKiMd=vKHNWYRT8xw@mail.gmail.com>
	<CA+G9fYupw8Gi=5p2nKVJ9GqfhwBcTw7hyzGA8+K+gHmdL96mJg@mail.gmail.com>
	<874ncluatb.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f48.google.com ([209.85.219.48]:61163 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752854Ab3GAIOt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Jul 2013 04:14:49 -0400
Received: by mail-oa0-f48.google.com with SMTP id f4so4444813oah.7
        for <linux-omap@vger.kernel.org>; Mon, 01 Jul 2013 01:14:49 -0700 (PDT)
In-Reply-To: <874ncluatb.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: Robin Holt <holt@sgi.com>, Linus Walleij <linus.walleij@linaro.org>, Andrey Konovalov <andrey.konovalov@linaro.org>, Russ Anderson <rja@sgi.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, Milosz Wasilewski <milosz.wasilewski@linaro.org>

Hi Kevin,

On 26 June 2013 03:12, Kevin Hilman <khilman@linaro.org> wrote:
> Naresh Kamboju <naresh.kamboju@linaro.org> writes:
>
>> ping
>
> This is a known issue[1] and already has some proposed fixes, they are just
> not merged yet.
>
> Kevin
>
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-June/178209.html
>

Now the panda builds are back to work on linux-next.
https://ci.linaro.org/jenkins/job/linux-next/
-Naresh Kamboju
