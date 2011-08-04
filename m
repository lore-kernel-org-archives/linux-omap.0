From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] Revert "i2c-omap: fix static suspend vs. runtime suspend"
Date: Thu, 04 Aug 2011 07:39:11 -0700
Message-ID: <87sjph44xc.fsf@ti.com>
References: <1312394379-21516-1-git-send-email-khilman@ti.com>
	<20110803223802.GC4036@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:49768 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753337Ab1HDOjS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Aug 2011 10:39:18 -0400
In-Reply-To: <20110803223802.GC4036@legolas.emea.dhcp.ti.com> (Felipe Balbi's
	message of "Thu, 4 Aug 2011 01:38:02 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Ben Dooks <ben-linux@fluff.org>, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, Shubhrajyoti D <shubhrajyoti@ti.com>

Felipe Balbi <balbi@ti.com> writes:

> On Wed, Aug 03, 2011 at 10:59:39AM -0700, Kevin Hilman wrote:
>> This reverts commit adf6e07922255937c8bfeea777d19502b4c9a2be.
>> 
>> Remove system PM methods which can race with runtime PM methods.
>> 
>> Also, as of v3.1, the PM domain level code for OMAP handles device
>> power state transistions automatically for devices, so calling them
>> from
>
> from where ? I didn't quite get this ;-)

heh, looks like i got distracted before finishing the changelog.   Will
respin.

Thanks,

Kevin
