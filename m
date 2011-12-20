From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL] omap uart runtime PM support for v3.2 merge window
Date: Mon, 19 Dec 2011 21:33:50 -0800
Message-ID: <CAOesGMjjOBeVmtX=eSrUx1Ur4PbnybgW9t1eV7PrR9dNv-ZtRw@mail.gmail.com>
References: <20111219201018.GT6464@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:57977 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751688Ab1LTFdv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Dec 2011 00:33:51 -0500
Received: by ggdk6 with SMTP id k6so4507494ggd.19
        for <linux-omap@vger.kernel.org>; Mon, 19 Dec 2011 21:33:50 -0800 (PST)
In-Reply-To: <20111219201018.GT6464@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi,

On Mon, Dec 19, 2011 at 12:10 PM, Tony Lindgren <tony@atomide.com> wrote:
> Hi Arnd & Olof,
>
> Please pull omap uart changes from:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap uart
>
> These allow us to remove quite a bit of serial port code
> from arch/arm/*omap* as the omap-serial.c driver can now do
> the necessary things using runtime PM :) Also this series
> changes omap board-generic.c to use DT for the serial port.
>
> The changes to drivers/tty/serial/omap-serial.c have been
> agreed to be merged via omap patches in the following thread:
>
> http://www.spinics.net/lists/linux-serial/msg05145.html

Thanks, pulled into next/pm.


-Olof
