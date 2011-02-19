From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v8 3/3] OMAP4:keypad: PM runtime
Date: Fri, 18 Feb 2011 21:31:11 -0800
Message-ID: <20110219053111.GA6991@core.coreip.homeip.net>
References: <1293429106-16543-1-git-send-email-shubhrajyoti@ti.com>
 <1293429106-16543-2-git-send-email-shubhrajyoti@ti.com>
 <1293429106-16543-3-git-send-email-shubhrajyoti@ti.com>
 <1293429106-16543-4-git-send-email-shubhrajyoti@ti.com>
 <4D50FF42.1070401@ti.com>
 <4D5F33E3.7000501@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:52924 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750849Ab1BSFbS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 19 Feb 2011 00:31:18 -0500
Content-Disposition: inline
In-Reply-To: <4D5F33E3.7000501@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti <shubhrajyoti@ti.com>
Cc: linux-input@vger.kernel.org, Abraham Arce <x0066660@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org

Hi Shubhrajyoti,

On Sat, Feb 19, 2011 at 08:37:15AM +0530, Shubhrajyoti wrote:
> Hello Dmitry,
> If there are no further comments.
> Can it be queued?

I normally try not to merge board code leaving it to arch owner. Can we
at least get arch/board maintainer ACKs on this?

Also, I am wondering, what is the utility of this patch? Without it,
as far as I understand, runtime PM is disabled for the device. With the
patch we enable runtime PM but immediately bump up usage count, thus
ensuring that the device is always powered on. So what changed? Or am I
missing something?

Thanks.

-- 
Dmitry
