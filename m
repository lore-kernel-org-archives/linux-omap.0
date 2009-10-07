From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: Linux omap blocked on boot
Date: Wed, 7 Oct 2009 23:28:01 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030A332A59@dbde02.ent.ti.com>
References: <65168.192.168.10.89.1253788033.squirrel@dbdmail.itg.ti.com>
 <87ljjnl2ma.fsf@deeprootsystems.com> <4ACCB4EA.1020904@disca.upv.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54068 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753833AbZJGR7j convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Oct 2009 13:59:39 -0400
In-Reply-To: <4ACCB4EA.1020904@disca.upv.es>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Alberto J. Perez" <aperez@disca.upv.es>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

(Hit send too soon)

> Hi all!
> 
> I'm recompiling the linux-omap-2.6/origin/pm branch and every time I get 
> the boot process stalled after kernel image decompression.
> 
> - With the linux-omap-2.6/origin/2.6.30 branch I have no problems.
> - I've tried with 2008q3-72 & 2009q1-203 arm compilers.
> 
> I attach the .config I used.
> 
> Some one have or had the same problem?
> 
> Thanks in advance,
> 
> Alberto.
> 

Alberto,

>From the .config you attached, it looks like this is the Gumstix
Overo, right?

Could you try enabling CONFIG_DEBUG_LL and patch kernel/printk.c
and see if there is a crash at bootup? You can find the patch in the
omap-debug branch (See [1] for the notification)

Regards,
Anand

[1] http://marc.info/?l=linux-omap&m=125416465315169&w=2