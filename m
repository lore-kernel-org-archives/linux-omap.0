From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: linux-omap vs N810
Date: Mon, 28 Apr 2008 09:26:55 +0300
Message-ID: <20080428092655.a5e285a9.jarkko.nikula@nokia.com>
References: <55288.89.77.111.170.1209333669.squirrel@mail.gen2.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:57530 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751624AbYD1G0e (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Apr 2008 02:26:34 -0400
In-Reply-To: <55288.89.77.111.170.1209333669.squirrel@mail.gen2.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext astralstorm@gen2.org" <astralstorm@gen2.org>
Cc: linux-omap@vger.kernel.org

On Mon, 28 Apr 2008 00:01:09 +0200 (CEST)
"ext astralstorm@gen2.org" <astralstorm@gen2.org> wrote:

> Hello,
> I'm having a major problem running linux-omap kernel on Nokia N810.
> After correct build and flashing (tested by the use of self-built
> patched Nokia kernel) the device seems to hang before framebuffer
> initialization, then is rebooted by the watchdog. Manual FB update is
> disabled, I've checked the configuration in many possible ways.
> 
> I'd like to hear about possible causes of that.
> 
Most probably reason is development time machine id 5555 passed by the
bootloader where linux-omap is using official id of 1548. This will be
corrected in our future SW releases.

Try to "hack" change N810 machine id in arch/arm/tools/mach-types from
1548 to 5555.


Jarkko
