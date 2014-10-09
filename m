From: Archit Taneja <archit.taneja@gmail.com>
Subject: Re: [RFC PATCH 0/6] ARM: OMAP4+: hwmod: fixing omap4+ DSS hwmods
Date: Thu, 9 Oct 2014 22:41:19 +0530
Message-ID: <CAD_+KCHvfS=Sy0J47oMD9=7L0bpD-aai=zra4-CzmPHA+uiOhg@mail.gmail.com>
References: <1412863399-9508-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:53140 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751060AbaJIRLX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Oct 2014 13:11:23 -0400
Received: by mail-lb0-f171.google.com with SMTP id z12so1557848lbi.16
        for <linux-omap@vger.kernel.org>; Thu, 09 Oct 2014 10:11:20 -0700 (PDT)
In-Reply-To: <1412863399-9508-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, Tero Kristo <t-kristo@ti.com>

On Thu, Oct 9, 2014 at 7:33 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> This is an RFC to fix the issues with boot time DSS hwmod setup.
>
> There was an earlier series sent by Archit here:
>
> http://www.spinics.net/lists/linux-omap/msg107700.html
>
> This series takes different approach, and just tries to fix the issue at setup
> time by making sure the DSS core hwmod is enabled when a DSS submodule hwmod is
> being setup.
>
> Quickly tested on OMAP4 Panda and OMAP5 uEVM.

The series looks good to me.

Reviewed-by: Archit Taneja <archit.taneja@gmail.com>

Archit
