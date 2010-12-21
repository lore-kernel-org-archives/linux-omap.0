From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH 6/6] omap3: beagle: get rid of unused omap2/omap4
 specific code/data
Date: Tue, 21 Dec 2010 22:57:43 +0100
Message-ID: <20101221225743.0953365a@surf>
References: <1292955604-8809-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1292955604-8809-7-git-send-email-thomas.petazzoni@free-electrons.com>
	<AANLkTim34_B_S--yYrdy+WOFH6_PL=t8P5xixwp36cwx@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:34392 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076Ab0LUV5v (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Dec 2010 16:57:51 -0500
In-Reply-To: <AANLkTim34_B_S--yYrdy+WOFH6_PL=t8P5xixwp36cwx@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: linux-omap@vger.kernel.org, Thomas Petazzoni <t-petazzoni@ti.com>

On Tue, 21 Dec 2010 13:15:23 -0600
"Menon, Nishanth" <nm@ti.com> wrote:

> Potentially a dumb idea: given that silicon wont change after boot,
> cant we make it independent of the board file - I mean some common
> file with cpu_is check and free of conditional sections accordingly?

Yes, definitely. The current location in the BeagleBoard board code was
just to make a quick test. It belongs somewhere in the CPU detection
code.

Thanks for your feedback!

Regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
