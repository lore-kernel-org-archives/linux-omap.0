From: Philip Balister <philip@balister.org>
Subject: Re: Enabling spidev in MCSPI1
Date: Fri, 15 Jan 2010 08:43:52 -0500
Message-ID: <4B507118.9000809@balister.org>
References: <4B4DC3FB.3020702@balister.org> <alpine.DEB.2.00.1001131329330.20437@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.geekisp.com ([216.168.135.169]:27572 "EHLO
	starfish.geekisp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932191Ab0AONn5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Jan 2010 08:43:57 -0500
In-Reply-To: <alpine.DEB.2.00.1001131329330.20437@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 01/13/2010 03:36 PM, Paul Walmsley wrote:
> Hi Philip,
>
> On Wed, 13 Jan 2010, Philip Balister wrote:
>
>> I'm trying to enable spidev on mcspi1, but when I do, the kernel while booting
>> after the kernel is uncompressed. No useful messages are displayed. This is
>> with a current git.
>>
>> I've attached the diff I use to add the spi driver to the board file. (OVero +
>> Summit).
>
> Maybe try enabling early printk support if you haven't already?
>
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg21017.html

I think the early printk stuff was stopping me seeing the message ....

Unfortunately, I found the conflicting driver, the 7846 touchscreen 
driver, and disabled it, so the kernel boots again. (Before I could boot 
with debugging messages enabled)

I suspect the kernel should not crash if two drivers try to claim the 
spi device. If someone is interested, I can reanable the bad 
configuration and try to collect better data.

Philip
