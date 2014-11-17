From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH v12 11/15] arm: omap1: Migrate debug_ll macros to use
 8250.S
Date: Mon, 17 Nov 2014 14:24:43 +0000
Message-ID: <546A052B.5050100@linaro.org>
References: <1414148076-12685-1-git-send-email-daniel.thompson@linaro.org> <1414148076-12685-12-git-send-email-daniel.thompson@linaro.org> <20141116002956.GA13220@fuloong-minipc.musicnaut.iki.fi> <5469BAD8.3090006@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54]:64005 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751772AbaKQOYv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Nov 2014 09:24:51 -0500
Received: by mail-wg0-f54.google.com with SMTP id y10so3521698wgg.27
        for <linux-omap@vger.kernel.org>; Mon, 17 Nov 2014 06:24:50 -0800 (PST)
In-Reply-To: <5469BAD8.3090006@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, spear-devel@list.st.com, Arnd Bergmann <arnd@arndb.de>, Paul Bolle <pebolle@tiscali.nl>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, patches@linaro.org, linaro-kernel@lists.linaro.org, Tony Lindgren <tony@atomide.com>, Arnd Bergmann <arnd.bergmann@linaro.org>, linux-omap@vger.kernel.org

On 17/11/14 09:07, Daniel Thompson wrote:
> On 16/11/14 00:29, Aaro Koskinen wrote:
>> Hi,
>>
>> On Fri, Oct 24, 2014 at 11:54:32AM +0100, Daniel Thompson wrote:
>>> +	config DEBUG_OMAP1UART1
>>> +		bool "Kernel low-level debugging via OMAP1 UART1"
>>> +		depends on ARCH_OMAP1
>>> +		select DEBUG_UART_8250
>>> +		help
>>> +		  Say Y here if you want kernel low-level debugging support
>>> +		  on OMAP1 based platforms (expect OMAP730) on the UART1.
>> [...]
>>> +		  on OMAP1 based platforms (expect OMAP730) on the UART2.
>> [...]
>>> +		  on OMAP1 based platforms (expect OMAP730) on the UART3.
>>                                             ^^^^^^
>>
>> Spelling again wrong. I think it was already corrected in v11?
> 
> Sorry and, yes, you're right this was corrected in v11.
> 
> I was travelling when I posted v11 so I guess I must have forgot to pull
> the right branches to my main machine. I will dig it and diff shortly to
> make sure I didn't miss anything else.

Just as well I did the diff. v12 was derived from v9 rather than v11 as
it should have been, so apologies to Aaro and Paul Bolle for dropping
changes they asked for.

I will try to change how I keep track of things when I go travelling in
future...


Daniel.
