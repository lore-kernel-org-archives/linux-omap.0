From: "Govindarajan, Sriramakrishnan" <srk@ti.com>
Subject: RE: [PATCH] ARCH OMAP : enable ARCH_HAS_HOLES_MEMORYMODEL for OMAP
Date: Mon, 11 Jan 2010 17:42:58 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087030051A222@dbde02.ent.ti.com>
References: <1262867408-9895-1-git-send-email-srk@ti.com>
 <4B45FC4B.9080302@ti.com>
 <FCCFB4CDC6E5564B9182F639FC3560870300519AC7@dbde02.ent.ti.com>
 <4B47491F.1000303@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60014 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753244Ab0AKMNE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jan 2010 07:13:04 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o0BCCxwY011275
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 11 Jan 2010 06:13:01 -0600
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o0BCCwYh028882
	for <linux-omap@vger.kernel.org>; Mon, 11 Jan 2010 17:42:58 +0530 (IST)
In-Reply-To: <4B47491F.1000303@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Syed Mohammed, Khasim" <khasim@ti.com>, "Nori, Sekhar" <nsekhar@ti.com>

From: Menon, Nishanth
> Sent: Friday, January 08, 2010 8:33 PM
> To: Govindarajan, Sriramakrishnan
> Cc: linux-omap@vger.kernel.org; Syed Mohammed, Khasim; Nori, Sekhar
> Subject: Re: [PATCH] ARCH OMAP : enable ARCH_HAS_HOLES_MEMORYMODEL for
> OMAP
> 
> Govindarajan, Sriramakrishnan had written, on 01/08/2010 02:15 AM, the
> following:
> >
> >> From: Menon, Nishanth
> >> Govindarajan, Sriramakrishnan had written, on 01/07/2010 06:30 AM, the
> >> following:
> >>> From: Sriram <srk@ti.com>
> >>>
> >>> OMAP platforms(like OMAP3530) include DSP or other co-processors
> >>> for media acceleration. when carving out memory for the
> >>> accelerators we can end up creating a hole in the memory map
> >>> of sort:
> >>> <kernel memory><hole(memory for accelerator)><kernel memory>
> >>>
> >>> To handle such a memory configuration ARCH_HAS_HOLES_MEMORYMODEL
> >>> has to be enabled. For further information refer discussion at:
> >>> http://www.mail-archive.com/linux-omap@vger.kernl.org/msg15262.html.
> >> pls check the link: I see "The document you were looking for was not
> >> found."
> >
> > The URL is spelt incorrectly. Here is the correct URL:
> > http://www.mail-archive.com/linux-omap@vger.kernel.org/msg15262.html
> >
> >>>  	select GENERIC_TIME
> >>>  	select GENERIC_CLOCKEVENTS
> >>> +	select ARCH_HAS_HOLES_MEMORYMODEL
> >> why enable this for all OMAPs?
> >
> > I have tested this on several OMAP3 platforms and this feature is
> required
> > Wherever some memory needs to be reserved for media accelerators - hence
> it
> > Would be handy for earlier OMAP platforms as well
> I understand that you have tested with OMAP3. my question is you have
> handled this as per the diff
> @@ -699,6 +699,7 @@ config ARCH_OMAP
> to ARCH_OMAP
> 
> is this good for OMAP1510, 1610, 1710, 2420,2430, 770 etc..?

I do not have other OMAP platforms for me to validate this patch on.
I believe the nature of change is generic and benefit other OMAP
Platforms as well.

Regards
Sriram

