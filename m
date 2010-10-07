From: Mark Grosen <mgrosen@ti.com>
Subject: Re: Code Composer Studio for TI OMAP 35xx
Date: Thu, 07 Oct 2010 11:20:10 -0700
Message-ID: <4CAE0F5A.4030904@ti.com>
References: <C88249BF-577A-47DE-BFF2-CE9223DD36D6@mac.com> <33A4245E-B2C3-47F3-8276-3E9F155FE1C5@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41208 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754465Ab0JGSUN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Oct 2010 14:20:13 -0400
In-Reply-To: <33A4245E-B2C3-47F3-8276-3E9F155FE1C5@mac.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Elvis Dowson <elvis.dowson@mac.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On 10/7/2010 8:22 AM, Elvis Dowson wrote:
> On Oct 7, 2010, at 7:19 PM, Elvis Dowson wrote:
>
>> Hi,
>>         Is there a version of CCS that will run on linux and work for the TI OMAP 35xx?  I primarily want to do target based debugging of the linux-omap kernel, using an Eclipse or similar IDE type front end with kgdb.
>
> BTW, I downloaded CCS4, but it only runs on windows.
>
> http://focus.ti.com/docs/toolsw/folders/print/ccstudio.html
>
> I don't want to use windows for linux kernel debugging :-) I came across a wiki that was under construction that hinted at a CCS5 that runs on Linux.
>
> Is it possible to try that out?

You can get the Linux version of CCS here:
http://processors.wiki.ti.com/index.php/Category:Code_Composer_Studio_v5

A wiki article on using JTAG to debug Linux kernel is here:
http://processors.wiki.ti.com/index.php/Linux_Debug_in_CCSv5

Note that you really do not need the TI CCS version of Eclipse to use 
kgdb - you could just grab the generic version from eclipse.org

Mark


