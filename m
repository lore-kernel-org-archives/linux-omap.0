From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: Re: Hang on boot
Date: Mon, 11 Oct 2010 11:19:28 +0530
Message-ID: <AANLkTikWSDfAN97uznf_uxTHeL7NHFtKb3nvzPUJU9Mm@mail.gmail.com>
References: <AANLkTiknOwhUJny9WcYxROic+SP1eOcUmqbG7Kh9pPDY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:34150 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751782Ab0JKFtx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Oct 2010 01:49:53 -0400
Received: by mail-wy0-f182.google.com with SMTP id 36so65866wyb.27
        for <linux-omap@vger.kernel.org>; Sun, 10 Oct 2010 22:49:48 -0700 (PDT)
In-Reply-To: <AANLkTiknOwhUJny9WcYxROic+SP1eOcUmqbG7Kh9pPDY@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: John Garland <johnnyg@cse.unsw.edu.au>
Cc: linux-omap@vger.kernel.org

On Mon, Oct 11, 2010 at 8:39 AM, John Garland <johnnyg@cse.unsw.edu.au> wrote:
> Hi,
>
> Both the dspbridge and master branch of linux-omap seem to hang when
> trying to boot (i.e. no output) on a beagleboard C2.
> This is with the new omap2plus_defconfig (as opposed to the old
> omap3_defconfig).
>
> Is anybody else experiencing this or does anyone have any idea what
> could be causing this?
>
Grazvydas Ignotas reported this with linux-next a few hours ago.
Try disabling OMAP2 and OMAP4 support and see if that works.

Another useful debug method is to enable CONFIG_EARLY_PRINTK
and then add "earlyprintk" to your bootargs.

I'll dig up a beagleboard in a while and check.

- Anand
