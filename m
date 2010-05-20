From: Timo Kokkonen <timo.t.kokkonen@nokia.com>
Subject: Re: [PATCH] twl4030_wdt: Disable watchdog while probing
Date: Thu, 20 May 2010 12:12:10 +0300
Message-ID: <1274346730.6093.4.camel@sarki.nmp.nokia.com>
References: <7fcfe2bbdbad2e7c330c219fa1e27497a5fd0f89.1274094577.git.ameya.palande@nokia.com>
	 <1274333988.30871.17.camel@sarki.nmp.nokia.com>
	 <20100520074630.GN4008@infomag.iguana.be>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:33844 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754193Ab0ETJMZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 May 2010 05:12:25 -0400
In-Reply-To: <20100520074630.GN4008@infomag.iguana.be>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Wim Van Sebroeck <wim@iguana.be>
Cc: "Palande Ameya (Nokia-D/Helsinki)" <ameya.palande@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Wim,

On Thu, 2010-05-20 at 09:46 +0200, ext Wim Van Sebroeck wrote:
> => bottom line: this patch adds the correct default behaviour and should
> not be changed. Feel free to add the module-parameter to keep the watchog
> running at start.

Thanks for the detailed explanation. I was worried about the kernel and
the early user space booting being in the "grey area" where errors might
occurr which can cause the device (I'm talking about embedded devices
here) to go into failed state without watchdog being able to reboot the
machinge. But as you said, this can be fixed by adding additional module
parameters that override this default behavior, so I have no further
objections for this patch.

Acked-By: Timo Kokkonen <timo.t.kokkonen@nokia.com>


