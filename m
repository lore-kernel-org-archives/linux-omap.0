From: "Govindarajan, Sriramakrishnan" <srk@ti.com>
Subject: RE: [PATCH] ARCH OMAP : enable ARCH_HAS_HOLES_MEMORYMODEL for OMAP
Date: Fri, 8 Jan 2010 13:45:59 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC3560870300519AC7@dbde02.ent.ti.com>
References: <1262867408-9895-1-git-send-email-srk@ti.com>
 <4B45FC4B.9080302@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57197 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753362Ab0AHIQG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jan 2010 03:16:06 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o088G26k015003
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 8 Jan 2010 02:16:05 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o088G1P8012905
	for <linux-omap@vger.kernel.org>; Fri, 8 Jan 2010 13:46:02 +0530 (IST)
In-Reply-To: <4B45FC4B.9080302@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Syed Mohammed, Khasim" <khasim@ti.com>, "Nori, Sekhar" <nsekhar@ti.com>



> From: Menon, Nishanth
> Govindarajan, Sriramakrishnan had written, on 01/07/2010 06:30 AM, the
> following:
> > From: Sriram <srk@ti.com>
> >
> > OMAP platforms(like OMAP3530) include DSP or other co-processors
> > for media acceleration. when carving out memory for the
> > accelerators we can end up creating a hole in the memory map
> > of sort:
> > <kernel memory><hole(memory for accelerator)><kernel memory>
> >
> > To handle such a memory configuration ARCH_HAS_HOLES_MEMORYMODEL
> > has to be enabled. For further information refer discussion at:
> > http://www.mail-archive.com/linux-omap@vger.kernl.org/msg15262.html.
> 
> pls check the link: I see "The document you were looking for was not
> found."

The URL is spelt incorrectly. Here is the correct URL:
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg15262.html

> >  	select GENERIC_TIME
> >  	select GENERIC_CLOCKEVENTS
> > +	select ARCH_HAS_HOLES_MEMORYMODEL
> why enable this for all OMAPs?

I have tested this on several OMAP3 platforms and this feature is required
Wherever some memory needs to be reserved for media accelerators - hence it
Would be handy for earlier OMAP platforms as well

Regards
Sriram
