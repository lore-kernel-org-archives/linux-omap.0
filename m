From: "Madhusudhan Chikkature" <madhu.cr@ti.com>
Subject: Re: [PATCH 7/9]HDQ driver:replace semaphore with mutex
Date: Wed, 24 Sep 2008 18:47:10 +0530
Message-ID: <024c01c91e47$dbdffa50$LocalHost@wipultra1303>
References: <56530.192.168.10.89.1222255887.squirrel@dbdmail.itg.ti.com> <20080924115031.GO24627@gandalf.research.nokia.com> <020a01c91e45$838ecb80$LocalHost@wipultra1303> <5A47E75E594F054BAF48C5E4FC4B92AB02D5DC8C55@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39069 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751741AbYIXNR0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Sep 2008 09:17:26 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: tony@atomide.com, johnpol@2ka.mipt.ru, felipe.balbi@nokia.com, linux-omap@vger.kernel.org


----- Original Message ----- 
From: "Gadiyar, Anand" <gadiyar@ti.com>
To: "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>; <felipe.balbi@nokia.com>
Cc: <tony@atomide.com>; <johnpol@2ka.mipt.ru>; <felipe.balbi@nokia.com>; <linux-omap@vger.kernel.org>
Sent: Wednesday, September 24, 2008 6:35 PM
Subject: RE: [PATCH 7/9]HDQ driver:replace semaphore with mutex


> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org On Behalf Of Chikkature Rajashekar, Madhusudhan
> ----- Original Message ----- From: "Felipe Balbi" <felipe.balbi@nokia.com>
> 
> > On Wed, Sep 24, 2008 at 05:01:27PM +0530, ext Madhusudhan Chikkature wrote:
> >> From: Madhusudhan Chikkature<madhu.cr@ti.com>
> >> 
> >> This patch replaces the usage of semaphore by mutex.
> >> 
> >> Signed-off-by: Madhusudhan Chikkature<madhu.cr@ti.com>
> >> ---
> >>  drivers/w1/masters/omap_hdq.c |   42 ++++++++++++++++++++++--------------------
> >>  1 files changed, 22 insertions(+), 20 deletions(-)
> >> 
> >> Index: linux-omap-2.6/drivers/w1/masters/omap_hdq.c
> >> ===================================================================
> >> --- linux-omap-2.6.orig/drivers/w1/masters/omap_hdq.c 2008-09-24 11:13:12.000000000 +0530
> >> +++ linux-omap-2.6/drivers/w1/masters/omap_hdq.c 2008-09-24 11:49:45.000000000 +0530
> >> @@ -55,7 +55,7 @@ static int w1_id;
> >>  struct hdq_data {
> >>  struct device *dev;
> >>  void __iomem *hdq_base;
> >> - struct semaphore hdq_semlock;
> >> + struct  mutex hdq_mutex;
> >>  int hdq_usecount;
> >>  struct clk *hdq_ick;
> >>  struct clk *hdq_fck;
> > 
> > Please, fix these two:
> > 
> > CHECK: struct  mutex definition without comment
> > #58: FILE: w1/masters/omap_hdq.c:58:
> > + struct  mutex hdq_mutex;
> > 
> > CHECK: spinlock_t definition without comment
> > #63: FILE: w1/masters/omap_hdq.c:63:
> > + spinlock_t hdq_spinlock;
> > 
> > total: 0 errors, 0 warnings, 2 checks, 732 lines checked
> 
> I dont see any such checks reported by checkpatch.pl?
> 

Oh, I guess Felipe uses `checkpatch.pl --strict`, right Felipe?

Hi,
Yes. That seems to be the case. I will add a couple of simple comments. I will send a final patch (patch #10)which will fix these minor things which Filipe reported.I do not want to rebase any of my patches again :)

Regards,
Madhu

- Anand

