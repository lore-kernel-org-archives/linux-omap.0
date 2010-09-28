From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 11/13 v3] serial: Add OMAP high-speed UART driver
Date: Tue, 28 Sep 2010 08:19:43 -0700
Message-ID: <871v8dki9c.fsf@deeprootsystems.com>
References: <43868.10.24.255.17.1285599049.squirrel@dbdmail.itg.ti.com>
	<87bp7ilu4f.fsf@deeprootsystems.com>
	<20100928075249.091ea0b2@linux.intel.com>
	<20100928074720.GA12778@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:54712 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754169Ab0I1PTs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Sep 2010 11:19:48 -0400
In-Reply-To: <20100928074720.GA12778@suse.de> (Greg KH's message of "Tue, 28
	Sep 2010 00:47:20 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: Alan Cox <alan@linux.intel.com>, "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Tony Lindgren <tony@atomide.com>

Greg KH <gregkh@suse.de> writes:

> On Tue, Sep 28, 2010 at 07:52:49AM +0100, Alan Cox wrote:
>> On Mon, 27 Sep 2010 15:05:52 -0700
>> Kevin Hilman <khilman@deeprootsystems.com> wrote:
>> 
>> > "Govindraj.R" <govindraj.raja@ti.com> writes:
>> > 
>> > > This patch adds driver support for OMAP2/3/4 high speed UART.
>> > 
>> > Cc'ing Greg KH and Alan Cox for review of the the new serial driver in
>> > this series.
>> > 
>> > Greg/Alan, this has been on linux-serial several times now with review
>> > mostly from OMAP folks.  If this looks OK from your side, with your
>> > ack(s) we can merge via the OMAP tree with the rest of the series
>> > which is a major reorg/cleanup of the OMAP platform init for serial
>> > drivers.
>> 
>> Looks fine to me

Alan, I'm assuming this as an Acked-by.  

Thanks for the review.

> Same here, feel free to add:
> 	Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
>
> and add it to the omap tree.

Greg, will merge this series via the OMAP tree.

Thanks,

Kevin
