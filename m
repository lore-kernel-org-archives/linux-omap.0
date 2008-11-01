From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: [PATCH 3/4] HSMMC: Add support for the second controller
Date: Fri, 31 Oct 2008 19:50:44 -0700
Message-ID: <5e088bd90810311950y5060e438n21f931474522571@mail.gmail.com>
References: <1225418657-31775-1-git-send-email-tony@atomide.com>
	 <200810310300.24515.david-b@pacbell.net>
	 <5e088bd90810311635p26bdd8b9n3e7429bac29bd82c@mail.gmail.com>
	 <200810311736.45168.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.171]:33704 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751561AbYKACup (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 31 Oct 2008 22:50:45 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1534656wfd.4
        for <linux-omap@vger.kernel.org>; Fri, 31 Oct 2008 19:50:44 -0700 (PDT)
In-Reply-To: <200810311736.45168.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Fri, Oct 31, 2008 at 5:36 PM, David Brownell <david-b@pacbell.net> wrote:
> On Friday 31 October 2008, Steve Sakoman wrote:
>> TI claims that the 1.0.2 release of the 35XX EVM software will support
>> the libertas_sdio driver via the EVM's mmc slot.  However, I don't see
>> that version of the software yet on the TI site, and my guess is that
>> it will be using the internal TI kernel and not linux-omap.
>
> Darn...
>
> So while Tony's updates will enable root-on-MMC (vs just ramfs)
> Overo won't yet have network links except over bluetooth.
>
> Until the twl4030 USB transceiver driver goes to mainline,
> at which point usb network links will work.  :)

Hmm . . . my network dongles (both ethernet and wifi) work just fine
on musb now (using 2.6.27-omap1)

Steve
