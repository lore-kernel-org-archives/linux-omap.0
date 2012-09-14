From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] RTC: TWL: ensure all interrupts are disabled during
 probe
Date: Fri, 14 Sep 2012 12:20:22 -0700
Message-ID: <20120914122022.f56cd21d.akpm@linux-foundation.org>
References: <1347569157-19262-1-git-send-email-khilman@deeprootsystems.com>
	<CAOSpxdbGZFFShcS=_BZ78tAB3A5esPxY2WqNaGA9VXsBj8sP7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:33030 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755976Ab2INTUX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Sep 2012 15:20:23 -0400
In-Reply-To: <CAOSpxdbGZFFShcS=_BZ78tAB3A5esPxY2WqNaGA9VXsBj8sP7g@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <steve@sakoman.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Felipe Balbi <balbi@ti.com>, Alessandro Zummo <a.zummo@towertech.it>

On Fri, 14 Sep 2012 08:33:42 -0700
Steve Sakoman <steve@sakoman.com> wrote:

> Tested-by: Steve Sakoman <steve@sakoman.com>

Thanks.

Given the tested-by's that are rolling in, I will assume that people
are hitting this problem in 3.5 and perhaps earlier kernels, so I
scheduled the fix for 3.6, with a -stable backport.

I might have been wrong about that - in future, please do make these
issues clear in the patch changelog?

