From: Steve Calfee <stevecalfee@gmail.com>
Subject: Re: [PATCH 1/2] OMAP4: HDMI: Add OMAP device for HDMI audio CPU DAI
Date: Wed, 18 May 2011 10:07:14 -0700
Message-ID: <4DD3FCC2.3020908@gmail.com>
References: <1305602079-3852-1-git-send-email-ricardo.neri@ti.com> <1305602079-3852-2-git-send-email-ricardo.neri@ti.com> <4DD2CDED.6090605@gmail.com> <201105180841.20224.peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:50080 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932791Ab1ERRHS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 May 2011 13:07:18 -0400
Received: by pwi15 with SMTP id 15so835874pwi.19
        for <linux-omap@vger.kernel.org>; Wed, 18 May 2011 10:07:17 -0700 (PDT)
In-Reply-To: <201105180841.20224.peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: "Neri, Ricardo" <ricardo.neri@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Cousson, Benoit" <b-cousson@ti.com>, "paul@pwsan.com" <paul@pwsan.com>

On 05/17/11 22:41, Peter Ujfalusi wrote:
> On Tuesday 17 May 2011 22:35:09 Steve Calfee wrote:
>> I think the generally accepted method of doing stuff like this is to
>> have the ifdeffery in a header file where a inline code segment is
>> defined if it applies to the processor being built. If the code does not
>> apply to the model being built, a null #define is used, which does not
>> take any space.
> 
> We have for example omap2plus_defconfig, which include support for wide range 
> of OMAP based devices, with different CPUs (OMAP2/3/4).
> So we need to have runtime distinction of the CPU we are running (since we run 
> the same kernel binary on OMAP2/3/4).
> 

Hi Peter,

I am not trying to start a flame war here, especially not with you
really helpful people.

The preferred header contained ifdeffery does not exclude the
possibility of having multiple options selected, even at run time. It
also can prevent multi cpu code bloat if it is not wanted.
Alternatively, X86 distributions such as Ubuntu already deal with
multiple arches (within the base arch intel/amd), using initrd type
startups.

Also the current "cpu_is" stuff is not very scalable, when TI gets to
Omap42, or even slightly smaller such as Omap5, the untidiness of the
current technique will become even more of a problem.

Regards, Steve
