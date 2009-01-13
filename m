From: Adrian Hunter <ext-adrian.hunter@nokia.com>
Subject: Re: [PATCH 2/2] OMAP: HSMMC: Fix response type for busy after response
Date: Tue, 13 Jan 2009 16:19:48 +0200
Message-ID: <496CA304.9000802@nokia.com>
References: <20090113133827.29474.92645.sendpatchset@ahunter-laptop>	<20090113133841.29474.15852.sendpatchset@ahunter-laptop> <20090113144952.3f8cbec8@mjolnir.drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:46886 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753111AbZAMOII (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Jan 2009 09:08:08 -0500
In-Reply-To: <20090113144952.3f8cbec8@mjolnir.drzeus.cx>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pierre Ossman <drzeus-mmc@drzeus.cx>
Cc: Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, lkml <linux-kernel@vger.kernel.org>, linux-omap Mailing List <linux-omap@vger.kernel.org>, "Lavinen Jarkko (Nokia-M/Helsinki)" <jarkko.lavinen@nokia.com>, Madhusudhan Chikkature <madhu.cr@ti.com>

Pierre Ossman wrote:
> On Tue, 13 Jan 2009 15:38:41 +0200
> Adrian Hunter <ext-adrian.hunter@nokia.com> wrote:
> 
>> This also fixes the hidden problem that the controller
>> was turning off the clock to the card while the card
>> was busy - the clock was then switched on for the
>> duration of each Send Status command used for polling,
>> which is why writes did not lock up altogether.
>> i.e. really dysfunctional.
> 
> Does the driver only keep the clock running as long as there is an
> ongoing request? That kind of policy should really be handled in the
> core where we have more information and can control it better. E.g. some
> cards need the clock to finish up internal housekeeping so we need to
> delay things for those.
> 
> Rgds

Unfortunately it seems to be something the controller does by itself,
beyond the control of the driver.  Added Jarkko Lavinen and 
Madhusudhan Chikkature to CC, maybe they can correct me.

If it obeys the standard, it should give an additional 8 clock cycles.
