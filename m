From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: Serious memory leak in TI EDMA driver (drivers/dma/edma.c)
Date: Tue, 24 Mar 2015 14:59:25 +0200
Message-ID: <55115FAD.9030209@ti.com>
References: <55072E56.7050802@barix.com> <5508205D.7010106@ti.com> <55087A3A.6070300@barix.com> <55098414.9020301@ti.com> <5509EF23.8080404@barix.com> <550C27C3.10406@ti.com> <550C96E8.5080603@barix.com> <55103130.70906@ti.com> <5510350F.5070906@barix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40474 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752096AbbCXM72 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Mar 2015 08:59:28 -0400
In-Reply-To: <5510350F.5070906@barix.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Petr Kulhavy <petr@barix.com>, linux-omap@vger.kernel.org

On 03/23/2015 05:45 PM, Petr Kulhavy wrote:
> Hi Peter,
>=20
> I've just posted a patch to the community, you should have received a=
nother
> email from me just a few minutes ago.
> Basically there should be a kfree in terminate_all() just before echa=
n->edesc
> is set to NULL.
> The reason is that at that point the edesc is in none of the vchan li=
sts
> (edma_execute() removes it from the "issued" list)
> and vchan_get_all_descriptors() doesn't find it.

And this is the main issue in my view. The desc should be in one of the=
 lists
IMHO.

> With the extra kfree the mem leak is not seen any more.
> It's a good question why terminate_all is called before the transfer =
finished,
> but I thought it could be called at any time?
>=20
> I'm also not sure if the echan->edesc shouldn't be free also in
> edma_execute(), could you please check that? :
>=20
> static void edma_execute(struct edma_chan *echan)
> {
>     struct virt_dma_desc *vdesc;
>     struct edma_desc *edesc;
>     struct device *dev =3D echan->vchan.chan.device->dev;
>     int i, j, left, nslots;
>=20
>     /* If either we processed all psets or we're still not started */
>     if (!echan->edesc ||
>         echan->edesc->pset_nr =3D=3D echan->edesc->processed) {
>         /* Get next vdesc */
>         vdesc =3D vchan_next_desc(&echan->vchan);
>         if (!vdesc) {
>             dev_dbg(dev, "Setting edesc 0x%p to NULL\n",echan->edesc)=
;
>             echan->edesc =3D NULL;
> #warning "possible memory leak here ?"

Yes, it would be, but in fact this will never happen since the edma_exe=
cute()
will not be called when echan->edesc is not NULL _and_ (echan->edesc->p=
set_nr
=3D=3D echan->edesc->processed).

if we have echan->edesc, we are in a middle of transfer, moving from on=
e batch
of sg to another batch.

I do have cleanup patches for this part to clarify the situation.

>             return;
>         }
>         list_del(&vdesc->node);        // at this point node was in i=
ssued
>         echan->edesc =3D to_edma_desc(&vdesc->tx);
>     }
>=20
> I'll post another patch for the wrong type in edma_alloc_chan_resourc=
es()
>=20
>=20
> Regards
> Petr
>=20
>=20
> On 23.03.2015 16:28, Peter Ujfalusi wrote:
>> On 03/20/2015 11:53 PM, Petr Kulhavy wrote:
>>> Hi Peter,
>>>
>>> yes, that is one of the differences to the EVM that the SD card is =
on MMCSD1.
>>> This is due to the pin multiplexer and other peripherals we're usin=
g.
>>>
>>> Your patch is correct, however the edma_callback()  is using the ch=
annel
>>> number parameter for debug messages only. For the actual work echan=
->ch_num is
>>> used. BTW is that correct? Could there be a mismatch between the ec=
han->ch_num
>>> and the ch_num parameter?
>>>
>>> Something else seems to be odd in edma_alloc_chan_resources():
>>>
>>> /* Alloc channel resources */
>>> static int edma_alloc_chan_resources(struct dma_chan *chan)
>>> {
>>>          struct edma_chan *echan =3D to_edma_chan(chan);
>>>          struct device *dev =3D chan->device->dev;
>>>          int ret;
>>>          int a_ch_num;
>>>          LIST_HEAD(descs);
>>>
>>>          a_ch_num =3D edma_alloc_channel(echan->ch_num, edma_callba=
ck,
>>>                                          chan, EVENTQ_DEFAULT);
>> Hah, yes this is wrong but worked so far fine because:
>> struct edma_chan {
>>     struct virt_dma_chan        vchan;
>> ...
>> };
>>
>> struct virt_dma_chan {
>>     struct dma_chan    chan;
>> ...
>> };
>>
>> so &edma_chan =3D=3D &edma_chan.vchan.chan;
>>
>> But this is not why you see the leak.
>>
>> What I did on my board is that I have swapped in SW the cc0 and cc1,=
 now mmc0
>> is on cc1 from the sw point of view, but still can not reproduce the=
 issue.
>>
>>> The third parameter to edma_alloc_channel() should be echan, not ch=
an, since
>>> the edma_callback() interprets the callback data parameter as struc=
t
>>> edma_chan *.
>>>
>>> Let me know if you find something or if you have an advice for more=
 debug.
>>  From the log I would go and see what happens in the
>> vchan_get_all_descriptors() and vchan_dma_desc_free_list(), is it so=
 that at
>> terminate_all time the list we got is empty? But why it is?
>>
>> It seams you got the terminate_all call before the transfer finished=
, this is
>> also interesting. I'll look at at this more deeply.
>> What I see is that at terminate_all we clear the echan->edesc and fo=
r some
>> reason the vchan code will not free the desc. Later the completion i=
nterrupt
>> comes, but since the echan->edesc is NULL we do nothing. This causes=
 the leak.
>>
>> The question to all of this why and how to reproduce it?
>>
>=20


--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
