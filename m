From: Ameya Palande <ameya.palande@nokia.com>
Subject: RE: [PATCH] DSPBRIDGE: Validate node handle from user
Date: Fri, 12 Feb 2010 01:31:43 +0200
Message-ID: <1265931103.26484.71.camel@chotu.research.nokia.com>
References: <B852767254C5C94EBB1040EE0EFA06008C89E95B@dlee01.ent.ti.com>
	 <1265736734.2832.11.camel@sanganak>
	 <B852767254C5C94EBB1040EE0EFA06008C89EA24@dlee01.ent.ti.com>
	 <1265896260.4084.5.camel@sanganak>
	 <B852767254C5C94EBB1040EE0EFA06008C992901@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:47790 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757374Ab0BKXcH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Feb 2010 18:32:07 -0500
In-Reply-To: <B852767254C5C94EBB1040EE0EFA06008C992901@dlee01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Ramos Falcon, Ernesto" <ernesto@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Contreras Felipe (Nokia-D/Helsinki)" <felipe.contreras@nokia.com>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>

Hi Ernesto,

On Thu, 2010-02-11 at 19:44 +0100, ext Ramos Falcon, Ernesto wrote:
> 
> >-----Original Message-----
> >From: Ameya Palande [mailto:ameya.palande@nokia.com]
> >Sent: Thursday, February 11, 2010 7:51 AM
> >To: Ramos Falcon, Ernesto
> >Cc: linux-omap@vger.kernel.org; Contreras Felipe (Nokia-D/Helsinki); Doyu
> >Hiroshi (Nokia-D/Helsinki)
> >Subject: RE: [PATCH] DSPBRIDGE: Validate node handle from user
> >
> >On Tue, 2010-02-09 at 18:52 +0100, ext Ramos Falcon, Ernesto wrote:
> >>
> >> >-----Original Message-----
> >> >From: Ameya Palande [mailto:ameya.palande@nokia.com]
> >> >Sent: Tuesday, February 09, 2010 11:32 AM
> >> >To: Ramos Falcon, Ernesto
> >> >Cc: linux-omap@vger.kernel.org; Contreras Felipe (Nokia-D/Helsinki);
> >Doyu
> >> >Hiroshi (Nokia-D/Helsinki)
> >> >Subject: Re: [PATCH] DSPBRIDGE: Validate node handle from user
> >> >
> >> >Hi Ernesto,
> >> >
> >> >On Tue, 2010-02-09 at 18:08 +0100, ext Ramos Falcon, Ernesto wrote:
> >> >> From 8310b586b025b0703c3951560849c4ea0250b6e1 Mon Sep 17 00:00:00 2001
> >> >> From: Ernesto Ramos <ernesto@ti.com>
> >> >> Date: Fri, 29 Jan 2010 16:21:59 -0600
> >> >> Subject: [PATCH] DSPBRIDGE: Validate node handle from user.
> >> >>
> >> >> Add checks to validate the node handles received from user.
> >> >>
> >> >> Signed-off-by: Ernesto Ramos <ernesto@ti.com>

<SNIP>

> >> >If you have several nodes allocated by user space, then what you are
> >> >validating here is for any node! Is that ok?
> >> >
> >> >This validation and design itself doesn't look good to me. If we don't
> >> >want to trust user space, then instead of checking the node handle in
> >> >every function it is better to store all user space specific date inside
> >> >pr_context and use it from there.
> >> >
> >>
> >> The user can launch several nodes, how are we going to know which node
> >handle to use?
> >> I think we may need to receive at least one index or id to the node
> >handle.
> >
> >Yes, I guess thats the correct way! We need to maintain how many nodes
> >are allocated for a user process, and just make sure that this id /
> >index is <= number of allocated nodes.
> >
> 
> This comparison (<=) won't work because the user can eliminate nodes in the middle of the list in which case we may need to maintain a list of valid indexes. So I don't see any improvement with this way to validate the handles. 

I agree :(

> I was thinking in an array an based on the index verify that the handle is valid, independently of the number of nodes this would be very quick, but the disadvantage would be that the number per process will be limited to the size of the array.

Yes, array has disadvantage of size, but Linux also uses initial array
of 32 size for storing file pointers. 

On a second thought our problem looks similar to following use case:

User space application opens several files using open() system call and
receives handles for each. Now it passes handle to kernel using read(),
write() system calls to identify the file to operate on. How does kernel
validates the handle received from user space?

I guess we can base our solution on a bitmap to find next available
slot:

DECLARE_BITMAP();
find_first_zero_bit();
set_bit();
clear_bit();

And use array[free_slot] to store the pointer.

With solution I guess we can get rid of these checks ;)

Cheers,
Ameya.

