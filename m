From: "Sapiens, Rene" <rene.sapiens@ti.com>
Subject: Re: [PATCH v2 07/12] staging: tidspbridge: convert pmgr to list_head
Date: Mon, 8 Nov 2010 13:17:19 -0600
Message-ID: <AANLkTim46tmBtL8jBC_Kv4G77ZtKE-U9Bfh4r86XtMcb@mail.gmail.com>
References: <1288969996-22103-1-git-send-email-ionut.nicu@mindbit.ro>
	<1288969996-22103-8-git-send-email-ionut.nicu@mindbit.ro>
	<AANLkTin7qBbn4jZrKSivPUYUAkN2cS-3cyQOeFuowUp7@mail.gmail.com>
	<1289137150.9931.231.camel@atlantis.mindbit.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:59095 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751715Ab0KHTRc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 8 Nov 2010 14:17:32 -0500
Received: by eya28 with SMTP id 28so3039010eya.6
        for <linux-omap@vger.kernel.org>; Mon, 08 Nov 2010 11:17:19 -0800 (PST)
In-Reply-To: <1289137150.9931.231.camel@atlantis.mindbit.ro>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ionut Nicu <ionut.nicu@mindbit.ro>
Cc: Ionut Nicu <ionut.nicu@gmail.com>, Greg Kroah-Hartman <greg@kroah.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Fernando Guzman Lugo <x0095840@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, linux-omap <linux-omap@vger.kernel.org>

Hi Ionut,

On Sun, Nov 7, 2010 at 7:39 AM, Ionut Nicu <ionut.nicu@mindbit.ro> wrot=
e:
> Hi Rene,
>
> On Fri, 2010-11-05 at 16:41 -0600, Sapiens, Rene wrote:
>> Hi Ionut,
>>
>> On Fri, Nov 5, 2010 at 9:13 AM, Ionut Nicu <ionut.nicu@gmail.com> wr=
ote:
>> > Convert the pmgr module of the tidspbridge driver
>> > to use struct list_head instead of struct lst_list.
>>
>> <snip>
>>
>> > + * Memory is coalesced back to the appropriate heap when a buffer=
 is
>>
>> What is being fixed here?
>>
>
> It was a typo (s/coelesced/coalesced/).

Ok, thanks

>
>> > =A0* freed.
>> > =A0*
>> > =A0* Notes:
>>
>> <snip>
>>
>> > @@ -833,67 +768,44 @@ static void add_to_free_list(struct cmm_allo=
cator *allocator,
>> > =A0 =A0 =A0 =A0DBC_REQUIRE(allocator !=3D NULL);
>> > =A0 =A0 =A0 =A0dw_this_pa =3D pnode->dw_pa;
>> > =A0 =A0 =A0 =A0dw_next_pa =3D NEXT_PA(pnode);
>>
>> i think it would be good to return with error if !allocator or !pnod=
e
>> and remove the =A0 =A0 =A0 =A0resulting duplicated DBC_REQUIRE.
>>
>
> Yeah I think pnode should be checked for null. Can allocator ever be
> null?

It seems that it can actually be NULL, by a possible bug that i just
saw (will send the patch), but taking a deeper look it seems that if
allocator is NULL this function would never be called.

>
>> > - =A0 =A0 =A0 mnode_obj =3D (struct cmm_mnode *)lst_first(allocato=
r->free_list_head);
>> > - =A0 =A0 =A0 while (mnode_obj) {
>> > + =A0 =A0 =A0 list_for_each_entry(mnode_obj, &allocator->free_list=
, link) {
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (dw_this_pa =3D=3D NEXT_PA(mnode=
_obj)) {
>>
>> <snip>
>>
>> > @@ -748,18 +736,16 @@ bool dev_init(void)
>> > =A0*/
>> > =A0int dev_notify_clients(struct dev_object *hdev_obj, u32 ret)
>> > =A0{
>> > - =A0 =A0 =A0 int status =3D 0;
>> > -
>> > =A0 =A0 =A0 =A0struct dev_object *dev_obj =3D hdev_obj;
>> > - =A0 =A0 =A0 void *proc_obj;
>> > + =A0 =A0 =A0 struct list_head *curr;
>>
>> can we add a check for !dev_obj and !dev_obj->proc_list just to be
>> sure that we get always the correct pointer?
>>
>
> proc_list isn't a pointer. Can dev_obj ever be null?

I suppose that adding an extra check in all functions for the received
parameter would be redundant when those parameters come only from
our driver and were previously checked, also performance would be
affected; so relying on the having of the correct parameters in the pat=
h
that calls this function it seems that dev_notify_clients() is not call=
ed
with dev_obj with a NULL value.

>
>> <snip>
>>
>> > @@ -947,15 +933,17 @@ int dev_insert_proc_object(struct dev_object=
 *hdev_obj,
>> > =A0 =A0 =A0 =A0DBC_REQUIRE(refs > 0);
>> > =A0 =A0 =A0 =A0DBC_REQUIRE(dev_obj);
>> > =A0 =A0 =A0 =A0DBC_REQUIRE(proc_obj !=3D 0);
>> > - =A0 =A0 =A0 DBC_REQUIRE(dev_obj->proc_list !=3D NULL);
>> > =A0 =A0 =A0 =A0DBC_REQUIRE(already_attached !=3D NULL);
>>
>> can we check for !hdev_obj, !already_attached even if we have the
>> DBC_REQUIRE?, maybe we can actually remove the DBC_REQUIRE that coul=
d
>> be redundant after applying this.
>>
>
> Same question here.

The same comment.

>
>> > - =A0 =A0 =A0 if (!LST_IS_EMPTY(dev_obj->proc_list))
>> > + =A0 =A0 =A0 if (!list_empty(&dev_obj->proc_list))
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*already_attached =3D true;
>>
>> <snip>
>>
>> > @@ -986,15 +974,12 @@ int dev_remove_proc_object(struct dev_object=
 *hdev_obj, u32 proc_obj)
>> >
>> > =A0 =A0 =A0 =A0DBC_REQUIRE(dev_obj);
>> > =A0 =A0 =A0 =A0DBC_REQUIRE(proc_obj !=3D 0);
>> > - =A0 =A0 =A0 DBC_REQUIRE(dev_obj->proc_list !=3D NULL);
>> > - =A0 =A0 =A0 DBC_REQUIRE(!LST_IS_EMPTY(dev_obj->proc_list));
>> > + =A0 =A0 =A0 DBC_REQUIRE(!list_empty(&dev_obj->proc_list));
>> >
>>
>> =A0The same comment as above.
>>
>
> Regards,
> Ionut.
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
