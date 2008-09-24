From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH 7/9]HDQ driver:replace semaphore with mutex
Date: Wed, 24 Sep 2008 18:35:57 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02D5DC8C55@dbde02.ent.ti.com>
References: <56530.192.168.10.89.1222255887.squirrel@dbdmail.itg.ti.com>
 <20080924115031.GO24627@gandalf.research.nokia.com>
 <020a01c91e45$838ecb80$LocalHost@wipultra1303>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39522 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750875AbYIXNHF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Sep 2008 09:07:05 -0400
In-Reply-To: <020a01c91e45$838ecb80$LocalHost@wipultra1303>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "johnpol@2ka.mipt.ru" <johnpol@2ka.mipt.ru>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

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

- Anand
