From: Ionut Nicu <ionut.nicu@mindbit.ro>
Subject: Re: [PATCH v2 08/12] staging: tidspbridge: convert rmgr to
 list_head
Date: Sat, 06 Nov 2010 20:18:27 +0200
Message-ID: <1289067507.9931.95.camel@atlantis.mindbit.ro>
References: <1288969996-22103-1-git-send-email-ionut.nicu@mindbit.ro>
	 <1288969996-22103-9-git-send-email-ionut.nicu@mindbit.ro>
	 <AANLkTinvM3W1WRNjw8zd=Yi6_J6uEw-h0efLjMrndCgn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns.mindbit.ro ([80.86.127.26]:38868 "EHLO ns.mindbit.ro"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751629Ab0KFSSi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 6 Nov 2010 14:18:38 -0400
In-Reply-To: <AANLkTinvM3W1WRNjw8zd=Yi6_J6uEw-h0efLjMrndCgn@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Sapiens, Rene" <rene.sapiens@ti.com>
Cc: Ionut Nicu <ionut.nicu@gmail.com>, Greg Kroah-Hartman <greg@kroah.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Fernando Guzman Lugo <x0095840@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, linux-omap <linux-omap@vger.kernel.org>

Hi Rene,

On Fri, 2010-11-05 at 18:07 -0600, Sapiens, Rene wrote:
> Hi Ionut,
> 
> On Fri, Nov 5, 2010 at 9:13 AM, Ionut Nicu <ionut.nicu@gmail.com> wrote:
> > Convert the rmgr module of the tidspbridge driver
> > to use struct list_head instead of struct lst_list.
> >
> > Signed-off-by: Ionut Nicu <ionut.nicu@mindbit.ro>
> 
> <snip>
> 
> > diff --git a/drivers/staging/tidspbridge/rmgr/drv.c b/drivers/staging/tidspbridge/rmgr/drv.c
> 
> <snip>
> 
> > @@ -492,16 +465,17 @@ u32 drv_get_next_dev_object(u32 hdev_obj)
> >        u32 dw_next_dev_object = 0;
> >        struct drv_object *pdrv_obj;
> >        struct drv_data *drv_datap = dev_get_drvdata(bridge);
> > +       struct list_head *curr;
> >
> >        DBC_REQUIRE(hdev_obj != 0);
> 
> can we remove the DBC_REQUIRE and always check for !hdev_obj?
> 

Sounds ok to me.

As a general remark, I personally think that the DBC_* macros should be
replaced with BUG_ON, WARN_ON, but that's a subject for other patches.
What do you think? 

> >
> >        if (drv_datap && drv_datap->drv_object) {
> >                pdrv_obj = drv_datap->drv_object;
> > -               if ((pdrv_obj->dev_list != NULL) &&
> > -                   !LST_IS_EMPTY(pdrv_obj->dev_list)) {
> > -                       dw_next_dev_object = (u32) lst_next(pdrv_obj->dev_list,
> > -                                                           (struct list_head *)
> > -                                                           hdev_obj);
> > +               if (!list_empty(&pdrv_obj->dev_list)) {
> > +                       curr = (struct list_head *)hdev_obj;
> > +                       if (curr->next == &pdrv_obj->dev_list)
> 
> Can we use list_is_last() instead?
> 

Good point. I'll fix this.

> > +                               return 0;
> > +                       dw_next_dev_object = (u32) curr->next;
> 
> <snip>
> 
> > @@ -573,11 +548,8 @@ int drv_insert_dev_object(struct drv_object *driver_obj,
> >        DBC_REQUIRE(refs > 0);
> >        DBC_REQUIRE(hdev_obj != NULL);
> >        DBC_REQUIRE(pdrv_object);
> > -       DBC_ASSERT(pdrv_object->dev_list);
> > -
> 
> As a comment for all the functions that are manipulating lists, can we
> check the parameters that they receive?, this applies for some other
> functions in these patches, old lst_* functions were internally validating
> the having of a valid pointer, now i think that we have to add this to each
> function.
> 

I don't think we need to put extra checks. The list head pointer will
never be null and I don't see any use cases where the list_head
container structure can be null...

> > -       lst_put_tail(pdrv_object->dev_list, (struct list_head *)hdev_obj);
> >
> > -       DBC_ENSURE(!LST_IS_EMPTY(pdrv_object->dev_list));
> > +       list_add_tail((struct list_head *)hdev_obj, &pdrv_object->dev_list);
> 
> <snip>
> 
> > @@ -1571,15 +1566,9 @@ int node_enum_nodes(struct node_mgr *hnode_mgr, void **node_tab,
> >                *pu_num_nodes = 0;
> >                status = -EINVAL;
> >        } else {
> > -               hnode = (struct node_object *)lst_first(hnode_mgr->
> > -                       node_list);
> > -               for (i = 0; i < hnode_mgr->num_nodes; i++) {
> > -                       DBC_ASSERT(hnode);
> > -                       node_tab[i] = hnode;
> > -                       hnode = (struct node_object *)lst_next
> > -                               (hnode_mgr->node_list,
> > -                               (struct list_head *)hnode);
> > -               }
> > +               i = 0;
> 
> just a comment, what if we initialize this "i" when declared and
> remove this line.
> 

Ok, will do.


> > +               list_for_each_entry(hnode, &hnode_mgr->node_list, list_elem)
> > +                       node_tab[i++] = hnode;
> >                *pu_allocated = *pu_num_nodes = hnode_mgr->num_nodes;
> >        }
> 
> <snip>
> 
> > diff --git a/drivers/staging/tidspbridge/rmgr/rmm.c b/drivers/staging/tidspbridge/rmgr/rmm.c
> 
> <snip>
> 
> > @@ -145,20 +141,17 @@ int rmm_alloc(struct rmm_target_obj *target, u32 segid, u32 size,
> >                if (new_sect == NULL) {
> >                        status = -ENOMEM;
> >                } else {
> > -                       lst_init_elem((struct list_head *)new_sect);
> >                        new_sect->addr = addr;
> >                        new_sect->size = size;
> >                        new_sect->page = segid;
> > -                       if (sect == NULL) {
> > +                       if (sect == NULL)
> 
> I think that "sect" can't be NULL at this point... can be?
> can we use: if (list_is_last(&sect->list_elem, target->ovly_list)) instead?
> 

Yes, you are right.


> >                                /* Put new section at the end of the list */
> > -                               lst_put_tail(target->ovly_list,
> > -                                            (struct list_head *)new_sect);
> > -                       } else {
> > +                               list_add_tail(&new_sect->list_elem,
> > +                                               &target->ovly_list);
> > +                       else
> 
> <snip>
> 
> > @@ -333,24 +316,17 @@ bool rmm_free(struct rmm_target_obj *target, u32 segid, u32 dsp_addr, u32 size,
> >
> >        } else {
> >                /* Unreserve memory */
> > -               sect = (struct rmm_ovly_sect *)lst_first(target->ovly_list);
> > -               while (sect != NULL) {
> > +               list_for_each_entry_safe(sect, tmp, &target->ovly_list,
> > +                               list_elem) {
> >                        if (dsp_addr == sect->addr) {
> >                                DBC_ASSERT(size == sect->size);
> >                                /* Remove from list */
> > -                               lst_remove_elem(target->ovly_list,
> > -                                               (struct list_head *)sect);
> > +                               list_del(&sect->list_elem);
> >                                kfree(sect);
> > +                               ret = true;
> >                                break;
> 
> can we just return true and do not break?

Sure, I will change this.

Regards,
Ionut.


