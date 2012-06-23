From: Domenico Andreoli <cavokz@gmail.com>
Subject: Re: Current state of AM33xx patches
Date: Sat, 23 Jun 2012 15:03:13 +0200
Message-ID: <CADjby3UTVBKWRZUBRNTX9Bh4TqQJsoWQrrBxW6HuqSNZCUcvCw@mail.gmail.com>
References: <4FD5BA4C.9070706@gmail.com>
	<4FD5FD9E.5040203@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:61951 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752256Ab2FWNDN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 23 Jun 2012 09:03:13 -0400
Received: by ghrr11 with SMTP id r11so2126978ghr.19
        for <linux-omap@vger.kernel.org>; Sat, 23 Jun 2012 06:03:13 -0700 (PDT)
In-Reply-To: <4FD5FD9E.5040203@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: Daniel Mack <zonque@gmail.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hello,

On Mon, Jun 11, 2012 at 4:15 PM, Vaibhav Hiremath <hvaibhav@ti.com> wrote:
>
> I do maintain wiki page which you should refer for any updates:
> http://processors.wiki.ti.com/index.php/Sitara_Linux_Upstream_Status
>
> In order to get latest and greatest kernel to boot, you can use my repo:
> https://github.com/hvaibhav/am335x-linux

do you have any usable defconfig? I've some trouble with the build of
this branch and I'm not sure about the configuration.

> Also, note that, currently there will be very minimal feature-set
> supported in the kernel, so not sure how much can be leveraged for
> production use-cases.

I need something that boots to userspace, nothing more (but I'm happy
to test) :)

thanks,
Domenico
