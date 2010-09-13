From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: Suspend to RAM broken on BeagleBoard ?
Date: Mon, 13 Sep 2010 19:25:43 +0300
Message-ID: <AANLkTikd4O7Prv51WuQuQ9Nr_bPkLLjmuFsHGTPTgJY-@mail.gmail.com>
References: <20100910174814.6e5d439e@surf>
	<87sk1h4640.fsf@deeprootsystems.com>
	<20100911110007.5f7b529d@surf>
	<87eicx1ykp.fsf@deeprootsystems.com>
	<20100913173933.5d0a6392@surf>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:47974 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752250Ab0IMQZo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Sep 2010 12:25:44 -0400
Received: by qwh6 with SMTP id 6so3644325qwh.19
        for <linux-omap@vger.kernel.org>; Mon, 13 Sep 2010 09:25:44 -0700 (PDT)
In-Reply-To: <20100913173933.5d0a6392@surf>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> I have zero knowledge of DSS, but shouldn't the kernel be able to
> suspend properly even if the DSS driver is disabled ? But maybe it's
> too complicated to have the DSS init sequence required to allow the
> system to hit RET outside the DSS driver. Thoughts ?

I'm not sure if it's supposed to work from reset state but there are
chances DSS is left running by your bootloader.
