From: "Sapiens, Rene" <rene.sapiens@ti.com>
Subject: Re: [PATCH v2 08/12] staging: tidspbridge: convert rmgr to list_head
Date: Fri, 5 Nov 2010 18:07:54 -0600
Message-ID: <AANLkTinvM3W1WRNjw8zd=Yi6_J6uEw-h0efLjMrndCgn@mail.gmail.com>
References: <1288969996-22103-1-git-send-email-ionut.nicu@mindbit.ro>
	<1288969996-22103-9-git-send-email-ionut.nicu@mindbit.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:57628 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753704Ab0KFAH6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 5 Nov 2010 20:07:58 -0400
Received: by mail-ww0-f51.google.com with SMTP id 17so1675423wwi.20
        for <linux-omap@vger.kernel.org>; Fri, 05 Nov 2010 17:07:55 -0700 (PDT)
In-Reply-To: <1288969996-22103-9-git-send-email-ionut.nicu@mindbit.ro>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ionut Nicu <ionut.nicu@gmail.com>
Cc: Greg Kroah-Hartman <greg@kroah.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Fernando Guzman Lugo <x0095840@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, linux-omap <linux-omap@vger.kernel.org>, Ionut Nicu <ionut.nicu@mindbit.ro>

Hi Ionut,

On Fri, Nov 5, 2010 at 9:13 AM, Ionut Nicu <ionut.nicu@gmail.com> wrote=
:
> Convert the rmgr module of the tidspbridge driver
> to use struct list_head instead of struct lst_list.
>
> Signed-off-by: Ionut Nicu <ionut.nicu@mindbit.ro>

<snip>

> diff --git a/drivers/staging/tidspbridge/rmgr/drv.c b/drivers/staging=
/tidspbridge/rmgr/drv.c

<snip>

> @@ -492,16 +465,17 @@ u32 drv_get_next_dev_object(u32 hdev_obj)
> =A0 =A0 =A0 =A0u32 dw_next_dev_object =3D 0;
> =A0 =A0 =A0 =A0struct drv_object *pdrv_obj;
> =A0 =A0 =A0 =A0struct drv_data *drv_datap =3D dev_get_drvdata(bridge)=
;
> + =A0 =A0 =A0 struct list_head *curr;
>
> =A0 =A0 =A0 =A0DBC_REQUIRE(hdev_obj !=3D 0);

can we remove the DBC_REQUIRE and always check for !hdev_obj?

>
> =A0 =A0 =A0 =A0if (drv_datap && drv_datap->drv_object) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pdrv_obj =3D drv_datap->drv_object;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((pdrv_obj->dev_list !=3D NULL) &&
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !LST_IS_EMPTY(pdrv_obj->dev_lis=
t)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dw_next_dev_object =3D =
(u32) lst_next(pdrv_obj->dev_list,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (struct list_head *)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hdev_obj);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!list_empty(&pdrv_obj->dev_list)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 curr =3D (struct list_h=
ead *)hdev_obj;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (curr->next =3D=3D &=
pdrv_obj->dev_list)

Can we use list_is_last() instead?

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return =
0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dw_next_dev_object =3D =
(u32) curr->next;

<snip>

> @@ -573,11 +548,8 @@ int drv_insert_dev_object(struct drv_object *dri=
ver_obj,
> =A0 =A0 =A0 =A0DBC_REQUIRE(refs > 0);
> =A0 =A0 =A0 =A0DBC_REQUIRE(hdev_obj !=3D NULL);
> =A0 =A0 =A0 =A0DBC_REQUIRE(pdrv_object);
> - =A0 =A0 =A0 DBC_ASSERT(pdrv_object->dev_list);
> -

As a comment for all the functions that are manipulating lists, can we
check the parameters that they receive?, this applies for some other
functions in these patches, old lst_* functions were internally validat=
ing
the having of a valid pointer, now i think that we have to add this to =
each
function.

> - =A0 =A0 =A0 lst_put_tail(pdrv_object->dev_list, (struct list_head *=
)hdev_obj);
>
> - =A0 =A0 =A0 DBC_ENSURE(!LST_IS_EMPTY(pdrv_object->dev_list));
> + =A0 =A0 =A0 list_add_tail((struct list_head *)hdev_obj, &pdrv_objec=
t->dev_list);

<snip>

> @@ -1571,15 +1566,9 @@ int node_enum_nodes(struct node_mgr *hnode_mgr=
, void **node_tab,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*pu_num_nodes =3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0status =3D -EINVAL;
> =A0 =A0 =A0 =A0} else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 hnode =3D (struct node_object *)lst_fir=
st(hnode_mgr->
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 node_list);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < hnode_mgr->num_nodes;=
 i++) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DBC_ASSERT(hnode);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 node_tab[i] =3D hnode;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hnode =3D (struct node_=
object *)lst_next
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (hnode_=
mgr->node_list,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (struct=
 list_head *)hnode);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 i =3D 0;

just a comment, what if we initialize this "i" when declared and
remove this line.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_for_each_entry(hnode, &hnode_mgr->=
node_list, list_elem)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 node_tab[i++] =3D hnode=
;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*pu_allocated =3D *pu_num_nodes =3D hn=
ode_mgr->num_nodes;
> =A0 =A0 =A0 =A0}

<snip>

> diff --git a/drivers/staging/tidspbridge/rmgr/rmm.c b/drivers/staging=
/tidspbridge/rmgr/rmm.c

<snip>

> @@ -145,20 +141,17 @@ int rmm_alloc(struct rmm_target_obj *target, u3=
2 segid, u32 size,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (new_sect =3D=3D NULL) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0status =3D -ENOMEM;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 lst_init_elem((struct l=
ist_head *)new_sect);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0new_sect->addr =3D add=
r;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0new_sect->size =3D siz=
e;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0new_sect->page =3D seg=
id;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (sect =3D=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (sect =3D=3D NULL)

I think that "sect" can't be NULL at this point... can be?
can we use: if (list_is_last(&sect->list_elem, target->ovly_list)) inst=
ead?

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Put=
 new section at the end of the list */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 lst_put=
_tail(target->ovly_list,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0(struct list_head *)new_sect);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_ad=
d_tail(&new_sect->list_elem,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 &target->ovly_list);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else

<snip>

> @@ -333,24 +316,17 @@ bool rmm_free(struct rmm_target_obj *target, u3=
2 segid, u32 dsp_addr, u32 size,
>
> =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Unreserve memory */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 sect =3D (struct rmm_ovly_sect *)lst_fi=
rst(target->ovly_list);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (sect !=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_for_each_entry_safe(sect, tmp, &ta=
rget->ovly_list,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_el=
em) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (dsp_addr =3D=3D se=
ct->addr) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DBC_AS=
SERT(size =3D=3D sect->size);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Rem=
ove from list */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 lst_rem=
ove_elem(target->ovly_list,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 (struct list_head *)sect);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_de=
l(&sect->list_elem);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0kfree(=
sect);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D=
 true;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;

can we just return true and do not break?

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}

Regards,
Rene
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
