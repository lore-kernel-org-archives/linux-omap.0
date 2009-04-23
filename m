From: Kalle Valo <kalle.valo@iki.fi>
Subject: Re: n800 build error in clock24xx.c: 'secure_32k_ck' undeclared
Date: Thu, 23 Apr 2009 18:37:24 +0300
Message-ID: <87eivjbcuj.fsf@litku.valot.fi>
References: <873ac7ko2n.fsf@litku.valot.fi>
	<alpine.DEB.2.00.0904201141380.13457@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f163.google.com ([209.85.218.163]:50254 "EHLO
	mail-bw0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751520AbZDWPh3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Apr 2009 11:37:29 -0400
Received: by bwz7 with SMTP id 7so611372bwz.37
        for <linux-omap@vger.kernel.org>; Thu, 23 Apr 2009 08:37:26 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.0904201141380.13457@utopia.booyaka.com> (Paul Walmsley's message of "Mon\, 20 Apr 2009 11\:47\:04 -0600 \(MDT\)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com

Paul Walmsley <paul@pwsan.com> writes:

> Hi Kalle,

Hi Paul,

sorry for a late answer.

> On Fri, 17 Apr 2009, Kalle Valo wrote:
>
>> arch/arm/mach-omap2/clock24xx.h:1801: error: 'secure_32k_ck'
>> undeclared here (not in a function)
>>
>> Any hints?
>
> This is a bug in the version of fa9ef57a1efdd4e7c41a42db71d99b9b69e9b356 I 
> pushed.  The new clock definition in clock24xx.h for "secure_32k_fck" 
> should be for "secure_32k_ck".  Just talked with Tony about this; he's 
> going to re-pull a fixed version of that patch today.

I updated to latest linux-omap (commit 55b1274c). It now compiles and
boots on N800. 

Thank you for fixing this.

-- 
Kalle Valo
