From: Thomas Weber <weber@corscience.de>
Subject: Re: devkit8000 & omap3stalker LCD panel
Date: Thu, 01 Sep 2011 15:00:48 +0200
Message-ID: <4E5F8200.4040608@corscience.de>
References: <1314859332.1933.4.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:60702 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932107Ab1IANBN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Sep 2011 09:01:13 -0400
In-Reply-To: <1314859332.1933.4.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: lzg@ema-tech.com, linux-omap mailing list <linux-omap@vger.kernel.org>

Am 01.09.2011 08:42, schrieb Tomi Valkeinen:
> Hi Thomas, Jason,
>
> I noticed that both devkit8000 and omap3stalker boards use the generic
> dpi driver for LCD. Why is that? If the boards have a normal fixed
> resolution LCD, the timings for the LCD should be added to the
> panel-generic-dpi.c.
>
>  Tomi
>
>
Hello Tomi,

I will send a patch that adds support for the devkit8000 panel.

Thomas

