From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH v3 1/3] omap: opp: add OMAP3 OPP table data and common
 init
Date: Wed, 17 Nov 2010 09:19:16 +0100
Message-ID: <20101117091916.48282778@surf>
References: <1289849261-29767-2-git-send-email-nm@ti.com>
	<20101116122128.5c6cc050@surf>
	<4CE2710A.3010804@ti.com>
	<20101116134220.1bb818c0@surf>
	<4CE2A1DA.3020203@ti.com>
	<20101116165039.7e6b8e16@surf>
	<8762vxjlbs.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:45436 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934568Ab0KQITY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Nov 2010 03:19:24 -0500
In-Reply-To: <8762vxjlbs.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Nishanth Menon <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Tony <tony@atomide.com>

On Tue, 16 Nov 2010 08:16:07 -0800
Kevin Hilman <khilman@deeprootsystems.com> wrote:

> Yes, I'm not a big fan of the init function called multiple times
> either, but I really want to minimize what board files have to do.
> 
> Historically, we tend to add all the init functions to every board
> file, and this is getting cumbersome to understand and maintain.
> What we need is for common code to take care of sensible defaults for
> all boards, and then only boards with non-default behavior have to
> have custom code.

The other way is to have the board code "register" its customization
into the OPP subsystem, and then when the OPP subsystem is initialized,
it takes those customizations into account. But in that specific case,
it's not clear how those customizations could easily be expressed, so
maybe that multiple call strategy is the simplest solution.

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
