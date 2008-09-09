From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: omapzoom tree broken?
Date: Tue, 9 Sep 2008 19:54:15 +0100
Message-ID: <20080909185415.GM8894@flint.arm.linux.org.uk>
References: <20080909175929.GK8894@flint.arm.linux.org.uk> <1f11a5490809091137r66a9d91cl850ad6e034fe5844@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:35588 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753954AbYIISya (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Sep 2008 14:54:30 -0400
Content-Disposition: inline
In-Reply-To: <1f11a5490809091137r66a9d91cl850ad6e034fe5844@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ashwin Bihari <abihari@gmail.com>
Cc: linux-omap@vger.kernel.org

On Tue, Sep 09, 2008 at 02:37:42PM -0400, Ashwin Bihari wrote:
> On Tue, Sep 9, 2008 at 1:59 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > When trying to fetch the omapzoom tree, I get:
> >
> > got a4ae90758b3c38012c875a62d0dd8a20a30e413b
> > walk a4ae90758b3c38012c875a62d0dd8a20a30e413b
> > Getting alternates list for http://git.omapzoom.org/repo/omapkernel
> > Getting pack list for http://git.omapzoom.org/repo/omapkernel
> > Getting index for pack 567cbb972dbfa42338e1269ca4a4a03ec2b1d35f
> > Resuming fetch of index for pack 567cbb972dbfa42338e1269ca4a4a03ec2b1d35f at byte 5890048
> > error: wrong index v1 file size in .git/objects/pack/pack-567cbb972dbfa42338e1269ca4a4a03ec2b1d35f.idx
> > Segmentation fault
> >
> > Could we have it accessible via git the protocol please, rather than
> > http?
> 
> Russell,
> 
> I just pulled the omapzoom tree for the first time and it had no
> problems in the "git clone". Perhaps something to do with fetching
> into an existing repo?

Looks like the pack index was corrupted; removing the one it just fetched
and repulling has made it happier.

However, it's made me unhappier.  Again, can we please have it accessible
via the git protocol.  Or at least can whoever looks after that tree avoid
repacking it except maybe once a month?

Why?  I don't want to have to keep on fetching 300 odd MB of pack files
every time I pull from this tree.  10 minutes into my current pull and
I only have 80MB... another 220MB to go.  IOW, 45 minutes for a pull.

This really isn't practical.
