From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: Re: Commit 0c8219f0... breaks omap7xx support
Date: Fri, 28 May 2010 21:01:01 -0700
Message-ID: <AANLkTini1wjhRXEfW4AjSdkVEYGpYXpuLcct-1l4pq0o@mail.gmail.com>
References: <6cb013311003062056v3ed83a53u2636838348bf4845@mail.gmail.com>
	<20100309004832.GK2900@atomide.com> <6cb013311003081751u2c7cd8c6v59472ee85ac90e77@mail.gmail.com>
	<20100309024602.GQ2900@atomide.com> <6cb013311003081906n751bedb4k2794ed40ed68d7ec@mail.gmail.com>
	<20100309155636.GS2900@atomide.com> <6cb013311003091541k6a18c16bv4bb3d35f101e5bab@mail.gmail.com>
	<20100315182939.GV2900@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:54022 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750722Ab0E2EBW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 29 May 2010 00:01:22 -0400
Received: by pxi18 with SMTP id 18so808008pxi.19
        for <linux-omap@vger.kernel.org>; Fri, 28 May 2010 21:01:21 -0700 (PDT)
In-Reply-To: <20100315182939.GV2900@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, miknix@gmail.com, a.j.buxton@gmail.com, linwizard-devel@lists.sf.net

On Mon, Mar 15, 2010 at 11:29 AM, Tony Lindgren <tony@atomide.com> wrot=
e:
>
> * Cory Maccarrone <darkstar6262@gmail.com> [100309 15:38]:
> > On Tue, Mar 9, 2010 at 7:56 AM, Tony Lindgren <tony@atomide.com> wr=
ote:
> > >
> > > Does your system boot without any patches if DEBUG_LL is not set
> > > in your .config?
> >
> > No, it doesn't. =C2=A0Seems like the debugging code is still trying=
 to run,
> > even disabled. =C2=A0If I add in that check, it'll boot with DEBUG_=
LL not
> > set, but won't without that.
>
> Sorry for the delay on this. How about with the following patch with
> DEBUG_LL not set?
>
> Note that this is using the shift register now too.
>
> Regards,
>
> Tony

Sorry I took so long on this one.  This patch worked beautifully for
me on the latest kernel tree.  Any chance of it getting in for one of
the RCs of this next kernel?

Thanks
- Cory
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
