From: Ionut Nicu <ionut.nicu@mindbit.ro>
Subject: Re: [PATCH v2 07/12] staging: tidspbridge: convert pmgr to
 list_head
Date: Sun, 07 Nov 2010 15:39:10 +0200
Message-ID: <1289137150.9931.231.camel@atlantis.mindbit.ro>
References: <1288969996-22103-1-git-send-email-ionut.nicu@mindbit.ro>
	 <1288969996-22103-8-git-send-email-ionut.nicu@mindbit.ro>
	 <AANLkTin7qBbn4jZrKSivPUYUAkN2cS-3cyQOeFuowUp7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns.mindbit.ro ([80.86.127.26]:37831 "EHLO ns.mindbit.ro"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752904Ab0KGNjV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 7 Nov 2010 08:39:21 -0500
In-Reply-To: <AANLkTin7qBbn4jZrKSivPUYUAkN2cS-3cyQOeFuowUp7@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Sapiens, Rene" <rene.sapiens@ti.com>
Cc: Ionut Nicu <ionut.nicu@gmail.com>, Greg Kroah-Hartman <greg@kroah.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Fernando Guzman Lugo <x0095840@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, linux-omap <linux-omap@vger.kernel.org>

Hi Rene,

On Fri, 2010-11-05 at 16:41 -0600, Sapiens, Rene wrote:
> Hi Ionut,
> 
> On Fri, Nov 5, 2010 at 9:13 AM, Ionut Nicu <ionut.nicu@gmail.com> wrote:
> > Convert the pmgr module of the tidspbridge driver
> > to use struct list_head instead of struct lst_list.
> 
> <snip>
> 
> > + * Memory is coalesced back to the appropriate heap when a buffer is
> 
> What is being fixed here?
> 

It was a typo (s/coelesced/coalesced/).

> >  * freed.
> >  *
> >  * Notes:
> 
> <snip>
> 
> > @@ -833,67 +768,44 @@ static void add_to_free_list(struct cmm_allocator *allocator,
> >        DBC_REQUIRE(allocator != NULL);
> >        dw_this_pa = pnode->dw_pa;
> >        dw_next_pa = NEXT_PA(pnode);
> 
> i think it would be good to return with error if !allocator or !pnode
> and remove the	resulting duplicated DBC_REQUIRE.
> 

Yeah I think pnode should be checked for null. Can allocator ever be
null?

> > -       mnode_obj = (struct cmm_mnode *)lst_first(allocator->free_list_head);
> > -       while (mnode_obj) {
> > +       list_for_each_entry(mnode_obj, &allocator->free_list, link) {
> >                if (dw_this_pa == NEXT_PA(mnode_obj)) {
> 
> <snip>
> 
> > @@ -748,18 +736,16 @@ bool dev_init(void)
> >  */
> >  int dev_notify_clients(struct dev_object *hdev_obj, u32 ret)
> >  {
> > -       int status = 0;
> > -
> >        struct dev_object *dev_obj = hdev_obj;
> > -       void *proc_obj;
> > +       struct list_head *curr;
> 
> can we add a check for !dev_obj and !dev_obj->proc_list just to be
> sure that we get always the correct pointer?
> 

proc_list isn't a pointer. Can dev_obj ever be null?

> <snip>
> 
> > @@ -947,15 +933,17 @@ int dev_insert_proc_object(struct dev_object *hdev_obj,
> >        DBC_REQUIRE(refs > 0);
> >        DBC_REQUIRE(dev_obj);
> >        DBC_REQUIRE(proc_obj != 0);
> > -       DBC_REQUIRE(dev_obj->proc_list != NULL);
> >        DBC_REQUIRE(already_attached != NULL);
> 
> can we check for !hdev_obj, !already_attached even if we have the
> DBC_REQUIRE?, maybe we can actually remove the DBC_REQUIRE that could
> be redundant after applying this.
> 

Same question here.

> > -       if (!LST_IS_EMPTY(dev_obj->proc_list))
> > +       if (!list_empty(&dev_obj->proc_list))
> >                *already_attached = true;
> 
> <snip>
> 
> > @@ -986,15 +974,12 @@ int dev_remove_proc_object(struct dev_object *hdev_obj, u32 proc_obj)
> >
> >        DBC_REQUIRE(dev_obj);
> >        DBC_REQUIRE(proc_obj != 0);
> > -       DBC_REQUIRE(dev_obj->proc_list != NULL);
> > -       DBC_REQUIRE(!LST_IS_EMPTY(dev_obj->proc_list));
> > +       DBC_REQUIRE(!list_empty(&dev_obj->proc_list));
> >
> 
>  The same comment as above.
> 

Regards,
Ionut.

