From: "Robert Lukassen" <Robert.Lukassen@tomtom.com>
Subject: RE: Overo serial problems after resume, vs. Beagleboard
Date: Tue, 22 Jun 2010 11:37:02 +0200
Message-ID: <D6DB9C7EDECDA944B870F62B587008622C89D1@NL-EXC-06.intra.local>
References: <4C1F9B80.9010708@gmail.com> <874ogw1dy2.fsf@deeprootsystems.com> <4C207A9C.7070309@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mxvs2.esa.t-systems.com ([81.7.202.143]:28788 "EHLO
	mxvs2.esa.t-systems.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754366Ab0FVJhN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Jun 2010 05:37:13 -0400
Content-class: urn:content-classes:message
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Rapoport <mike@compulab.co.il>, Kevin Hilman <khilman@deeprootsystems.com>, Peter Tseng <tsenpet09@gmail.com>, linux-omap@vger.kernel.org, Han Wang <hw342@cornell.edu>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Mike Rapoport
> Sent: Tuesday, June 22, 2010 10:56 AM
> To: Kevin Hilman
> Cc: Peter Tseng; linux-omap@vger.kernel.org; Han Wang
> Subject: Re: Overo serial problems after resume, vs. Beagleboard
> 
> Kevin Hilman wrote:
> > Peter Tseng <tsenpet09@gmail.com> writes:
> > 
> >> I am seeing some discrepancies between the Overo (I 
> believe I have a
> >> Water) and the Beagleboard (I have a Rev. B5) when 
> resuming after a 
> >> suspend to RAM.
> > 
> > Not that it is much comfort, but I have the same problem on 
> Overo but 
> > don't see it on any other OMAP3 board.
> > 
> > I have yet to debug this particular issue further.
> 
> I had the same issue on CM-T35 and when I've disabled 
> CONFIG_CPU_IDLE in the kernel configuration the issue 
> disappeared. Maybe it'll be of some help.

I just tried that. It helps. I no longer experience this lockup 
of the console. Thanks. 

I'll make a note to try to figure out why this actually helps.

Regards,

Robert
