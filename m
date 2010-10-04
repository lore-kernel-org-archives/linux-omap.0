From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: NOTE: hwmod changes merged to linux-omap master for testing
Date: Mon, 4 Oct 2010 17:04:22 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402DB90CBA7@dbde02.ent.ti.com>
References: <20101002004821.GN3117@atomide.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E9402DB90C96B@dbde02.ent.ti.com>
 <AANLkTi=Ek+m_AMx2-jOgkGOeMYjKFmTrCMjZ=2r+G67q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35856 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754076Ab0JDLec convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Oct 2010 07:34:32 -0400
In-Reply-To: <AANLkTi=Ek+m_AMx2-jOgkGOeMYjKFmTrCMjZ=2r+G67q@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Govindraj <govindraj.ti@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: Govindraj [mailto:govindraj.ti@gmail.com] 
> Sent: Monday, October 04, 2010 2:50 PM
> To: G, Manjunath Kondaiah
> Cc: Tony Lindgren; linux-omap@vger.kernel.org
> Subject: Re: NOTE: hwmod changes merged to linux-omap master 
> for testing
> 
> On Mon, Oct 4, 2010 at 1:19 PM, G, Manjunath Kondaiah 
> <manjugk@ti.com> wrote:
> > Hi Tony,
> > With latest merges on master branch with commit ID:
> > 0882b1455797b0a104978000a622c3f2412e7cf5 omap: READ CAREFULLY: Fix 
> > build after merging in hwmod support for testing
> >
> > Booting with zoom3 seems to be fine but observed issues 
> with omap4 blaze board.
> >
> > Looks like multiple warning dumps and finally it crashes 
> after "Freeing init memory" with both NFS and ramdisk file systems.
> 
> This issue though seems to exist much before hwmod merge, I 
> tried below commit on master

Mainline line kernel(2.6.36-rc6) merged only with 'omap_for_2.6.37' 
of git://dev.omapzoom.org/pub/scm/santosh/kernel-omap4-base 
will work fine on omap4.

-Manjunath
