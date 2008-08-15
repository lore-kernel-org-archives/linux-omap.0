From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: [RFC] Port TI DSP BRIDGE for a new dedicated branch in linux-omap
Date: Fri, 15 Aug 2008 13:22:32 +0530
Message-ID: <5d5443650808150052l29bf0830u60ff256b51d53066@mail.gmail.com>
References: <1218782824-12596-1-git-send-email-Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f29.google.com ([209.85.217.29]:47484 "EHLO
	mail-gx0-f29.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752798AbYHOHwd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Aug 2008 03:52:33 -0400
Received: by gxk10 with SMTP id 10so2681544gxk.13
        for <linux-omap@vger.kernel.org>; Fri, 15 Aug 2008 00:52:32 -0700 (PDT)
In-Reply-To: <1218782824-12596-1-git-send-email-Hiroshi.DOYU@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-omap@vger.kernel.org, h-kanigeri2@ti.com, x00omar@ti.com, x0023949@ti.com, felipe.contreras@nokia.com

Hi Doyu-San,

On Fri, Aug 15, 2008 at 12:16 PM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com> wrote:
> Hello all,
>
> I have ported the latest TI DSP BRIDGE from "omapzoom" to linux
> omap. The purpose of this port is to get this code kept in a new
> dedicated branch(ex: "dspbridge") in l-o, not intended to be merged
> into master or some other existing branches for now, but to provide
> an efficient development space to collaborate.

Thanks for starting this discussion and cleanup. I vote for this
approach. It is better to have branch in linux-omap-git tree instead
of separate GIT tree for better collaboration between TI and
linux-omap-dsp community.

Let's wait for Tony to put some inputs here, because someone has to
maintain this branch and needs write access or else Tony has to do all
the work of pushing/rebasing the patches in to ti-dspbridge branch :)


-- 
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
