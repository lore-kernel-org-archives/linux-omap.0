From: Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: Re: Patch series in Tarball submitted (RE: [REVIEW PATCH 00/14]
 OMAP3 camera + ISP + MT9P012 sensor driver v2)
Date: Wed, 14 Jan 2009 13:55:24 -0200
Message-ID: <20090114135524.0f51a82d@pedra.chehab.org>
References: <19F8576C6E063C45BE387C64729E739403ECF70CEB@dbde02.ent.ti.com>
	<A24693684029E5489D1D202277BE8944164DFC34@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <A24693684029E5489D1D202277BE8944164DFC34@dlee02.ent.ti.com>
Sender: linux-media-owner@vger.kernel.org
To: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Cc: "Hiremath, Vaibhav" <hvaibhav@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, "video4linux-list@redhat.com" <video4linux-list@redhat.com>, Sakari Ailus <sakari.ailus@nokia.com>, "Tuukka.O Toivonen" <tuukka.o.toivonen@nokia.com>, "Nagalla, Hari" <hnagalla@ti.com>
List-Id: linux-omap@vger.kernel.org

On Wed, 14 Jan 2009 08:55:08 -0600
"Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com> wrote:

> 
> 
> > -----Original Message-----
> > From: Hiremath, Vaibhav
> > Sent: Wednesday, January 14, 2009 8:51 AM
> 
> <snip>
> 
> > [Hiremath, Vaibhav] I tried to build camera driver as module and got
> > following error -
> > 
> > ERROR: "ispmmu_get_mapeable_space" [drivers/media/video/omap34xxcam.ko]
> > undefined!
> > make[1]: *** [__modpost] Error 1
> > make: *** [modules] Error 2
> > 
> > You have missed to export this symbol, please correct in next version of
> > patches.
> > 
> 
> Oops, good catch. Thanks, I'll correct that. No problem.

Better to wait a little bit before posting the new version... I'm still
analyzing the current posting. 

It would be useful if you could document the private ioctls you've added, to
help me to better analyse the remaining patches.


Cheers,
Mauro
