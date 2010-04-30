From: Cliff Brake <cliff.brake@gmail.com>
Subject: Re: ARM suspend to disk?
Date: Fri, 30 Apr 2010 17:46:59 -0400
Message-ID: <p2kf96d234e1004301446l255a8cb4h7287e2502934e9fd@mail.gmail.com>
References: <4BD881A7.2020402@gmail.com> <87y6g6w373.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f46.google.com ([74.125.82.46]:37567 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752494Ab0D3VrA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Apr 2010 17:47:00 -0400
Received: by wwb34 with SMTP id 34so530105wwb.19
        for <linux-omap@vger.kernel.org>; Fri, 30 Apr 2010 14:46:59 -0700 (PDT)
In-Reply-To: <87y6g6w373.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Peter Tseng <tsenpet09@gmail.com>, linux-omap@vger.kernel.org

On Thu, Apr 29, 2010 at 1:58 PM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:

> What do you expect to gain from suspend-to-disk + snapshot boot that
> you don't already get from suspend-to-RAM using off-mode?
>
> On OMAP, with off-mode enabled, a suspend to RAM puts the entire OMAP
> into full-chip off, and essentially reboots the ARM when waking up
> from suspend (or idle) already.

What does the resume process look like in off mode?  Does the resume
pass through the bootloader?  If so, are the bits that detects resume
from "off" available in U-boot?

Thanks,
Cliff
