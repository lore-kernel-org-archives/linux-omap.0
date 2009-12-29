From: "Shilimkar, Santosh" <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
Subject: RE: [RESUBMIT][PATCH-v2][RFC] OMAP4: I2C Support for OMAP4430
Date: Tue, 29 Dec 2009 10:43:52 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C017A11E@dbde02.ent.ti.com>
References: <44891.192.168.10.89.1260254659.squirrel@dbdmail.itg.ti.com>
 <61140.192.168.10.88.1260879511.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <61140.192.168.10.88.1260879511.squirrel-pJFUjGLopx31T2qfsofKZtBPR1lH4CV8@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Syed, Rafiuddin" <rafiuddin.syed-l0cyMroinI0@public.gmane.org>, Ben Dooks <ben-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>
Cc: "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Ben,

> -----Original Message-----
> From: linux-arm-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org [mailto:linux-arm-kernel-
> bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org] On Behalf Of Syed, Rafiuddin
> Sent: Tuesday, December 15, 2009 5:49 PM
> To: Ben Dooks
> Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; ben-
> linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
> Subject: Re: [RESUBMIT][PATCH-v2][RFC] OMAP4: I2C Support for OMAP4430
> 
> Ben,
> 
> >>
> >> Thu, 20 Aug 2009 14:19:04 -0700
> >>
> >> On Tue, Aug 18, 2009 at 03:35:31PM +0530, Syed Rafiuddin wrote:
> >> > Ben,
> >> >
> >> > > On Fri, Jul 24, 2009 at 04:40:02PM +0530, Syed Rafiuddin wrote:
> >> > >> Hi Ben,
> >> > >>
> >> > >> > This patch adds OMAP4 support to the I2C driver. All I2C register
> >> > >> > addresses  are different
> >> > >> between
> >> > >> > OMAP1/2/3 and OMAP4. In order to not have #ifdef's at  various places in
> >> > >> > code, as well as to
> >> > >> > support multi-OMAP build, Array's are  created to hold the register
> >> > >> > addresses.
> >> > >> >
> >> > >> > Signed-off-by: Syed Rafiuddin <rafiuddin.s...-l0cyMroinI0@public.gmane.org>
> >> > >> > ---
> >> > >>
> >> > >> No comment received on this patch,
> >> > >> Is there anything that I need to resolve?
> >> > >> Else can this patch get merged.
> >> > >
> >> > > sorry, been busy, will look at this in the next few days.
> >> >
> >> > Seems like no issues with the patch since no comments received from long time.
> >> > Did you get a chance to look at the patch.Could you please merge this.
> >>
> >> I can't currently think of any neater way of doing this, so i'll
> >> probably merge this.
> >
> > I do not see this patch merged. Is there some thing that needs to be resolved in this patch.
> > Else can you please merge this patch.
> >
> Did you get a chance to look into the patch ? If patch is fine please merge this.

Haven't seen any response on this patch. Do you want a rebased version ?

Thanks!!

Regards,
Santosh
