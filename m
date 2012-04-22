From: Russ Dill <Russ.Dill@ti.com>
Subject: Re: [PATCH] Fix build breakage in omap-usb-host.c
Date: Sun, 22 Apr 2012 01:50:39 -0700
Message-ID: <CA+Bv8XbDZSsrF5NPXVE-zOWQ=NoZmWvtsoDTL42a70unFA8QFw@mail.gmail.com>
References: <1335084498-17918-1-git-send-email-Russ.Dill@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:58220 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751980Ab2DVIul (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 22 Apr 2012 04:50:41 -0400
Received: by lbom4 with SMTP id m4so4923510lbo.19
        for <linux-omap@vger.kernel.org>; Sun, 22 Apr 2012 01:50:39 -0700 (PDT)
In-Reply-To: <1335084498-17918-1-git-send-email-Russ.Dill@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Keshava Munegowda <Keshava_mgowda@ti.com>, Samuel Ortiz <sameo@linux.intel.com>, Russ Dill <Russ.Dill@ti.com>

On Sun, Apr 22, 2012 at 1:48 AM, Russ Dill <Russ.Dill@ti.com> wrote:
> 'ARM: OMAP3: USB: Fix the EHCI ULPI PHY reset issue' removes the include for
> linux/gpio.h from omap-usb-host.c. This include indirectly includes plat/cpu.h
> which is required by omap-usb-host.c. Fix the build breakage by including
> it directly.

(Sorry, I should add some detail, this is a build breakage in linux-next)
