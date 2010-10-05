From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: NOTE: hwmod changes merged to linux-omap master for testing
Date: Tue, 5 Oct 2010 12:06:17 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402DB90D031@dbde02.ent.ti.com>
References: <20101002004821.GN3117@atomide.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E9402DB90C96B@dbde02.ent.ti.com>
	<8762xi3sm1.fsf@deeprootsystems.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E9402DB90CD4F@dbde02.ent.ti.com>
 <87pqvpyco5.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57378 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932094Ab0JEGg0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Oct 2010 02:36:26 -0400
In-Reply-To: <87pqvpyco5.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com] 
> Sent: Tuesday, October 05, 2010 1:05 AM
> To: G, Manjunath Kondaiah
> Cc: Tony Lindgren; linux-omap@vger.kernel.org
> Subject: Re: NOTE: hwmod changes merged to linux-omap master 
> for testing
> 
> "G, Manjunath Kondaiah" <manjugk@ti.com> writes:
...

> > As I mentioned no changes to defconfig and it looks like 
> cpu idle is 
> > disabled and cpu idle wait is enabled in .config after running make 
> > omap2plus_defconfig
> 
> OK, my fault.  I misread your bootlog, and now see that it's 
> the default idle path that is triggering the fault, not CPUidle.
> 
> I tried on my es2.0 panda and see the same thing now, dump below.
> The misc. PM warnings on boot are expected as OMAP4 does not have
> functioning PM support in mainline yet.    The error that crashes is
> somewhat different, but also likely related to PM as it 
> appears to be triggered the upon the first attempt at idle.
> 
> I haven't debugged any further, but you might want to try 
> again with enabling more verbose kernel debugging, specifically:
> 
> CONFIG_DEBUG_BUGVERBOSE=y
> CONFIG_DEBUG_ERRORS=y
> 
> as you shoul hopefully get some more information as to what 
> causes the initial panic.

After enabling above debug options also, I don't see any change in the log.
http://pastebin.com/mf8HvQCX

-Manjunath