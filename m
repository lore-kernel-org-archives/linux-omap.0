From: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Subject: Re: No OMAP PM code on the PM branch???
Date: Sat, 02 May 2009 13:31:24 +0400
Message-ID: <49FC12EC.7030609@gmail.com>
References: <1241203145.18100.370.camel@blackhole>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from postoffice.embeddedalley.com ([65.114.89.228]:55351 "HELO
	postoffice.embeddedalley.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752322AbZEBJbZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 2 May 2009 05:31:25 -0400
In-Reply-To: <1241203145.18100.370.camel@blackhole>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Barada <peterb@logicpd.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

Peter,

Peter Barada wrote:
> I'm looking through Kevin's PM branch, and I've done a quick-port of
> 2.6.30-rc1 to Logic's OMAP3530 LV SOM starting with the rk21 board code,
> and "echo mem > /sys/power/state" does nothing.  Worse,
> "cat /sys/power/state" doesn't show anything.
>
> This is due to no code calling suspend_set_ops() which used to be in
> arch/arm/mach-omap2/pm34xx.c - this isn't in either Tony or Kevin's
> current tree.
>
> 1) Am I way off base (i.e. am I missing something obvious here)?
>   
check out Kevin's email "Re: n800 high idle power consumption" on 4/24 
on this list. TBH
I haven't checked pm branch recently so have no idea if re-basing is 
complete and if it
causes the issue you found.

Thanks,
Eugeny

