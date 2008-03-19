From: "arun c" <arunedarath@mistralsolutions.com>
Subject: RE:omapfb driver support of DSS rotation and mirroring
Date: Wed, 19 Mar 2008 19:48:07 +0530
Message-ID: <c656a4d20803190718q63bd985au6e770855902793a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.187]:41883 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161217AbYCSVxw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Mar 2008 17:53:52 -0400
Received: by gv-out-0910.google.com with SMTP id s4so245130gve.37
        for <linux-omap@vger.kernel.org>; Wed, 19 Mar 2008 14:53:49 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

On Fri, Mar 14, 2008 at 5:53 PM, Syed Mohammed, Khasim <khasim@ti.com> wrote:
> >
>  > I will try porting it to git ( Surely help is needed because i am
>  > new), does any body tried it alredy?
>  >
>  I will be glad to help you on this, just let me know where exactly you want to start with.
>
>  Probably I will put a ppt or pdf out to all.

Could you please share those documents?

Did rotation Based on DMA is implemented in
ti kernel (linux-2.6.14-omap2-v5)?

>From the code i understood that its just changing
display size , row_inc and pix_inc these values are
not according to TRM values for graphics rotation.
Can anybody please explain this?

In linux-2.6.14-omap2-v5 VRFB based rotation is
only activated when we give video=omap24xxfb:
rotation=X in bootargs.

I think we can make this a menuconfig item and
try to port it to git

Regards,
Arun c
