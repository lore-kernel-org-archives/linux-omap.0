From: Rajendra Nayak <rnayak@ti.com>
Subject: RE: [PATCH v2 0/5] Split powerdomain framework into plat specific/independent
Date: Fri, 3 Dec 2010 14:16:43 +0530
Message-ID: <fc2efdf7d5755cb6f22dd575674e7f27@mail.gmail.com>
References: <1291131848-31640-1-git-send-email-rnayak@ti.com>
 <alpine.DEB.2.00.1012011254460.2515@utopia.booyaka.com> <699e6818fd0b2162302926a3c724749f@mail.gmail.com>
 <alpine.DEB.2.00.1012030139020.17078@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:56535 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751777Ab0LCIqq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Dec 2010 03:46:46 -0500
Received: by mail-qw0-f46.google.com with SMTP id 7so9350227qwb.19
        for <linux-omap@vger.kernel.org>; Fri, 03 Dec 2010 00:46:45 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1012030139020.17078@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, Benoit Cousson <b-cousson@ti.com>

> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Friday, December 03, 2010 2:11 PM
> To: Rajendra Nayak
> Cc: linux-omap@vger.kernel.org; khilman@deeprootsystems.com; Benoit
Cousson
> Subject: RE: [PATCH v2 0/5] Split powerdomain framework into plat
specific/independent
>
> Hi Rajendra,
>
> On Thu, 2 Dec 2010, Rajendra Nayak wrote:
>
> > This seems to be popping up with powerdomains.h file (which now
> > has func declarations) being included in multiple source files. It
earlier
> > had only static structs and was included in one source file.
> >
> > I thought the right way to fix this was to probably move the static
> > structs from the header into a source file.
> > See if the below patch makes sense. Also attached as I don't trust
> > my mailer.
>
> Yes, that general approach looks fine to me.  I've got some patches here
> that will be posted once this powerdomain series is done to convert all
> the remaining static allocations in .h files into .c files.

Ok, so I'll repost the series with this patch included as well so that
the warnings are'nt thrown anymore.

>
>
> - Paul
