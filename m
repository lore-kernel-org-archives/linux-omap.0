From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv2 1/8] OMAP: PM: Allowing an early init of pm debugfs
 driver.
Date: Tue, 24 Aug 2010 15:21:43 -0700
Message-ID: <1282688503.11841.47.camel@localhost>
References: <1281707231-3026-1-git-send-email-thara@ti.com>
	 <1281707231-3026-2-git-send-email-thara@ti.com>
	 <87aaobmzby.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:56938 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932324Ab0HXWVv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Aug 2010 18:21:51 -0400
Received: by eyg5 with SMTP id 5so3821116eyg.19
        for <linux-omap@vger.kernel.org>; Tue, 24 Aug 2010 15:21:49 -0700 (PDT)
In-Reply-To: <87aaobmzby.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, dderrick@ti.com

On Tue, 2010-08-24 at 15:16 -0700, Kevin Hilman wrote:
> Thara Gopinath <thara@ti.com> writes:
> 
> > This patch changes the pm_db_init from arch initcall to a postcore
> > initcall. With arch initcall, it is impossible for pm driver that
> > gets initialized prior to this driver to use one of the
> > pm debug fs entries during its init. Making it a postcore initcall
> > ensures that this drver gets initialized early on before any pm
> > drivers. 
> 
> Instead of tinkering with initcall ordering, how about calling the pm
> debug init from pm.c

ignore this comment, pm.c is a device_initcall, so wont solve your
problem.

But I'd still like to know what PM drivers are being initialized so
early they need this to be a postcore_initcall.

Kevin


