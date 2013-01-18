From: Cliff Brake <cliff.brake@gmail.com>
Subject: gpios reset when kernel starts
Date: Fri, 18 Jan 2013 15:08:01 -0500
Message-ID: <CAOd_LFy8b_=eqqraKHz7Kc+o3wFTH-e8G=74d9+ec7L2B28crA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:56432 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751092Ab3ARUNI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Jan 2013 15:13:08 -0500
Received: by mail-la0-f41.google.com with SMTP id em20so4315784lab.28
        for <linux-omap@vger.kernel.org>; Fri, 18 Jan 2013 12:13:05 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

I'm working with the 3.0 kernel on a 3730.  It appears that when I set
a GPIO to output and set it high in the bootloader, this gets reset
when the kernel starts.  Is this expected, and is there any workaround
to have this not happen?  The alternate functions seem to be sticking
when configured in the bootloader.

Its possible that something in the kernel is taking control of the
signal, but it seems ulikely as I've tried two different unrelated
GPIOs with the same result.

Thanks,
Cliff

-- 
=================
http://bec-systems.com
