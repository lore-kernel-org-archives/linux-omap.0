From: Ameya Palande <ameya.palande@nokia.com>
Subject: Re: CONFIG_CPU_IDLE broken for N900
Date: Tue, 10 Aug 2010 15:35:18 +0300
Message-ID: <1281443718.17541.29.camel@chotu>
References: <1281442891.17541.26.camel@chotu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:26649 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757403Ab0HJMf2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Aug 2010 08:35:28 -0400
In-Reply-To: <1281442891.17541.26.camel@chotu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Tero Kristo <tero.kristo@nokia.com>

On Tue, 2010-08-10 at 14:21 +0200, Palande Ameya (Nokia-MS/Helsinki)
wrote:
> Hi,
> 
> When I enable CONFIG_CPU_IDLE and boot kernel, it hangs around the point
> when it switches to user space. I am able to reproduce this for 2.6.35
> on linux-omap and linux-2.6 trees.
> 
> Has anyone else noticed the same thing for omap3 based boards?

Broken on linux-omap-pm as well!

Cheers,
Ameya.

