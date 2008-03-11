From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: How to build Native GCC for ARM
Date: Tue, 11 Mar 2008 12:15:47 +0530
Message-ID: <5d5443650803102345s15a9adaai19893faec8cc3a92@mail.gmail.com>
References: <5ae31d3b0803102224s7c99170bv7e5d056ba37689d7@mail.gmail.com>
	 <5d5443650803102318k3fc9cacdkb49c2fe23fafc5ba@mail.gmail.com>
	 <5ae31d3b0803102333y1d5e8c3ev9fc3dec844d05fd3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.234]:47086 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751625AbYCKGpx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Mar 2008 02:45:53 -0400
Received: by wx-out-0506.google.com with SMTP id h31so2345448wxd.4
        for <linux-omap@vger.kernel.org>; Mon, 10 Mar 2008 23:45:52 -0700 (PDT)
In-Reply-To: <5ae31d3b0803102333y1d5e8c3ev9fc3dec844d05fd3@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: kuldeep nigam <kuldeepnigam@gmail.com>
Cc: linux-omap@vger.kernel.org

Hi Kuldeep,

On Tue, Mar 11, 2008 at 12:03 PM, kuldeep nigam <kuldeepnigam@gmail.com> wrote:
>
>
>
> On Tue, Mar 11, 2008 at 11:48 AM, Trilok Soni <soni.trilok@gmail.com> wrote:
> > Hi Kuldeep,
> >
> > On Tue, Mar 11, 2008 at 10:54 AM, kuldeep nigam <kuldeepnigam@gmail.com>
> wrote:
> > > Hi all,
> > >
> >
> > Why you have such requirement and why you can't use the existing
> > cross-compilers? Please explain.
> >
> > --
> > ---Trilok Soni
> > http://triloksoni.wordpress.com
> >
>
>
> i m working on OMAP2430 board and want to compile some application on the
> board itself.
>

Please use cross-compiler instead. I don't suggest use this approach.
Did you tried scratchbox?


-- 
---Trilok Soni
http://triloksoni.wordpress.com
