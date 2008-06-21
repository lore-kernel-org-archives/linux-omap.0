From: "Peter Teoh" <htmldeveloper@gmail.com>
Subject: Re: Video playback on osk with linux-2.6.18
Date: Sat, 21 Jun 2008 11:49:14 +0800
Message-ID: <804dabb00806202049i13b7031ej7ee7f5857bea23cf@mail.gmail.com>
References: <a1d91fa0806181223h19bb9f9dxb67300bfea953de9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.245]:6342 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754228AbYFUDtR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Jun 2008 23:49:17 -0400
Received: by an-out-0708.google.com with SMTP id d40so352105and.103
        for <linux-omap@vger.kernel.org>; Fri, 20 Jun 2008 20:49:16 -0700 (PDT)
In-Reply-To: <a1d91fa0806181223h19bb9f9dxb67300bfea953de9@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mohammed shareef <mdshareef@gmail.com>
Cc: omap <linux-omap@vger.kernel.org>, linux-newbie@vger.kernel.org

Wow....looks like a exciting gadget to play with....

On Thu, Jun 19, 2008 at 3:23 AM, mohammed shareef <mdshareef@gmail.com> wrote:
> Dear All,
>
> I have an OSK-Omap5912 with linux-2.6.18 running on it. i want to add
> video playback support to it. Has someone done this before? could you
> suggest some ways to do it? thank you.
>
> regards,
> Mohammed


First:

>From www.omap.com===>under "Design and Support" and "Sample" u can
possibly find the technical document, and program samples and
libraries to program the device.   Or enter the part number in the
search box and find.

or this site:

http://omap.spectrumdigital.com/osk5912/ ==> here u can find all the
hardware datasheet, software/hardware userguide - all specific to
osk5912.

http://omap.spectrumdigital.com/osk5912/bsp/index.html ==> codes samples here.

2nd:

There is a mailing list for this, subscribe here (and this one looks
quite active...not sure how it compared with the one at
linux-omap@vger.   Similarly, for Linux Kernel Newbies, the mailing
list at kernelnewbies@nl.linux.org is much more active than that of
linux-newbie@vger.

http://linux.omap.com/mailman/listinfo/linux-omap-open-source

and in particular, this email has a small program sample to control the device:

http://linux.omap.com/pipermail/linux-omap-open-source/2006-January/006205.html

3rd:

In the kernel source drivers/video/omap directory - not sure how
useful, but datasheet from above should source be the best.

-- 
Regards,
Peter Teoh
