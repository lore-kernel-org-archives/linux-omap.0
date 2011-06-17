From: Daniel Mack <zonque@gmail.com>
Subject: Re: Trouble with newer kernels on Gumstix Overo boards
Date: Fri, 17 Jun 2011 17:11:26 +0200
Message-ID: <BANLkTimfeS1Xin779eg=8cdjqmqcQeB6HA@mail.gmail.com>
References: <BANLkTimJTBpj30EKf_EucvOf2yCHHbRrkQ@mail.gmail.com>
	<ADF30F4D7BDE934D9B632CE7D5C7ACA4047B99E7E7AD@dbde03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:64710 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758349Ab1FQPL1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Jun 2011 11:11:27 -0400
Received: by pvg12 with SMTP id 12so1896216pvg.19
        for <linux-omap@vger.kernel.org>; Fri, 17 Jun 2011 08:11:26 -0700 (PDT)
In-Reply-To: <ADF30F4D7BDE934D9B632CE7D5C7ACA4047B99E7E7AD@dbde03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Jun 17, 2011 at 4:03 PM, Gadiyar, Anand <gadiyar@ti.com> wrote:
>> console=ttyS2,115200 root=/dev/mmcblk0p2 rw rootfstype=ext3 rootwait
>
> Here is your problem. We now use the OMAP-serial driver for the UARTs.

Which breaks backward-compatibility with bootloaders set up for older
kernels. Now I have to deploy kernels with CONFIG_CMDLINE_FORCE=y. Was
that really necessary?

> Change the ttyS2 to ttyO2 and you should be fine.

You're right, that did the trick. Thanks a lot!

Daniel
