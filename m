From: "Sapiens, Rene" <rene.sapiens@ti.com>
Subject: Re: [PATCH v2 08/12] staging: tidspbridge: convert rmgr to list_head
Date: Mon, 8 Nov 2010 13:18:53 -0600
Message-ID: <AANLkTikGkgvFDCGbB869ft6oJRETk_4YOgM3+nuZhJ8N@mail.gmail.com>
References: <1288969996-22103-1-git-send-email-ionut.nicu@mindbit.ro>
	<1288969996-22103-9-git-send-email-ionut.nicu@mindbit.ro>
	<AANLkTinvM3W1WRNjw8zd=Yi6_J6uEw-h0efLjMrndCgn@mail.gmail.com>
	<1289067507.9931.95.camel@atlantis.mindbit.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:34675 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751791Ab0KHTSy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 8 Nov 2010 14:18:54 -0500
Received: by mail-gw0-f48.google.com with SMTP id 15so389341gwj.7
        for <linux-omap@vger.kernel.org>; Mon, 08 Nov 2010 11:18:54 -0800 (PST)
In-Reply-To: <1289067507.9931.95.camel@atlantis.mindbit.ro>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ionut Nicu <ionut.nicu@mindbit.ro>
Cc: Ionut Nicu <ionut.nicu@gmail.com>, Greg Kroah-Hartman <greg@kroah.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Fernando Guzman Lugo <x0095840@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, linux-omap <linux-omap@vger.kernel.org>

Hi Ionut,

On Sat, Nov 6, 2010 at 12:18 PM, Ionut Nicu <ionut.nicu@mindbit.ro> wro=
te:
> Hi Rene,
>
> On Fri, 2010-11-05 at 18:07 -0600, Sapiens, Rene wrote:
>> Hi Ionut,
>>
>> On Fri, Nov 5, 2010 at 9:13 AM, Ionut Nicu <ionut.nicu@gmail.com> wr=
ote:
>> > Convert the rmgr module of the tidspbridge driver
>> > to use struct list_head instead of struct lst_list.
>> >
>> > Signed-off-by: Ionut Nicu <ionut.nicu@mindbit.ro>
>>
>> <snip>
>>
>> > diff --git a/drivers/staging/tidspbridge/rmgr/drv.c b/drivers/stag=
ing/tidspbridge/rmgr/drv.c
>>
>> <snip>
>>
>> > @@ -492,16 +465,17 @@ u32 drv_get_next_dev_object(u32 hdev_obj)
>> > =A0 =A0 =A0 =A0u32 dw_next_dev_object =3D 0;
>> > =A0 =A0 =A0 =A0struct drv_object *pdrv_obj;
>> > =A0 =A0 =A0 =A0struct drv_data *drv_datap =3D dev_get_drvdata(brid=
ge);
>> > + =A0 =A0 =A0 struct list_head *curr;
>> >
>> > =A0 =A0 =A0 =A0DBC_REQUIRE(hdev_obj !=3D 0);
>>
>> can we remove the DBC_REQUIRE and always check for !hdev_obj?
>>
>
> Sounds ok to me.
>
> As a general remark, I personally think that the DBC_* macros should =
be
> replaced with BUG_ON, WARN_ON, but that's a subject for other patches=
=2E
> What do you think?
>

I think that the idea is to remove all DBC_REQUIRE/DBC_ASSERT and
use a real check of values when needed, or in the case use the Greg's
and Nishanth Menon's advices.

