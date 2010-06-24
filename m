From: "C.A, Subramaniam" <subramaniam.ca@ti.com>
Subject: RE: [PATCH 3/4] omap mailbox: remove mbox_configured scheme
Date: Fri, 25 Jun 2010 03:54:06 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301E7761943@dbde02.ent.ti.com>
References: <1277251896-6890-1-git-send-email-ohad@wizery.com>
 	<1277251896-6890-3-git-send-email-ohad@wizery.com>
 <8F7AF80515AF0D4D93307E594F3CB40E4C890B71@dlee03.ent.ti.com>
 <AANLkTilB45f1zLBCw-tytQKTGJXVu5IoXNNpBNjr5bm3@mail.gmail.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301E7761941@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53850 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752192Ab0FXWYQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jun 2010 18:24:16 -0400
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301E7761941@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "C.A, Subramaniam" <subramaniam.ca@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>


> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of C.A, 
> Subramaniam
> Sent: Thursday, June 24, 2010 4:36 PM
> To: Ohad Ben-Cohen; Kanigeri, Hari
> Cc: linux-omap@vger.kernel.org; Hiroshi Doyu; Ramirez Luna, Omar
> Subject: RE: [PATCH 3/4] omap mailbox: remove mbox_configured scheme
> 
> 
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org 
> > [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Ohad 
> Ben-Cohen
> > Sent: Thursday, June 24, 2010 3:23 PM
> > To: Kanigeri, Hari
> > Cc: linux-omap@vger.kernel.org; Hiroshi Doyu; Ramirez Luna, Omar
> > Subject: Re: [PATCH 3/4] omap mailbox: remove mbox_configured scheme
> > 
> > On Thu, Jun 24, 2010 at 6:10 PM, Kanigeri, Hari 
> <h-kanigeri2@ti.com> 
> > wrote:
> > > Ohad,
> > >
> > >> mbox_configured is global and therefore does not support
> > concurrent
> > >> usage of multiple mailbox instances.
> > >
> > > -- Why do you say that it doesn't support concurrent usage
> > of multiple mailbox instances ? If you take example of 
> OMAP4, we have 
> > 2 mailbox instances, one talking to DSP and other to Ducati 
> and they 
> > should be supported concurrently.
> > 
> > 
> > Interesting. was this actually tested and found working ?
> > 
> I think by supporting multiple instances, what Hari meant was 
> that, for DSP and Ducati 2 different struct omap_mbox * are 
> returned. They still can maintain their own callback function
> (http://dev.omapzoom.org/?p=tisyslink/kernel-syslink.git;a=blo
> b;f=arch/arm/mach-omap2/mailbox.c;h=a23c7edf1e84ab4fa51e56d0c2
> daf2922084751a;hb=438f7a6a3cced478eb121426201206f6205fbbdc#l32
> 7 for Ducati and
> 
> http://dev.omapzoom.org/?p=tisyslink/kernel-syslink.git;a=blob
> ;f=arch/arm/mach-omap2/mailbox.c;h=a23c7edf1e84ab4fa51e56d0c2d
> af2922084751a;hb=438f7a6a3cced478eb121426201206f6205fbbdc#l334
> for DSP).
> 
> The "mbox_configured" was a means to reference count for one 
> instance of the struct omap_mbox * .
Sorry I that that back. Even though we maintain 2 strucutres, only the one that calls the request_irq() is honoured. Hence yes only one callback will be serviced (Thank to Ramesh for pointing that out). Chaining of callbacks is a good way to allow multiple clients to be notified.

>   
> > AFAICT (I don't have OMAP4, this is just by looking at the
> > code) this doesn't work:
> > mbox_configured will prevent omap2_mbox_startup from being invoked 
> > more than once. This means that omap2_mbox_enable_irq(mbox, IRQ_RX) 
> > will only be called once too, which seems like a problem if 
> you want 
> > to start receiving RX interrupts from both mbox instances 
> at the same 
> > time.
> > 
> > To fix that I guess we should decouple the RX interrupt 
> enabling from 
> > the mbox startup function. I can write something, but I'd need your 
> > help to test it on OMAP4 :)
> > 
> > >
> > > If you remove the mbox_configured variable, then the 
> mailbox module 
> > > would shut down once the first instance calls the
> > omap_mbox_put function.
> > 
> > Also interesting point.
> > 
> > So you use mbox_configures as a reference counter to allow 
> concurrent 
> > multiple senders to the same mbox instance.
> > 
> > I will update the previous patch (that introduced the atomic_t 
> > reference counter) to reflect this use case, thanks!
> > 
> > >
> > > Thank you,
> > > Best regards,
> > > Hari
> > >
> > --
> > To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" 
> > in the body of a message to majordomo@vger.kernel.org More 
> majordomo 
> > info at http://vger.kernel.org/majordomo-info.html
> > 
> 
> 
> Thank you and Regards
> Subbu--
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in the body of a message to 
> majordomo@vger.kernel.org More majordomo info at  
> http://vger.kernel.org/majordomo-info.html
> 

Thank you and Regards
Subbu