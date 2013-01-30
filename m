From: Nishanth Menon <nm@ti.com>
Subject: Re: [RFC PATCH v2 1/2] ARM: kernel: update cpuinfo to print SoC model name
Date: Tue, 29 Jan 2013 23:48:14 -0600
Message-ID: <CAGo_u6pvU0ZMJ0C-3pqW3-Sx87_o5_JM0HDT9eb_yxe+h_SiJQ@mail.gmail.com>
References: <1359506337-21619-1-git-send-email-ruslan.bilovol@ti.com>
	<1359506337-21619-2-git-send-email-ruslan.bilovol@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:39185 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750732Ab3A3FsQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Jan 2013 00:48:16 -0500
In-Reply-To: <1359506337-21619-2-git-send-email-ruslan.bilovol@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ruslan Bilovol <ruslan.bilovol@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, tony@atomide.com, linux@arm.linux.org.uk, eduardo.valentin@ti.com

On Tue, Jan 29, 2013 at 6:38 PM, Ruslan Bilovol <ruslan.bilovol@ti.com> wrote:
>
> SoC name        : OMAP4470 ES1.0 HS
I am sorry, but I have to NAK for specifically reasons explained in
http://marc.info/?l=linux-omap&m=135950276616961&w=2

I just dont think SoC information belongs in /proc/cpuinfo. nor is SoC
name "OMAP4470 ES1.0 HS" -> it is just OMAP4470.

Regards,
Nishanth Menon
