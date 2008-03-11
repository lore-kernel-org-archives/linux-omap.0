From: Tony Lindgren <tony@atomide.com>
Subject: Re: How to build Native GCC for ARM
Date: Tue, 11 Mar 2008 08:32:47 +0200
Message-ID: <20080311063247.GF7524@atomide.com>
References: <5ae31d3b0803102224s7c99170bv7e5d056ba37689d7@mail.gmail.com> <5d5443650803102318k3fc9cacdkb49c2fe23fafc5ba@mail.gmail.com> <5ae31d3b0803102333y1d5e8c3ev9fc3dec844d05fd3@mail.gmail.com> <5d5443650803102345s15a9adaai19893faec8cc3a92@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:55023 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751974AbYCKHcg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Mar 2008 03:32:36 -0400
Content-Disposition: inline
In-Reply-To: <5d5443650803102345s15a9adaai19893faec8cc3a92@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Trilok Soni <soni.trilok@gmail.com>
Cc: kuldeep nigam <kuldeepnigam@gmail.com>, linux-omap@vger.kernel.org

* Trilok Soni <soni.trilok@gmail.com> [080311 08:46]:
> Hi Kuldeep,
> 
> On Tue, Mar 11, 2008 at 12:03 PM, kuldeep nigam <kuldeepnigam@gmail.com> wrote:
> >
> >
> >
> > On Tue, Mar 11, 2008 at 11:48 AM, Trilok Soni <soni.trilok@gmail.com> wrote:
> > > Hi Kuldeep,
> > >
> > > On Tue, Mar 11, 2008 at 10:54 AM, kuldeep nigam <kuldeepnigam@gmail.com>
> > wrote:
> > > > Hi all,
> > > >
> > >
> > > Why you have such requirement and why you can't use the existing
> > > cross-compilers? Please explain.
> > >
> > > --
> > > ---Trilok Soni
> > > http://triloksoni.wordpress.com
> > >
> >
> >
> > i m working on OMAP2430 board and want to compile some application on the
> > board itself.
> >
> 
> Please use cross-compiler instead. I don't suggest use this approach.
> Did you tried scratchbox?

You can also use crosstool.org to compile it, but it may be a big to
get that bootstrapped natively on arm :) How about just install debian
armel to an nfsroot and compile with that?

Tony
