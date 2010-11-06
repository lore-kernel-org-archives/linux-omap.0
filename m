From: Ionut Nicu <ionut.nicu@mindbit.ro>
Subject: Re: [PATCH v2 06/12] staging: tidspbridge: convert core to
 list_head
Date: Sat, 06 Nov 2010 19:31:43 +0200
Message-ID: <1289064703.9931.49.camel@atlantis.mindbit.ro>
References: <1288969996-22103-1-git-send-email-ionut.nicu@mindbit.ro>
	 <1288969996-22103-7-git-send-email-ionut.nicu@mindbit.ro>
	 <AANLkTinEa8y1AfeNDKa6gDcDoL-s6BKU_RLyr4BRUDDJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns.mindbit.ro ([80.86.127.26]:54893 "EHLO ns.mindbit.ro"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751232Ab0KFRbx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 6 Nov 2010 13:31:53 -0400
In-Reply-To: <AANLkTinEa8y1AfeNDKa6gDcDoL-s6BKU_RLyr4BRUDDJ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Sapiens, Rene" <rene.sapiens@ti.com>
Cc: Ionut Nicu <ionut.nicu@gmail.com>, Greg Kroah-Hartman <greg@kroah.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Fernando Guzman Lugo <x0095840@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, linux-omap <linux-omap@vger.kernel.org>

Hi Rene,

On Fri, 2010-11-05 at 16:12 -0600, Sapiens, Rene wrote:
> Hi Ionut,
> 
> On Fri, Nov 5, 2010 at 9:13 AM, Ionut Nicu <ionut.nicu@gmail.com> wrote:
> > Convert the core module of the tidspbridge driver
> > to use struct list_head instead of struct lst_list.
> >
> > Signed-off-by: Ionut Nicu <ionut.nicu@mindbit.ro>
> 
> <snip>
> 
> > diff --git a/drivers/staging/tidspbridge/core/io_sm.c b/drivers/staging/tidspbridge/core/io_sm.c
> > index 194bada..9851f32 100644
> > --- a/drivers/staging/tidspbridge/core/io_sm.c
> > +++ b/drivers/staging/tidspbridge/core/io_sm.c
> 
> <snip>
> 
> > @@ -1106,47 +1103,38 @@ static void input_msg(struct io_mgr *pio_mgr, struct msg_mgr *hmsg_mgr)
> >                                         * queued.
> >                                         */
> >                                        (*hmsg_mgr->on_exit) ((void *)
> > -                                                          msg_queue_obj->arg,
> > -                                                          msg.msg.dw_arg1);
> > +                                                       msg_queue_obj->arg,
> > +                                                       msg.msg.dw_arg1);
> > +                                       break;
> > +                               }
> > +                               /*
> > +                                * Not an exit acknowledgement, queue
> > +                                * the message.
> > +                                */
> > +                               if (!list_empty(&msg_queue_obj->msg_free_list)) {
> 
> You are going beyond the 80 chars.
> 

I thought about it too when using scripts/checkpatch.pl on this patch.
The thing is that it's 81 chars and breaking it into two lines makes it
look uglier. Also, this gets fixed in patch 10/12 (core code cleanup).

Regards,
Ionut.

