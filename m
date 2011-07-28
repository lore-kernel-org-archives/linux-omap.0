From: Gary Thomas <gary@mlbassoc.com>
Subject: Re: [Q] No message from Kernel (Howto start debug?)
Date: Thu, 28 Jul 2011 07:25:23 -0600
Message-ID: <4E316343.40100@mlbassoc.com>
References: <CAACX+R297j07GXRtLBCFuSyHTmk4sMXQiUt8YwN7KH6A8251jA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hermes.mlbassoc.com ([64.234.241.98]:48226 "EHLO
	mail.chez-thomas.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753005Ab1G1Naj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Jul 2011 09:30:39 -0400
In-Reply-To: <CAACX+R297j07GXRtLBCFuSyHTmk4sMXQiUt8YwN7KH6A8251jA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arno Steffen <arno.steffen@googlemail.com>
Cc: linux-omap@vger.kernel.org

On 2011-07-28 07:15, Arno Steffen wrote:
> Maybe you are so kind to give me a hint:
>
> Try to migrate from Kernel 33 to 37. Currently I don't see any message after
>
>    Verifying Checksum ... OK
>     Loading Kernel Image ... OK
> OK
>
> Starting kernel ...
>
>> From what I understand kernel starts with start_kernel()).
> What is best way to find out which part is failing? At which point I
> do a printk to see what's going on, or at least set a GPIO Pin of the
> processor?
> How to debug without any external tools like JTAG.

Start with your bootargs - likely ttyS2 became ttyO2

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
