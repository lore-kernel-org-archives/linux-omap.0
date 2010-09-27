From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [QUESTION] How to enable runtime PM
Date: Mon, 27 Sep 2010 08:24:04 -0700
Message-ID: <87eicftdkb.fsf@deeprootsystems.com>
References: <AANLkTikAmbXPE=WX=D=g12xCVRUrmrXGY_qwuteCxbgX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:44321 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759600Ab0I0PYH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Sep 2010 11:24:07 -0400
Received: by pvg2 with SMTP id 2so1295837pvg.19
        for <linux-omap@vger.kernel.org>; Mon, 27 Sep 2010 08:24:06 -0700 (PDT)
In-Reply-To: <AANLkTikAmbXPE=WX=D=g12xCVRUrmrXGY_qwuteCxbgX@mail.gmail.com>
	(Ming Lei's message of "Mon, 27 Sep 2010 10:07:07 +0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ming Lei <tom.leiming@gmail.com>
Cc: linux-omap@vger.kernel.org

Ming Lei <tom.leiming@gmail.com> writes:

> Hi Kevin,
>
> I am interested in runtime pm implementation on OMAP3, and
> want to test this function on omap3-based beagle board, but seems
> no devices on omap3 Soc can support runtime pm(no __pm_runtime_*
> message found from 'dmesg' and rpm debug option is surely enabled)
> now after trying the two omap trees below:
>
>      git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git#pm-core
>      git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git#pm
>
> So, could you give me some guideline about how to bring up runtime pm
> on beagle? such as,
>
>                which git tree and branch should be used?
>                which option should be enabled?
>                or other things.

Hello,

Thanks for the interest in willing to experiment with runtime PM on
OMAP.

You're observations are correct.  The runtime PM core is ready, but none
of the devices have yet been adapted to the runtime PM API.  We will be
converting devices over to runtime PM over the next few merge windows,
with possibly some coming as soon as 2.6.37 (watchdog, UART, GPIO, i2c)

Kevin
