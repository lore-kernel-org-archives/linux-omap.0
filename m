From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [RFC/PATCH 1/2] omap: mailbox: initial hwmod support
Date: Mon, 24 May 2010 16:56:07 -0700
Message-ID: <878w78voq0.fsf@deeprootsystems.com>
References: <1274549122-26521-1-git-send-email-felipe.contreras@gmail.com>
	<1274549122-26521-2-git-send-email-felipe.contreras@gmail.com>
	<8F7AF80515AF0D4D93307E594F3CB40E4BDF42DA@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:48213 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932691Ab0EXX4L (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 May 2010 19:56:11 -0400
Received: by pwi2 with SMTP id 2so765210pwi.19
        for <linux-omap@vger.kernel.org>; Mon, 24 May 2010 16:56:10 -0700 (PDT)
In-Reply-To: <8F7AF80515AF0D4D93307E594F3CB40E4BDF42DA@dlee03.ent.ti.com> (Hari Kanigeri's message of "Sun\, 23 May 2010 19\:59\:28 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>, linux-omap <linux-omap@vger.kernel.org>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Paul Walmsley <paul@pwsan.com>, Ohad Ben-Cohen <ohad@wizery.com>

"Kanigeri, Hari" <h-kanigeri2@ti.com> writes:

> Felipe,
>
>
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of Felipe Contreras
>> Sent: Saturday, May 22, 2010 12:25 PM
>> To: linux-omap
>> Cc: Hiroshi Doyu; Kevin Hilman; Paul Walmsley; Ohad Ben-Cohen; Felipe
>> Contreras
>> Subject: [RFC/PATCH 1/2] omap: mailbox: initial hwmod support
>> 
>> Only OMAP3 would work.
>
> -- This is good start. 

Agreed.  Nice!

> I will look into adding/verifying OMAP4 support. If any one already started this effort please inform.


OMAP2 hwmod data also needs to be added for this to go upstream, otherwise
this will break on OMAP2.

Kevin

