From: Ionut Nicu <ionut.nicu@mindbit.ro>
Subject: Re: [PATCH v2 06/12] staging: tidspbridge: convert core to
 list_head
Date: Sat, 06 Nov 2010 19:21:23 +0200
Message-ID: <1289064083.9931.43.camel@atlantis.mindbit.ro>
References: <1288969996-22103-1-git-send-email-ionut.nicu@mindbit.ro>
	 <1288969996-22103-7-git-send-email-ionut.nicu@mindbit.ro>
	 <AANLkTim+W3dn1j6SnVS6gc=aeZ0pH+VjSn+YiSJLangz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns.mindbit.ro ([80.86.127.26]:60127 "EHLO ns.mindbit.ro"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751192Ab0KFRVg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 6 Nov 2010 13:21:36 -0400
In-Reply-To: <AANLkTim+W3dn1j6SnVS6gc=aeZ0pH+VjSn+YiSJLangz@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Sapiens, Rene" <rene.sapiens@ti.com>
Cc: Ionut Nicu <ionut.nicu@gmail.com>, Greg Kroah-Hartman <greg@kroah.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Fernando Guzman Lugo <x0095840@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, linux-omap <linux-omap@vger.kernel.org>

Hi Rene,

On Fri, 2010-11-05 at 15:07 -0600, Sapiens, Rene wrote:
> Hi Ionut,
> 
> On Fri, Nov 5, 2010 at 9:13 AM, Ionut Nicu <ionut.nicu@gmail.com> wrote:
> > Convert the core module of the tidspbridge driver
> > to use struct list_head instead of struct lst_list.
> >
> 
> <snip>
> 
> >        if (!status) {
> >                /* Get a free chirp: */
> > -               chnl_packet_obj =
> > -                   (struct chnl_irp *)lst_get_head(pchnl->free_packets_list);
> > -               if (chnl_packet_obj == NULL)
> > +               if (!list_empty(&pchnl->free_packets_list)) {
> > +                       chnl_packet_obj = list_first_entry(
> > +                                       &pchnl->free_packets_list,
> > +                                       struct chnl_irp, link);
> > +                       list_del(&chnl_packet_obj->link);
> > +               } else
> >                        status = -EIO;
> 
> What do you think if we close the braces, since the first conditional
> has more than one statement?
> 

Can you clarify? I don't think I understand which brace we need to close
here.

> <snip>
> 
> > @@ -286,18 +286,16 @@ int bridge_chnl_cancel_io(struct chnl_object *chnl_obj)
> >                }
> >        }
> >        /* Move all IOR's to IOC queue: */
> > -       while (!LST_IS_EMPTY(pchnl->pio_requests)) {
> > -               chnl_packet_obj =
> > -                   (struct chnl_irp *)lst_get_head(pchnl->pio_requests);
> > -               if (chnl_packet_obj) {
> > -                       chnl_packet_obj->byte_size = 0;
> > -                       chnl_packet_obj->status |= CHNL_IOCSTATCANCEL;
> > -                       lst_put_tail(pchnl->pio_completions,
> > -                                    (struct list_head *)chnl_packet_obj);
> > -                       pchnl->cio_cs++;
> > -                       pchnl->cio_reqs--;
> > -                       DBC_ASSERT(pchnl->cio_reqs >= 0);
> > -               }
> > +       while (!list_empty(&pchnl->pio_requests)) {
> > +               chnl_packet_obj = list_first_entry(&pchnl->pio_requests,
> > +                               struct chnl_irp, link);
> > +               list_del(&chnl_packet_obj->link);
> > +               chnl_packet_obj->byte_size = 0;
> > +               chnl_packet_obj->status |= CHNL_IOCSTATCANCEL;
> > +               list_add_tail(&chnl_packet_obj->link, &pchnl->pio_completions);
> > +               pchnl->cio_cs++;
> > +               pchnl->cio_reqs--;
> > +               DBC_ASSERT(pchnl->cio_reqs >= 0);
> 
> Why don't we use list_for_each_entry_safe() instead?
> 

Agreed, it will look better.


> >        }
> >  func_cont:
> >        spin_unlock_bh(&chnl_mgr_obj->chnl_mgr_lock);
> 
> <snip>
> 
> > @@ -818,9 +804,19 @@ int bridge_chnl_open(struct chnl_object **chnl,
> >        /* Protect queues from io_dpc: */
> >        pchnl->dw_state = CHNL_STATECANCEL;
> >        /* Allocate initial IOR and IOC queues: */
> > -       pchnl->free_packets_list = create_chirp_list(pattrs->uio_reqs);
> > -       pchnl->pio_requests = create_chirp_list(0);
> > -       pchnl->pio_completions = create_chirp_list(0);
> > +       status = create_chirp_list(&pchnl->free_packets_list,
> > +                       pattrs->uio_reqs);
> > +       if (status)
> > +               goto func_end;
> > +
> > +       status = create_chirp_list(&pchnl->pio_requests, 0);
> > +       if (status)
> > +               goto func_end;
> > +
> > +       status = create_chirp_list(&pchnl->pio_completions, 0);
> > +       if (status)
> > +               goto func_end;
> > +
> 
> With these goto you are not freeing the memory allocated for pchnl, please free
> it at func_end.
> 

Thanks for catching this. Freeing it at func_end is not a very good
idea, because it's also freed above. 

What do you think if I replace the last two calls for
create_chirp_list() with just INIT_LIST_HEAD()? This way we'll have only
one error check where we'll also kfree(pchnl) and we'll have 2 less
un-necessary function calls / error checks.

Regards,
Ionut.

