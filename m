From: "Sapiens, Rene" <rene.sapiens@ti.com>
Subject: Re: [PATCH v2 06/12] staging: tidspbridge: convert core to list_head
Date: Fri, 5 Nov 2010 15:07:44 -0600
Message-ID: <AANLkTim+W3dn1j6SnVS6gc=aeZ0pH+VjSn+YiSJLangz@mail.gmail.com>
References: <1288969996-22103-1-git-send-email-ionut.nicu@mindbit.ro>
	<1288969996-22103-7-git-send-email-ionut.nicu@mindbit.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:48615 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751893Ab0KEVOq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 5 Nov 2010 17:14:46 -0400
Received: by mail-ww0-f51.google.com with SMTP id 17so1540176wwi.20
        for <linux-omap@vger.kernel.org>; Fri, 05 Nov 2010 14:14:45 -0700 (PDT)
In-Reply-To: <1288969996-22103-7-git-send-email-ionut.nicu@mindbit.ro>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ionut Nicu <ionut.nicu@gmail.com>
Cc: Greg Kroah-Hartman <greg@kroah.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Fernando Guzman Lugo <x0095840@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, linux-omap <linux-omap@vger.kernel.org>, Ionut Nicu <ionut.nicu@mindbit.ro>

Hi Ionut,

On Fri, Nov 5, 2010 at 9:13 AM, Ionut Nicu <ionut.nicu@gmail.com> wrote=
:
> Convert the core module of the tidspbridge driver
> to use struct list_head instead of struct lst_list.
>

<snip>

> =A0 =A0 =A0 =A0if (!status) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Get a free chirp: */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 chnl_packet_obj =3D
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (struct chnl_irp *)lst_get_head=
(pchnl->free_packets_list);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (chnl_packet_obj =3D=3D NULL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!list_empty(&pchnl->free_packets_li=
st)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 chnl_packet_obj =3D lis=
t_first_entry(
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 &pchnl->free_packets_list,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 struct chnl_irp, link);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_del(&chnl_packet_o=
bj->link);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0status =3D -EIO;

What do you think if we close the braces, since the first conditional
has more than one statement?

<snip>

> @@ -286,18 +286,16 @@ int bridge_chnl_cancel_io(struct chnl_object *c=
hnl_obj)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0/* Move all IOR's to IOC queue: */
> - =A0 =A0 =A0 while (!LST_IS_EMPTY(pchnl->pio_requests)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 chnl_packet_obj =3D
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (struct chnl_irp *)lst_get_head=
(pchnl->pio_requests);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (chnl_packet_obj) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 chnl_packet_obj->byte_s=
ize =3D 0;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 chnl_packet_obj->status=
 |=3D CHNL_IOCSTATCANCEL;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 lst_put_tail(pchnl->pio=
_completions,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0(struct list_head *)chnl_packet_obj);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pchnl->cio_cs++;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pchnl->cio_reqs--;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DBC_ASSERT(pchnl->cio_r=
eqs >=3D 0);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 while (!list_empty(&pchnl->pio_requests)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 chnl_packet_obj =3D list_first_entry(&p=
chnl->pio_requests,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct =
chnl_irp, link);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_del(&chnl_packet_obj->link);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 chnl_packet_obj->byte_size =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 chnl_packet_obj->status |=3D CHNL_IOCST=
ATCANCEL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_add_tail(&chnl_packet_obj->link, &=
pchnl->pio_completions);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pchnl->cio_cs++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pchnl->cio_reqs--;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 DBC_ASSERT(pchnl->cio_reqs >=3D 0);

Why don't we use list_for_each_entry_safe() instead?

> =A0 =A0 =A0 =A0}
> =A0func_cont:
> =A0 =A0 =A0 =A0spin_unlock_bh(&chnl_mgr_obj->chnl_mgr_lock);

<snip>

> @@ -818,9 +804,19 @@ int bridge_chnl_open(struct chnl_object **chnl,
> =A0 =A0 =A0 =A0/* Protect queues from io_dpc: */
> =A0 =A0 =A0 =A0pchnl->dw_state =3D CHNL_STATECANCEL;
> =A0 =A0 =A0 =A0/* Allocate initial IOR and IOC queues: */
> - =A0 =A0 =A0 pchnl->free_packets_list =3D create_chirp_list(pattrs->=
uio_reqs);
> - =A0 =A0 =A0 pchnl->pio_requests =3D create_chirp_list(0);
> - =A0 =A0 =A0 pchnl->pio_completions =3D create_chirp_list(0);
> + =A0 =A0 =A0 status =3D create_chirp_list(&pchnl->free_packets_list,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pattrs->uio_reqs);
> + =A0 =A0 =A0 if (status)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto func_end;
> +
> + =A0 =A0 =A0 status =3D create_chirp_list(&pchnl->pio_requests, 0);
> + =A0 =A0 =A0 if (status)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto func_end;
> +
> + =A0 =A0 =A0 status =3D create_chirp_list(&pchnl->pio_completions, 0=
);
> + =A0 =A0 =A0 if (status)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto func_end;
> +

With these goto you are not freeing the memory allocated for pchnl, ple=
ase free
it at func_end.

Regards,
Rene
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
