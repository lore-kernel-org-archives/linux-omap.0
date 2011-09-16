From: Yegor Yefremov <yegor_sub1@visionsystems.de>
Subject: Re: Problems with 3.1.0-rc6 on at3517evm
Date: Fri, 16 Sep 2011 15:48:51 +0200
Message-ID: <4E7353C3.5030406@visionsystems.de>
References: <CAH9NwWdgzaowJ+3dUC2PHp2j7bmbaE0COsgngio=gz4q+KzchQ@mail.gmail.com>
Reply-To: yegor_sub1@visionsystems.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns.visionsystems.de ([62.145.30.242]:58289 "EHLO
	mail.visionsystems.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754747Ab1IPNtD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Sep 2011 09:49:03 -0400
In-Reply-To: <CAH9NwWdgzaowJ+3dUC2PHp2j7bmbaE0COsgngio=gz4q+KzchQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: linux-omap@vger.kernel.org

> I am owning a ZOOM am3517evm evaluation board, where I want to run the
> latest linux kernel (mainline).
> I am not able to boot this board. Are there any patches to fix this
> issues? The deliverd kernel (2.6.32-psp09.00.01.06.sdk)
> boots fine.

You're not alone. This platform is not completely supported in the mainline kernel. Some important patches are still awaiting approval to be committed. Search this list for "AM3517: Booting up":

[PATCH v3 1/2] AM35x: Using OMAP3 generic hwmods
[PATCH v3 2/2] omap_twl: Prevent SR to enable for am3517/am3505 devices

Yegor
