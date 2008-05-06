From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: public git l2 cache off.
Date: Tue, 06 May 2008 20:13:44 +0200
Message-ID: <48209FD8.6050709@googlemail.com>
References: <1209575641-25613-1-git-send-email-tony@atomide.com> <20080505131403.93d0a64d.jarkko.nikula@nokia.com> <3B6D69C3A9EBCA4BA5DA60D9130274290439AAD8@dlee13.ent.ti.com> <A9503EED-55EA-4656-AABD-A6DA28F717DA@student.utwente.nl> <3B6D69C3A9EBCA4BA5DA60D9130274290439AD2F@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:36950 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751293AbYEFSMd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 May 2008 14:12:33 -0400
Received: by ug-out-1314.google.com with SMTP id h2so400847ugf.16
        for <linux-omap@vger.kernel.org>; Tue, 06 May 2008 11:12:31 -0700 (PDT)
In-Reply-To: <3B6D69C3A9EBCA4BA5DA60D9130274290439AD2F@dlee13.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Koen Kooi <k.kooi@student.utwente.nl>, linux-omap@vger.kernel.org

Woodruff, Richard wrote:
>>Enabling L2 cache was removed from proc-v7.S since was cortex specific
>>instead of armv7 specific and u-boot explicitly turns of L2 before
>>booting into linux. I made a reverse patch, but my omap3 board doesn't
>>boot if I use it:
> 
> 
> Our 2.6.24 kernel does something close and boots fine on OMAP3-SDP and Labrador boards.  Which platform did you try on?

I think we are talking about BeagleBoard here.

Dirk

> I'll try the latest from here on SDP with this and see if it works.  There is also a difference in CR handling.  I had submitted long back a fix to Russell but let it get by me as I didn't have the time to fix per his comments.  I think our version was more correct then the one in place but was still lacking a bit.
> 
> [*] It seems possible you could have an issue depending on what your boot loader is or isn't doing for you.
> 
> Regards,
> Richard W.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

