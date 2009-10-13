From: Gary Thomas <gary@mlbassoc.com>
Subject: Re: DSS2 frame buffer problem
Date: Tue, 13 Oct 2009 07:27:58 -0600
Message-ID: <4AD4805E.10808@mlbassoc.com>
References: <4AD478CB.2040302@mlbassoc.com> <1255438791.27268.42.camel@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hermes.mlbassoc.com ([76.76.67.137]:54337 "EHLO
	mail.chez-thomas.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752119AbZJMN2f (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Oct 2009 09:28:35 -0400
In-Reply-To: <1255438791.27268.42.camel@tubuntu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com
Cc: OMAP Linux discussion <linux-omap@vger.kernel.org>

On 10/13/2009 06:59 AM, Tomi Valkeinen wrote:
> On Tue, 2009-10-13 at 14:55 +0200, ext Gary Thomas wrote:
>> I have a new board that I'd like to run a frame buffer 800x600x24
>> When I boot, I get this error:
>>     omapfb: failed to allocate framebuffer
>>
>> This board is derived from a board I'm already running DSS2 at
>> 800x600x16 on.
>>
>> What do I need to change to get this to work?
>
> Most likely you need to allocate more VRAM with vram boot option, in
> board file or kernel config option (CONFIG_OMAP2_VRAM_SIZE).

Thanks, that was it.

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
