From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: Re: [PATCH 8/9] dspbridge: add map support for big buffers
Date: Thu, 26 Aug 2010 15:55:02 +0900
Message-ID: <20100826155416J.fujita.tomonori@lab.ntt.co.jp>
References: <1277943660-4112-7-git-send-email-x0095840@ti.com>
	<1277943660-4112-8-git-send-email-x0095840@ti.com>
	<1277943660-4112-9-git-send-email-x0095840@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from sh.osrg.net ([192.16.179.4]:52244 "EHLO sh.osrg.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750874Ab0HZGzQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Aug 2010 02:55:16 -0400
In-Reply-To: <1277943660-4112-9-git-send-email-x0095840@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: x0095840@ti.com
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, ohad@wizery.com, hiroshi.doyu@nokia.com, ameya.palande@nokia.com, felipe.contreras@nokia.com

On Wed, 30 Jun 2010 19:20:59 -0500
Fernando Guzman Lugo <x0095840@ti.com> wrote:

> due to a restriction in scatter gather lists, it can
> not be created a list for a buffer bigger than 1MB.
> This patch is spliting big mappings into 1MB mappings.

I don't read the whole thread but the above description is incorrect.

Why can't you use scatter gather chaining? You can create a scatter
list for a buffer larger than 1MB.
