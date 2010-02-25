From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv5] OMAP3: Serial: Improved sleep logic
Date: Thu, 25 Feb 2010 07:20:34 -0800
Message-ID: <87k4u1mjel.fsf@deeprootsystems.com>
References: <1266421892-1021-1-git-send-email-tero.kristo@nokia.com>
	<877hq2sjpy.fsf@deeprootsystems.com>
	<1F18D6510CF0474A8C9500565A7E41A224BF580B19@NOK-EUMSG-02.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f177.google.com ([209.85.223.177]:62847 "EHLO
	mail-iw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753492Ab0BYPUi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Feb 2010 10:20:38 -0500
Received: by iwn7 with SMTP id 7so5219320iwn.4
        for <linux-omap@vger.kernel.org>; Thu, 25 Feb 2010 07:20:37 -0800 (PST)
In-Reply-To: <1F18D6510CF0474A8C9500565A7E41A224BF580B19@NOK-EUMSG-02.mgdnok.nokia.com> (Tero Kristo's message of "Thu\, 25 Feb 2010 09\:43\:51 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero.Kristo@nokia.com
Cc: linux-omap@vger.kernel.org

<Tero.Kristo@nokia.com> writes:

[...]

>>Here's my hunch as to what's happening:
>>
>>I think the problem is a deadlock in getrawmonotonic().  Nested calls
>>here will deadlock due to the xtime_lock being held.
>
> Looking at the seqlock code, I think a seqlock reader can "hang" only in a case where someone is constantly writing the seqlock. And, as we are inside interrupt, this should not be possible.
>
>>When updading the timeout, sleep_timeout_store() does a
>>getrawmonotonic() to update the expiry time.  While this happening,
>>the UART interrupt could fire, causing an omap_uart_block_sleep()
>>which would also getrawmonotonic() and deadlock in interrupt mode.
>
> It does not really explain why it hangs after the 5 second period though, as the device has called getrawmonotonic several times by this already. I have not seen this kind of behavior in my testing, even while fiddling with the sleep_timeout_store().

minor clarification...

For me the hang is not after the 5 second timeout.  For me it happens
as soon as I write a non-zero value to
/sys/devices/.../serial8250.2/sleep_timeout.

Kevin