>> >
>> > =A0 =A0 =A0 =A0if (drv_datap && drv_datap->drv_object) {
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pdrv_obj =3D drv_datap->drv_object;
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((pdrv_obj->dev_list !=3D NULL) &=
&
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !LST_IS_EMPTY(pdrv_obj->dev_=
list)) {
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dw_next_dev_object =3D=
 (u32) lst_next(pdrv_obj->dev_list,
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (struct list_head *=
)
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hdev_obj);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!list_empty(&pdrv_obj->dev_list)=
) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 curr =3D (struct lis=
t_head *)hdev_obj;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (curr->next =3D=3D=
 &pdrv_obj->dev_list)
>>
>> Can we use list_is_last() instead?
>>
>
> Good point. I'll fix this.
>
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 retu=
rn 0;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dw_next_dev_object =3D=
 (u32) curr->next;
>>
>> <snip>
>>
>> > @@ -573,11 +548,8 @@ int drv_insert_dev_object(struct drv_object *=
driver_obj,
>> > =A0 =A0 =A0 =A0DBC_REQUIRE(refs > 0);
>> > =A0 =A0 =A0 =A0DBC_REQUIRE(hdev_obj !=3D NULL);
>> > =A0 =A0 =A0 =A0DBC_REQUIRE(pdrv_object);
>> > - =A0 =A0 =A0 DBC_ASSERT(pdrv_object->dev_list);
>> > -
>>
>> As a comment for all the functions that are manipulating lists, can =
we
>> check the parameters that they receive?, this applies for some other
>> functions in these patches, old lst_* functions were internally vali=
dating
>> the having of a valid pointer, now i think that we have to add this =
to each
>> function.
>>
>
> I don't think we need to put extra checks. The list head pointer will
> never be null and I don't see any use cases where the list_head
> container structure can be null...
>

I mean use the 'checks' only where needed, for this case you are right
it seems that callers of this function ensure that the pointers
are not null.

I'm just worried about a hidden scenario where there could be a call to=
 one
of this functions with a NULL pointer, i.e. lst_put_tail was checking f=
irst for
the having of a valid pointer and then it was accessing its element, no=
w
we don' have this, so, care should be taken to do not dereference a NUL=
L
pointer.


>> > - =A0 =A0 =A0 lst_put_tail(pdrv_object->dev_list, (struct list_hea=
d *)hdev_obj);
>> >
>> > - =A0 =A0 =A0 DBC_ENSURE(!LST_IS_EMPTY(pdrv_object->dev_list));
>> > + =A0 =A0 =A0 list_add_tail((struct list_head *)hdev_obj, &pdrv_ob=
ject->dev_list);
>>
>> <snip>
>>
>> > @@ -1571,15 +1566,9 @@ int node_enum_nodes(struct node_mgr *hnode_=
mgr, void **node_tab,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*pu_num_nodes =3D 0;
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0status =3D -EINVAL;
>> > =A0 =A0 =A0 =A0} else {
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 hnode =3D (struct node_object *)lst_=
first(hnode_mgr->
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 node_list);
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < hnode_mgr->num_nod=
es; i++) {
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DBC_ASSERT(hnode);
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 node_tab[i] =3D hnod=
e;
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hnode =3D (struct no=
de_object *)lst_next
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (hno=
de_mgr->node_list,
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (str=
uct list_head *)hnode);
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 i =3D 0;
>>
>> just a comment, what if we initialize this "i" when declared and
>> remove this line.
>>
>
> Ok, will do.
>
>
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_for_each_entry(hnode, &hnode_mg=
r->node_list, list_elem)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 node_tab[i++] =3D hn=
ode;
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*pu_allocated =3D *pu_num_nodes =3D=
 hnode_mgr->num_nodes;
>> > =A0 =A0 =A0 =A0}
>>
>> <snip>
>>
>> > diff --git a/drivers/staging/tidspbridge/rmgr/rmm.c b/drivers/stag=
ing/tidspbridge/rmgr/rmm.c
>>
>> <snip>
>>
>> > @@ -145,20 +141,17 @@ int rmm_alloc(struct rmm_target_obj *target,=
 u32 segid, u32 size,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (new_sect =3D=3D NULL) {
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0status =3D -ENOMEM;
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 lst_init_elem((struc=
t list_head *)new_sect);
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0new_sect->addr =3D =
addr;
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0new_sect->size =3D =
size;
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0new_sect->page =3D =
segid;
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (sect =3D=3D NULL=
) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (sect =3D=3D NULL=
)
>>
>> I think that "sect" can't be NULL at this point... can be?
>> can we use: if (list_is_last(&sect->list_elem, target->ovly_list)) i=
nstead?
>>
>
> Yes, you are right.
>
>
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* =
Put new section at the end of the list */
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 lst_=
put_tail(target->ovly_list,
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0(struct list_head *)new_sect);
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 list=
_add_tail(&new_sect->list_elem,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 &target->ovly_list);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
>>
>> <snip>
>>
>> > @@ -333,24 +316,17 @@ bool rmm_free(struct rmm_target_obj *target,=
 u32 segid, u32 dsp_addr, u32 size,
>> >
>> > =A0 =A0 =A0 =A0} else {
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Unreserve memory */
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 sect =3D (struct rmm_ovly_sect *)lst=
_first(target->ovly_list);
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (sect !=3D NULL) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_for_each_entry_safe(sect, tmp, =
&target->ovly_list,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 list=
_elem) {
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (dsp_addr =3D=3D=
 sect->addr) {
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DBC=
_ASSERT(size =3D=3D sect->size);
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* =
Remove from list */
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 lst_=
remove_elem(target->ovly_list,
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 (struct list_head *)sect);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 list=
_del(&sect->list_elem);
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0kfr=
ee(sect);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =
=3D true;
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bre=
ak;
>>
>> can we just return true and do not break?
>
> Sure, I will change this.
>
> Regards,
> Ionut.
>
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
