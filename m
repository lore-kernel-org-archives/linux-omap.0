From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH/RFC 2/4] OMAP2: PM debug: remove register dumping
Date: Tue, 31 May 2011 18:40:41 -0700
Message-ID: <87sjrujply.fsf@ti.com>
References: <1306450971-27732-1-git-send-email-khilman@ti.com>
	<1306450971-27732-3-git-send-email-khilman@ti.com>
	<BANLkTikG1yExnfKGH6RsXU99MfTxGgiXww@mail.gmail.com>
	<E8606C3FD412994585953171ED63A9340219136F97@dnce01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:54596 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752515Ab1FABkp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 31 May 2011 21:40:45 -0400
Received: by pwi15 with SMTP id 15so2855886pwi.5
        for <linux-omap@vger.kernel.org>; Tue, 31 May 2011 18:40:44 -0700 (PDT)
In-Reply-To: <E8606C3FD412994585953171ED63A9340219136F97@dnce01.ent.ti.com>
	(Patrick Titiano's message of "Tue, 31 May 2011 10:24:10 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Titiano, Patrick" <p-titiano@ti.com>
Cc: Jean Pihet <jean.pihet@newoldbits.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Patrick,

"Titiano, Patrick" <p-titiano@ti.com> writes:

[...]

>>
>> OK for this change. Is it the intention to use the omapconf tool as
>> the replacement for the regs dump code?
>
> Sorry but omapconf is run from userspace, it cannot be used to dump
> PRCM registers right before and after MPU WFI.
>

Right, taking register snapshots is currently beyond the scope of
omapconf.

However, as I suggested earlier in this thread, if we had a new driver
with read/write interface where register snapshots are saved, I imagine
adopting omapconf to read from such an interface for dumping register
snapshots would be relatively easy, right?  

Kevin

[1] again, I haven't really thought much about this, but something like;
write an address to /dev/foo, then reading 'len' bytes from /dev/foo
would give back the snapshot data (if any) starting from that address.

