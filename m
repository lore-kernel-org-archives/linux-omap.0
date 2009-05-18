From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP: Remove IRQ hardcoding from serial.c
Date: Mon, 18 May 2009 14:45:40 -0700
Message-ID: <20090518214539.GT19742@atomide.com>
References: <1241681366-21094-1-git-send-email-santosh.shilimkar@ti.com> <20090507204653.GD5593@atomide.com> <EAF47CD23C76F840A9E7FCE10091EFAB02B4688409@dbde02.ent.ti.com> <20090508151755.GI5593@atomide.com> <EAF47CD23C76F840A9E7FCE10091EFAB02B48440F9@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:55600 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753647AbZERVpm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 May 2009 17:45:42 -0400
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02B48440F9@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Shilimkar, Santosh <santosh.shilimkar@ti.com> [090513 07:53]:
> Tony,
> Any comments on this patch.
> http://patchwork.kernel.org/patch/19161/

We should just set the interrupts etc dynamically using the
cpu_is_omapXXXX() functions.

Regards,

Tony
