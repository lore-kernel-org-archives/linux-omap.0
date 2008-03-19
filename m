From: "arun c" <arun.edarath@gmail.com>
Subject: Re: omapfb driver support of DSS rotation and mirroring
Date: Wed, 19 Mar 2008 19:22:05 +0530
Message-ID: <c656a4d20803190652x3bdd9a39pc045caf6012c91c@mail.gmail.com>
References: <c656a4d20803140251u6627c393qdb6280d317983c2d@mail.gmail.com>
	 <7EAD1AEEA7621C45899FE99123E124A0017B1DC3@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.189]:38239 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756299AbYCSUgj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Mar 2008 16:36:39 -0400
Received: by ti-out-0910.google.com with SMTP id 28so290239tif.23
        for <linux-omap@vger.kernel.org>; Wed, 19 Mar 2008 13:36:35 -0700 (PDT)
In-Reply-To: <7EAD1AEEA7621C45899FE99123E124A0017B1DC3@dbde01.ent.ti.com>
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
>
>  Regards,
>  Khasim
>
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
