From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: OMAP4 naming conventions
Date: Tue, 12 May 2009 09:47:02 -0700
Message-ID: <87eiuuclq1.fsf@deeprootsystems.com>
References: <87tz3qe5ay.fsf@deeprootsystems.com>
	<alpine.DEB.2.00.0905120909370.17514@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.169]:29308 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752524AbZELQrE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 May 2009 12:47:04 -0400
Received: by wf-out-1314.google.com with SMTP id 26so64679wfd.4
        for <linux-omap@vger.kernel.org>; Tue, 12 May 2009 09:47:05 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.0905120909370.17514@utopia.booyaka.com> (Paul Walmsley's message of "Tue\, 12 May 2009 09\:24\:30 -0600 \(MDT\)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

Paul Walmsley <paul@pwsan.com> writes:

> On Tue, 12 May 2009, Kevin Hilman wrote:
>
>> As the OMAP4 patches are coming in, there seems to be a bit of variety
>> in the naming of functions/macros/variables etc.
>> 
>> Could I propose that we just use omap4_* and OMAP4_* instead of
>> OMAP44XX_* or OMAP4XXXX_* etc.
>> 
>> I know that OMAP2 and OMAP3 have a variety of forms here too, but
>> those should probably be cleaned up eventually too.
>> 
>> With proper runtime revision detecting, IMO, we should only really
>> have the OMAP4 prefix, and leave the sub revision handling to runtime
>> code.
>> 
>> Thoughts?
>
> Here are some questions that we should figure out answers to before 
> deciding:
>
> How should macros be named that only apply to specific OMAP4 chips (i.e., 
> what happens if TI repeats a OMAP2420 to 2430 transition)?

I would propose a convention something like:

- OMAP4_* - applies to all OMAP4 chips
- OMAP4xyz_* - applies to the specific 4xyz rev

> How should macros be handled that are only applicable to later ES
> levels?  Tagging ES levels in macros has caught many bugs in the
> OMAP2/3 code.

Since the ES revs would be specific to particular 'xyz' rev, The above
could be extended to use something like OMAP4xyzESn_*

Kevin

