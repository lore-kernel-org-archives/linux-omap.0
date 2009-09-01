From: Steve Sakoman <sakoman@gmail.com>
Subject: Re: USB confusion
Date: Tue, 1 Sep 2009 11:14:14 -0700
Message-ID: <5e088bd90909011114u4b047d9ft3d27ff3885dbd1ad@mail.gmail.com>
References: <4A9D0898.4000400@mlbassoc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f195.google.com ([209.85.212.195]:38996 "EHLO
	mail-vw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750943AbZIASOM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Sep 2009 14:14:12 -0400
Received: by vws33 with SMTP id 33so251216vws.33
        for <linux-omap@vger.kernel.org>; Tue, 01 Sep 2009 11:14:14 -0700 (PDT)
In-Reply-To: <4A9D0898.4000400@mlbassoc.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Gary Thomas <gary@mlbassoc.com>
Cc: linux-omap@vger.kernel.org

On Tue, Sep 1, 2009 at 4:42 AM, Gary Thomas<gary@mlbassoc.com> wrote:
> What are the options to have USB Host support on the "normal"
> USB channels (i.e. not the OTG port)?
>
> This used to work on my platform but things stopped when I
> upgraded to the latest kernel :-(

I had the same experience with Overo and posted a patch a couple of
weeks ago to get it working (ARM: OMAP3: Overo: Fix EHCI
initialization)

Beagle EHCI is also broken on top of tree and requires a couple of
changes in the board file.  I'll try to submit that patch in the next
day or so.

Steve
