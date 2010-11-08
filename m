From: "Sapiens, Rene" <rene.sapiens@ti.com>
Subject: Re: [PATCH v2 06/12] staging: tidspbridge: convert core to list_head
Date: Mon, 8 Nov 2010 13:15:25 -0600
Message-ID: <AANLkTi=gxX2u12nhbuiprOwRdCA4GFd4T0+Kq36QcxcZ@mail.gmail.com>
References: <1288969996-22103-1-git-send-email-ionut.nicu@mindbit.ro>
	<1288969996-22103-7-git-send-email-ionut.nicu@mindbit.ro>
	<AANLkTim+W3dn1j6SnVS6gc=aeZ0pH+VjSn+YiSJLangz@mail.gmail.com>
	<1289064083.9931.43.camel@atlantis.mindbit.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:59562 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751649Ab0KHTP3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 8 Nov 2010 14:15:29 -0500
Received: by mail-wy0-f169.google.com with SMTP id 23so5979583wyf.28
        for <linux-omap@vger.kernel.org>; Mon, 08 Nov 2010 11:15:26 -0800 (PST)
In-Reply-To: <1289064083.9931.43.camel@atlantis.mindbit.ro>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ionut Nicu <ionut.nicu@mindbit.ro>
Cc: Ionut Nicu <ionut.nicu@gmail.com>, Greg Kroah-Hartman <greg@kroah.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Fernando Guzman Lugo <x0095840@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, linux-omap <linux-omap@vger.kernel.org>

Hi Ionut,

On Sat, Nov 6, 2010 at 11:21 AM, Ionut Nicu <ionut.nicu@mindbit.ro> wro=
te:
> Hi Rene,
>
> On Fri, 2010-11-05 at 15:07 -0600, Sapiens, Rene wrote:
>> Hi Ionut,
>>
>> On Fri, Nov 5, 2010 at 9:13 AM, Ionut Nicu <ionut.nicu@gmail.com> wr=
ote:
>> > Convert the core module of the tidspbridge driver
>> > to use struct list_head instead of struct lst_list.
>> >
>>
>> <snip>
>>
>> > =A0 =A0 =A0 =A0if (!status) {
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Get a free chirp: */
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 chnl_packet_obj =3D
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (struct chnl_irp *)lst_get_h=
ead(pchnl->free_packets_list);
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (chnl_packet_obj =3D=3D NULL)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!list_empty(&pchnl->free_packets=
_list)) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 chnl_packet_obj =3D =
list_first_entry(
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 &pchnl->free_packets_list,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 struct chnl_irp, link);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_del(&chnl_packe=
t_obj->link);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0status =3D -EIO;
>>
>> What do you think if we close the braces, since the first conditiona=
l
>> has more than one statement?
>>
>
> Can you clarify? I don't think I understand which brace we need to cl=
ose
> here.

I mean open and close the braces for the added 'else', I'm just mention=
ing
what the coding style says for placing braces when one of the branches
has more than one statement.

>
>> <snip>
>>
>> > @@ -286,18 +286,16 @@ int bridge_chnl_cancel_io(struct chnl_object=
 *chnl_obj)
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>> > =A0 =A0 =A0 =A0}
>> > =A0 =A0 =A0 =A0/* Move all IOR's to IOC queue: */
>> > - =A0 =A0 =A0 while (!LST_IS_EMPTY(pchnl->pio_requests)) {
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 chnl_packet_obj =3D
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (struct chnl_irp *)lst_get_h=
ead(pchnl->pio_requests);
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (chnl_packet_obj) {
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 chnl_packet_obj->byt=
e_size =3D 0;
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 chnl_packet_obj->sta=
tus |=3D CHNL_IOCSTATCANCEL;
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 lst_put_tail(pchnl->=
pio_completions,
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0(struct list_head *)chnl_packet_obj);
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pchnl->cio_cs++;
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pchnl->cio_reqs--;
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DBC_ASSERT(pchnl->ci=
o_reqs >=3D 0);
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> > + =A0 =A0 =A0 while (!list_empty(&pchnl->pio_requests)) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 chnl_packet_obj =3D list_first_entry=
(&pchnl->pio_requests,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 stru=
ct chnl_irp, link);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_del(&chnl_packet_obj->link);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 chnl_packet_obj->byte_size =3D 0;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 chnl_packet_obj->status |=3D CHNL_IO=
CSTATCANCEL;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_add_tail(&chnl_packet_obj->link=
, &pchnl->pio_completions);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pchnl->cio_cs++;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pchnl->cio_reqs--;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 DBC_ASSERT(pchnl->cio_reqs >=3D 0);
>>
>> Why don't we use list_for_each_entry_safe() instead?
>>
>
> Agreed, it will look better.
>
>
>> > =A0 =A0 =A0 =A0}
>> > =A0func_cont:
>> > =A0 =A0 =A0 =A0spin_unlock_bh(&chnl_mgr_obj->chnl_mgr_lock);
>>
>> <snip>
>>
>> > @@ -818,9 +804,19 @@ int bridge_chnl_open(struct chnl_object **chn=
l,
>> > =A0 =A0 =A0 =A0/* Protect queues from io_dpc: */
>> > =A0 =A0 =A0 =A0pchnl->dw_state =3D CHNL_STATECANCEL;
>> > =A0 =A0 =A0 =A0/* Allocate initial IOR and IOC queues: */
>> > - =A0 =A0 =A0 pchnl->free_packets_list =3D create_chirp_list(pattr=
s->uio_reqs);
>> > - =A0 =A0 =A0 pchnl->pio_requests =3D create_chirp_list(0);
>> > - =A0 =A0 =A0 pchnl->pio_completions =3D create_chirp_list(0);
>> > + =A0 =A0 =A0 status =3D create_chirp_list(&pchnl->free_packets_li=
st,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pattrs->uio_reqs);
>> > + =A0 =A0 =A0 if (status)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto func_end;
>> > +
>> > + =A0 =A0 =A0 status =3D create_chirp_list(&pchnl->pio_requests, 0=
);
>> > + =A0 =A0 =A0 if (status)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto func_end;
>> > +
>> > + =A0 =A0 =A0 status =3D create_chirp_list(&pchnl->pio_completions=
, 0);
>> > + =A0 =A0 =A0 if (status)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto func_end;
>> > +
>>
>> With these goto you are not freeing the memory allocated for pchnl, =
please free
>> it at func_end.
>>
>
> Thanks for catching this. Freeing it at func_end is not a very good
> idea, because it's also freed above.
>
> What do you think if I replace the last two calls for
> create_chirp_list() with just INIT_LIST_HEAD()? This way we'll have o=
nly
> one error check where we'll also kfree(pchnl) and we'll have 2 less
> un-necessary function calls / error checks.
>

Agreed,  this looks good.

>

Regards,
Rene
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
