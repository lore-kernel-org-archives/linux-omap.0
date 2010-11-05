From: "Sapiens, Rene" <rene.sapiens@ti.com>
Subject: Re: [PATCH v2 07/12] staging: tidspbridge: convert pmgr to list_head
Date: Fri, 5 Nov 2010 16:41:43 -0600
Message-ID: <AANLkTin7qBbn4jZrKSivPUYUAkN2cS-3cyQOeFuowUp7@mail.gmail.com>
References: <1288969996-22103-1-git-send-email-ionut.nicu@mindbit.ro>
	<1288969996-22103-8-git-send-email-ionut.nicu@mindbit.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:36973 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753399Ab0KEWmg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 5 Nov 2010 18:42:36 -0400
Received: by wwi18 with SMTP id 18so300814wwi.2
        for <linux-omap@vger.kernel.org>; Fri, 05 Nov 2010 15:41:44 -0700 (PDT)
In-Reply-To: <1288969996-22103-8-git-send-email-ionut.nicu@mindbit.ro>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ionut Nicu <ionut.nicu@gmail.com>
Cc: Greg Kroah-Hartman <greg@kroah.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Fernando Guzman Lugo <x0095840@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, linux-omap <linux-omap@vger.kernel.org>, Ionut Nicu <ionut.nicu@mindbit.ro>

Hi Ionut,

On Fri, Nov 5, 2010 at 9:13 AM, Ionut Nicu <ionut.nicu@gmail.com> wrote=
:
> Convert the pmgr module of the tidspbridge driver
> to use struct list_head instead of struct lst_list.

<snip>

> + * Memory is coalesced back to the appropriate heap when a buffer is

What is being fixed here?

> =A0* freed.
> =A0*
> =A0* Notes:

<snip>

> @@ -833,67 +768,44 @@ static void add_to_free_list(struct cmm_allocat=
or *allocator,
> =A0 =A0 =A0 =A0DBC_REQUIRE(allocator !=3D NULL);
> =A0 =A0 =A0 =A0dw_this_pa =3D pnode->dw_pa;
> =A0 =A0 =A0 =A0dw_next_pa =3D NEXT_PA(pnode);

i think it would be good to return with error if !allocator or !pnode
and remove the	resulting duplicated DBC_REQUIRE.

> - =A0 =A0 =A0 mnode_obj =3D (struct cmm_mnode *)lst_first(allocator->=
free_list_head);
> - =A0 =A0 =A0 while (mnode_obj) {
> + =A0 =A0 =A0 list_for_each_entry(mnode_obj, &allocator->free_list, l=
ink) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (dw_this_pa =3D=3D NEXT_PA(mnode_ob=
j)) {

<snip>

> @@ -748,18 +736,16 @@ bool dev_init(void)
> =A0*/
> =A0int dev_notify_clients(struct dev_object *hdev_obj, u32 ret)
> =A0{
> - =A0 =A0 =A0 int status =3D 0;
> -
> =A0 =A0 =A0 =A0struct dev_object *dev_obj =3D hdev_obj;
> - =A0 =A0 =A0 void *proc_obj;
> + =A0 =A0 =A0 struct list_head *curr;

can we add a check for !dev_obj and !dev_obj->proc_list just to be
sure that we get always the correct pointer?

<snip>

> @@ -947,15 +933,17 @@ int dev_insert_proc_object(struct dev_object *h=
dev_obj,
> =A0 =A0 =A0 =A0DBC_REQUIRE(refs > 0);
> =A0 =A0 =A0 =A0DBC_REQUIRE(dev_obj);
> =A0 =A0 =A0 =A0DBC_REQUIRE(proc_obj !=3D 0);
> - =A0 =A0 =A0 DBC_REQUIRE(dev_obj->proc_list !=3D NULL);
> =A0 =A0 =A0 =A0DBC_REQUIRE(already_attached !=3D NULL);

can we check for !hdev_obj, !already_attached even if we have the
DBC_REQUIRE?, maybe we can actually remove the DBC_REQUIRE that could
be redundant after applying this.

> - =A0 =A0 =A0 if (!LST_IS_EMPTY(dev_obj->proc_list))
> + =A0 =A0 =A0 if (!list_empty(&dev_obj->proc_list))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*already_attached =3D true;

<snip>

> @@ -986,15 +974,12 @@ int dev_remove_proc_object(struct dev_object *h=
dev_obj, u32 proc_obj)
>
> =A0 =A0 =A0 =A0DBC_REQUIRE(dev_obj);
> =A0 =A0 =A0 =A0DBC_REQUIRE(proc_obj !=3D 0);
> - =A0 =A0 =A0 DBC_REQUIRE(dev_obj->proc_list !=3D NULL);
> - =A0 =A0 =A0 DBC_REQUIRE(!LST_IS_EMPTY(dev_obj->proc_list));
> + =A0 =A0 =A0 DBC_REQUIRE(!list_empty(&dev_obj->proc_list));
>

 The same comment as above.

Regards,
Rene
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
