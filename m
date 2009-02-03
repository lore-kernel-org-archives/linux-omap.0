From: Shreyas Mahajan <mahajan.shreyas@gmail.com>
Subject: Re: Omap3430 does not resume after suspend
Date: Tue, 3 Feb 2009 11:44:08 +0530
Message-ID: <d105d8d00902022214r4f67ecdcp4ce153f0c88cb512@mail.gmail.com>
References: <d105d8d00901300124i60025abete9f0b0e86d676f82@mail.gmail.com>
	 <B85A65D85D7EB246BE421B3FB0FBB59301C7069769@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:6680 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751097AbZBCGOJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Feb 2009 01:14:09 -0500
Received: by wa-out-1112.google.com with SMTP id v33so908071wah.21
        for <linux-omap@vger.kernel.org>; Mon, 02 Feb 2009 22:14:08 -0800 (PST)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301C7069769@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>, linux-omap@vger.kernel.org

On Fri, Jan 30, 2009 at 7:32 PM, Premi, Sanjeev <premi@ti.com> wrote:
>
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org
> > [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Shreyas Mahajan
> > Sent: Friday, January 30, 2009 2:54 PM
> > To: linux-omap@vger.kernel.org
> > Subject: Omap3430 does not resume after suspend
> >
> > Hello,
> >          I am a newbie with omap3430. As a part of my
> > project, I suspended my board with 'echo mem >
> > /sys/power/state'.The suspend happens correctly, without
> > giving any failure message. But, when I tried it to resume,
> > it is not resuming.I tried to find some reasons for this, and
> > got the patches for unmasking keyboard interrupt while
> > suspending. But, all patches are for omap2 and omap1 board
> > architecture.
> [sp] Are you following updates in Kevin Hilman's pm branch?
> With lastest updates you shouldn't see this problem on a minimal config.
>
> Would be good to start from here and add drivers selectively.
>
> > Are there any patches to do this thing in omap3430?
>
> [sp] omap2 applies to OMAP3430 as well.
>
> >
> > Thanks,
> > --
> > To unsubscribe from this list: send the line "unsubscribe
> > linux-omap" in the body of a message to
> > majordomo@vger.kernel.org More majordomo info at
> > http://vger.kernel.org/majordomo-info.html
> >
> >

Thanks for reply.
I went through the Kevin Hilman's PM branch and found the same problem
posted by you (@Sanjeev),

'Hangs on a echo mem > /sys/power/state
> Goes into suspend, but cannot recover'

So, can you please tell me if this problem is solved?
