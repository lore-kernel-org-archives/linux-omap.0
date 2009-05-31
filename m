From: Andrew de Quincey <adq@lidskialf.net>
Subject: Re: prepatch: work around broken brf6150 PM code
Date: Sun, 31 May 2009 02:47:51 +0100
Message-ID: <20090531024751.67773ihx5dtjmvuo@lidskialf.net>
References: <20090530182513.214244z6d3s8cb9c@lidskialf.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=UTF-8;
	DelSp="Yes";
	format="flowed"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 82-71-49-12.dsl.in-addr.zen.co.uk ([82.71.49.12]:50048 "EHLO
	mail.lidskialf.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752850AbZEaBru convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 30 May 2009 21:47:50 -0400
In-Reply-To: <20090530182513.214244z6d3s8cb9c@lidskialf.net>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andrew de Quincey <adq_dvb@lidskialf.net>
Cc: linux-omap@vger.kernel.org, ville.tervo@nokia.com

Quoting Andrew de Quincey <adq_dvb@lidskialf.net>:

> Hi, this patch took a while to track down. The brf6150.c from the   
> original Nokia n770 kernel source  
> (kernel-source-2.6.16-2.6.16-osso29)  works. However, the brf6150.c  
> that was added to the linux-omap tree on  the 8th feb 2006 (commit  
> 9f43ca7f2eca4de6f145bc1d165df4a415546258)  does not (for this n770  
> anyway :).
>
> In the linux-omap commit, there is a lot of new neat power  
> management  code that uses two GPIOs: one for the host to signal the  
> brf6150 when  to wake up and one for the brf6150 to signal the host  
> to wake up.
>
> The problem is that on the hardware I'm using these GPIOs do not   
> change, so the host never "wakes up", and consequently never  
> schedules  packets to be transferred to the brf6150. I've tested the  
> platform  GPIO library is working properly and appears to be.
>
> The n770 code is configured to use the following brf6510 GPIOS:   
> reset:4, hostwake:61, btwake:194.
>
> The attached patch forces this schedule, but isn't really a good  
> patch  as the (non-functional) PM stuff is still in there.
>
> Can anyone shed any light on this situation? Note that I am using  
> the  brf6150fw.bin firmware binary from the   
> SU-18_2006SE_1.2006.26-8_PR_F5_MR0_ARM OS release.
>
> The bluetooth firmware from SU-18_2006SE_2.2006.39-14_PR_F5_MR0_ARM  
> is  corrupt (has loads of zero bytes at the start, which the code  
> reveals  is invalid).
>
> The bluetooth firmware from SU-18_2006SE_3.2006.49-2_PR_F5_MR0_ARM  
> is  ALSO corrupt; this time its been truncated to 8192 bytes so the  
> loader  runs off the end.
>
> If this can't be resolved, and since I don't have any docs on the   
> brf6150 or newer firmware images, I'd be tempted to simply kill the  
> PM  code since its not actually doing anything useful. I'd prefer to  
> get  it to work though....

Hi, its been pointed out that the firmware extraction method I was  
using was corrupting the firmware. Extracting it /properly/ makes the  
bluetooth chip work correctly with the PM code! So, the second  
prepatch ain't necessary any more.

Next up: fix N770 sound.

