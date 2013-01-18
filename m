From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: gpios reset when kernel starts
Date: Fri, 18 Jan 2013 21:54:40 +0100
Message-ID: <87txqegqjz.fsf@dell.be.48ers.dk>
References: <CAOd_LFy8b_=eqqraKHz7Kc+o3wFTH-e8G=74d9+ec7L2B28crA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ea0-f171.google.com ([209.85.215.171]:40328 "EHLO
	mail-ea0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752459Ab3ARUyp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Jan 2013 15:54:45 -0500
Received: by mail-ea0-f171.google.com with SMTP id c13so1020051eaa.2
        for <linux-omap@vger.kernel.org>; Fri, 18 Jan 2013 12:54:44 -0800 (PST)
In-Reply-To: <CAOd_LFy8b_=eqqraKHz7Kc+o3wFTH-e8G=74d9+ec7L2B28crA@mail.gmail.com>
	(Cliff Brake's message of "Fri, 18 Jan 2013 15:08:01 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Cliff Brake <cliff.brake@gmail.com>
Cc: linux-omap@vger.kernel.org

>>>>> "Cliff" == Cliff Brake <cliff.brake@gmail.com> writes:

Hi,

 Cliff> I'm working with the 3.0 kernel on a 3730.  It appears that when
 Cliff> I set a GPIO to output and set it high in the bootloader, this
 Cliff> gets reset when the kernel starts.  Is this expected, and is
 Cliff> there any workaround to have this not happen?  The alternate
 Cliff> functions seem to be sticking when configured in the bootloader.

 Cliff> Its possible that something in the kernel is taking control of
 Cliff> the signal, but it seems ulikely as I've tried two different
 Cliff> unrelated GPIOs with the same result.

It's because the kernel resets (almost) all the internal IP blocks
during boot to get them in a consistent state. I asked about the same
thing recently:

http://thread.gmane.org/gmane.linux.ports.arm.omap/91243/

-- 
Bye, Peter Korsgaard
