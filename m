From: "Madhusudhan Chikkature" <madhu.cr@ti.com>
Subject: Re: [PATCH]Add 3430 SDP board level support for HSMMC2
Date: Tue, 16 Sep 2008 10:45:08 +0530
Message-ID: <009c01c917bb$322c7f70$LocalHost@wipultra1303>
References: <33259.192.168.10.89.1218608332.squirrel@dbdmail.itg.ti.com> <20080813085433.D5C2F363253@adsl-69-226-248-13.dsl.pltn13.pacbell.net> <00cf01c8fd26$cfc751b0$LocalHost@wipultra1303> <200809081226.18098.david-b@pacbell.net> <20080910235913.GW21163@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39207 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751281AbYIPFP1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Sep 2008 01:15:27 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org


----- Original Message ----- 
From: "Tony Lindgren" <tony@atomide.com>
To: "David Brownell" <david-b@pacbell.net>
Cc: "Madhusudhan Chikkature" <madhu.cr@ti.com>; <linux-omap@vger.kernel.org>
Sent: Thursday, September 11, 2008 5:29 AM
Subject: Re: [PATCH]Add 3430 SDP board level support for HSMMC2


>* David Brownell <david-b@pacbell.net> [080908 12:26]:
>> On Wednesday 13 August 2008, Madhusudhan Chikkature wrote:
>> > > A better way to do this would be to let the boards say exactly
>> > > what the hardware configuration is, rather than requiring all
>> > > OMAP3 boards to be set up exactly like the SDP...
>> >
>> > I think the initial version was written specific to SDP. Later
>> > on it was changed to hsmmc.c and the platforms which required
>> > simillar setup as SDP started using it.
>> 
>> Right ...
>> 
>> 
>> > Now, if support for a new board is required which is unlike SDP a  
>> > new file can still be added for that perticular board, right?
>> 
>> Each board already gets a board-XYZ.c file.  So the clean way
>> to do this is to have that file set up its hsmmc config ... NOT
>> to clone versions of hsmmc.c for each board!
> 
> Madhu, are you planning to abstract hsmmc.c further so various boards
> can use it?
Tony, Sorry for the delayed response on this. What level of abstraction are we considering here?
Are we looking at abstracting out the power stuff (T2 LDO stuff) like the way H4 MMC board file uses
menelaus driver? What is expected?

Regards,
Madhu
> 
> Tony
> 
>
