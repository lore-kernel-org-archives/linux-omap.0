From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: Serious memory leak in TI EDMA driver (drivers/dma/edma.c)
Date: Mon, 23 Mar 2015 17:28:48 +0200
Message-ID: <55103130.70906@ti.com>
References: <55072E56.7050802@barix.com> <5508205D.7010106@ti.com> <55087A3A.6070300@barix.com> <55098414.9020301@ti.com> <5509EF23.8080404@barix.com> <550C27C3.10406@ti.com> <550C96E8.5080603@barix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46286 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752484AbbCWP2v (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Mar 2015 11:28:51 -0400
In-Reply-To: <550C96E8.5080603@barix.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Petr Kulhavy <petr@barix.com>, linux-omap@vger.kernel.org

On 03/20/2015 11:53 PM, Petr Kulhavy wrote:
> Hi Peter,
>=20
> yes, that is one of the differences to the EVM that the SD card is on=
 MMCSD1.
> This is due to the pin multiplexer and other peripherals we're using.
>=20
> Your patch is correct, however the edma_callback()  is using the chan=
nel
> number parameter for debug messages only. For the actual work echan->=
ch_num is
> used. BTW is that correct? Could there be a mismatch between the echa=
n->ch_num
> and the ch_num parameter?
>=20
> Something else seems to be odd in edma_alloc_chan_resources():
>=20
> /* Alloc channel resources */
> static int edma_alloc_chan_resources(struct dma_chan *chan)
> {
>         struct edma_chan *echan =3D to_edma_chan(chan);
>         struct device *dev =3D chan->device->dev;
>         int ret;
>         int a_ch_num;
>         LIST_HEAD(descs);
>=20
>         a_ch_num =3D edma_alloc_channel(echan->ch_num, edma_callback,
>                                         chan, EVENTQ_DEFAULT);

Hah, yes this is wrong but worked so far fine because:
struct edma_chan {
	struct virt_dma_chan		vchan;
=2E..
};

struct virt_dma_chan {
	struct dma_chan	chan;
=2E..
};

so &edma_chan =3D=3D &edma_chan.vchan.chan;

But this is not why you see the leak.

What I did on my board is that I have swapped in SW the cc0 and cc1, no=
w mmc0
is on cc1 from the sw point of view, but still can not reproduce the is=
sue.

>=20
> The third parameter to edma_alloc_channel() should be echan, not chan=
, since
> the edma_callback() interprets the callback data parameter as struct =
edma_chan *.
>=20
> Let me know if you find something or if you have an advice for more d=
ebug.

=46rom the log I would go and see what happens in the
vchan_get_all_descriptors() and vchan_dma_desc_free_list(), is it so th=
at at
terminate_all time the list we got is empty? But why it is?

It seams you got the terminate_all call before the transfer finished, t=
his is
also interesting. I'll look at at this more deeply.
What I see is that at terminate_all we clear the echan->edesc and for s=
ome
reason the vchan code will not free the desc. Later the completion inte=
rrupt
comes, but since the echan->edesc is NULL we do nothing. This causes th=
e leak.

The question to all of this why and how to reproduce it?

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
