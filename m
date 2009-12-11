From: Venkatraman S <svenkatr@ti.com>
Subject: Re: [PATCH v3] OMAP4: sDMA driver: descriptor autoloading feature
Date: Fri, 11 Dec 2009 20:33:34 +0530
Message-ID: <618f0c910912110703s3f9529e2m120baa7c86dd1325@mail.gmail.com>
References: <0680EC522D0CC943BC586913CF3768C0037CE48838@dbde02.ent.ti.com>
	 <20091012095330.GB29310@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.216.174]:39600 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754207AbZLKPD2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Dec 2009 10:03:28 -0500
Received: by pxi4 with SMTP id 4so239466pxi.33
        for <linux-omap@vger.kernel.org>; Fri, 11 Dec 2009 07:03:34 -0800 (PST)
In-Reply-To: <20091012095330.GB29310@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Russell,
On Mon, Oct 12, 2009 at 3:23 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Sep 04, 2009 at 12:04:08AM +0530, S, Venkatraman wrote:
>> +static int dma_caps0_status;
>> +
>> +struct omap_dma_list_config_params {
>> + =A0 =A0 =A0 int chid;
>
> This seems to be unused.
>
>> + =A0 =A0 =A0 int num_elem;
>
> This might want to be unsigned.
>
>> + =A0 =A0 =A0 struct omap_dma_sglist_node *sghead;
>> + =A0 =A0 =A0 int sgheadphy;
>
> This should be dma_addr_t.
>
>> + =A0 =A0 =A0 int pausenode;
>
> Should this also be unsigned? =A0(If so, the 'pauseafter' parameter s=
hould
> be as well.
>
>> +};
>
>
>> +int omap_request_dma_sglist(int dev_id, const char *dev_name,
>> + =A0 =A0 =A0 void (*callback) (int channel_id, u16 ch_status, void =
*data),
>> + =A0 =A0 =A0 int *listid, int nelem, struct omap_dma_sglist_node **=
elems)
>> +{
>> + =A0 =A0 =A0 struct omap_dma_list_config_params *lcfg;
>> + =A0 =A0 =A0 struct omap_dma_sglist_node *desc;
>> + =A0 =A0 =A0 int dma_lch;
>> + =A0 =A0 =A0 int rc, i;
>> +
>> + =A0 =A0 =A0 if (unlikely((dma_caps0_status & DMA_CAPS_SGLIST_SUPPO=
RT) =3D=3D 0)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "omap DMA: sglist feat=
ure not supported\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EPERM;
>> + =A0 =A0 =A0 }
>> + =A0 =A0 =A0 if (unlikely(nelem <=3D 2)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "omap DMA: Need >2 ele=
ments in the list\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 =A0 }
>
> I'm not sure these unlikely()'s help for two reasons:
> 1. gcc probably has already worked that out (later versions have beco=
me
> =A0 quite a bit better at this.)
> 2. since we're calling allocation functions, this isn't a hot path, s=
o
> =A0 the few cycles the above _may_ save really isn't worth it
>
>> + =A0 =A0 =A0 rc =3D omap_request_dma(dev_id, dev_name,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 callback, NULL, &d=
ma_lch);
>> + =A0 =A0 =A0 if (rc < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "omap_dma_list: Reques=
t failed %d\n", rc);
>
> You use a prefix of "omap DMA" above, but "omap_dma_list" here - it w=
ould
> be nice to be consistent.
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return rc;
>> + =A0 =A0 =A0 }
>> + =A0 =A0 =A0 *listid =3D dma_lch;
>> + =A0 =A0 =A0 dma_chan[dma_lch].state =3D DMA_CH_NOTSTARTED;
>> + =A0 =A0 =A0 lcfg =3D kmalloc(sizeof(*lcfg), GFP_KERNEL);
>> + =A0 =A0 =A0 if (NULL =3D=3D lcfg)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error1;
>> + =A0 =A0 =A0 dma_chan[dma_lch].list_config =3D lcfg;
>> +
>> + =A0 =A0 =A0 lcfg->num_elem =3D nelem;
>> +
>> + =A0 =A0 =A0 *elems =3D desc =3D lcfg->sghead =3D dma_alloc_coheren=
t(NULL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sizeof(*desc), &(lcfg->sgheadphy), 0);
>> + =A0 =A0 =A0 if (NULL =3D=3D desc)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error1;
>> +
>> + =A0 =A0 =A0 for (i =3D 1; i < nelem; i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 desc->next =3D dma_alloc_coherent(NULL=
,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sizeof(*(desc->next)),=
 &(desc->next_desc_add_ptr), 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (NULL =3D=3D desc->next)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 desc =3D desc->next;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 desc->next =3D NULL;
>> + =A0 =A0 =A0 }
>
> The smallest allocation unit available from dma_alloc_coherent() is o=
ne
> page. =A0You really don't want to allocate one page per descriptor.
> Instead, you want to do this:
>
> =A0 =A0 =A0 =A0lcfg->sghead =3D dma_alloc_coherent(/*some device*/,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sizeof(*desc) * nelem,=
 &lcfg->sgheadphy, 0);
> =A0 =A0 =A0 =A0if (!lcfg->sghead)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto error1;
>
> =A0 =A0 =A0 =A0*elems =3D desc =3D lcfg->sghead;
> =A0 =A0 =A0 =A0desc_dma =3D lcfg->sgheadphy;
> =A0 =A0 =A0 =A0for (i =3D 1; i < nelem; i++, desc++) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0desc->next =3D desc + 1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0desc->next_desc_add_ptr =3D desc_dma +=
 sizeof(*desc);
> =A0 =A0 =A0 =A0}
>
> This might also mean that you can get rid of the desc->next walking
> and just use a plain for loop.
>
> Also, using a struct device for the device actually doing the DMA wou=
ld
> be a Good Thing - this becomes much more relevent when we want to be
> able to allocate coherent DMA pages from highmem (since passing NULL
> means we have to allocate from the low DMA region.)
>
>> + =A0 =A0 =A0 desc->next_desc_add_ptr =3D OMAP_DMA_INVALID_DESCRIPTO=
R_POINTER;
>> +
>> + =A0 =A0 =A0 dma_write(0, CCDN(dma_lch)); /* Reset List index numbe=
ring */
>> + =A0 =A0 =A0 /* Initialize frame and element counters to invalid va=
lues */
>> + =A0 =A0 =A0 dma_write(OMAP_DMA_INVALID_FRAME_COUNT, CCFN(dma_lch))=
;
>> + =A0 =A0 =A0 dma_write(OMAP_DMA_INVALID_ELEM_COUNT, CCEN(dma_lch));
>> + =A0 =A0 =A0 return 0;
>> +
>> +error1:
>> + =A0 =A0 =A0 omap_release_dma_sglist(dma_lch);
>> + =A0 =A0 =A0 return -ENOMEM;
>> +
>> +}
>> +EXPORT_SYMBOL(omap_request_dma_sglist);
>> +
>> +/* The client can choose to not preconfigure the DMA registers
>> + * In fast mode,the DMA controller uses the first element in the li=
st to
>> + * program the registers first, and then starts the transfer
>> + */
>> +
>> +int omap_set_dma_sglist_params(const int listid,
>> + =A0 =A0 =A0 struct omap_dma_sglist_node *sghead,
>> + =A0 =A0 =A0 struct omap_dma_channel_params *chparams)
>> +{
>> + =A0 =A0 =A0 struct omap_dma_list_config_params *lcfg;
>> + =A0 =A0 =A0 struct omap_dma_sglist_node *sgitcurr, *sgitprev;
>> + =A0 =A0 =A0 int l =3D DMA_LIST_CDP_LISTMODE; /* Enable Linked list=
 mode in CDP */
>> +
>> + =A0 =A0 =A0 lcfg =3D dma_chan[listid].list_config;
>> + =A0 =A0 =A0 if (lcfg->sghead !=3D sghead) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Unknown config pointe=
r passed\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EPERM;
>> + =A0 =A0 =A0 }
>
> If sghead can't be anything different from lcfg->sghead, what is the
> purpose of passing sghead into this function?
>
>> +
>> + =A0 =A0 =A0 if (NULL =3D=3D chparams)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 l |=3D DMA_LIST_CDP_FASTMODE;
>> + =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_set_dma_params(listid, chparams);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* The client can set the dma params a=
nd still use fast mode
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* by using the set fast mode api
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 dma_write(l, CDP(listid));
>> +
>> + =A0 =A0 =A0 sgitprev =3D sghead;
>> + =A0 =A0 =A0 sgitcurr =3D sgitprev->next;
>> +
>> + =A0 =A0 =A0 while (sgitcurr !=3D NULL) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 switch (sgitcurr->desc_type) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE1:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_dma_list_set_ntyp=
e(sgitprev, 1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE2a=
:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* intentional no brea=
k */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE2b=
:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_dma_list_set_ntyp=
e(sgitprev, 2);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE3a=
:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* intentional no brea=
k */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE3b=
:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_dma_list_set_ntyp=
e(sgitprev, 3);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 default:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (sgitcurr->flags & OMAP_DMA_LIST_SR=
C_VALID)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sgitprev->num_of_elem =
|=3D DMA_LIST_DESC_SRC_VALID;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (sgitcurr->flags & OMAP_DMA_LIST_DS=
T_VALID)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sgitprev->num_of_elem =
|=3D DMA_LIST_DESC_DST_VALID;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (sgitcurr->flags & OMAP_DMA_LIST_NO=
TIFY_BLOCK_END)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sgitprev->num_of_elem =
|=3D DMA_LIST_DESC_BLK_END;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sgitprev =3D sgitcurr;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sgitcurr =3D sgitcurr->next;
>> + =A0 =A0 =A0 }
>
> This becomes:
> =A0 =A0 =A0 =A0for (sgprev =3D lcfg->sghead;
> =A0 =A0 =A0 =A0 =A0 =A0 sgcurr =3D sgprev + 1, sgcurr < lcfg->sghead =
+ lcfg->num_elem;
> =A0 =A0 =A0 =A0 =A0 =A0 sgprev =3D sgcurr) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0switch (sgcurr->desc_type) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0...
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
>
>> +
>> + =A0 =A0 =A0 return 0;
>> +}
>> +EXPORT_SYMBOL(omap_set_dma_sglist_params);
>> +
>> +int omap_start_dma_sglist_transfers(const int listid, const int pau=
seafter)
>
> 'const' for non-pointer function parameters doesn't have a benefit fo=
r
> code generation - the only thing it does is issue a warning if you wr=
ite
> to them. =A0Are they serving a special purpose here?
>
>> +{
>> + =A0 =A0 =A0 struct omap_dma_list_config_params *lcfg;
>> + =A0 =A0 =A0 struct omap_dma_sglist_node *sgn;
>> + =A0 =A0 =A0 unsigned int l, type_id;
>> +
>> + =A0 =A0 =A0 lcfg =3D dma_chan[listid].list_config;
>> + =A0 =A0 =A0 lcfg->pausenode =3D 0;
>> + =A0 =A0 =A0 sgn =3D lcfg->sghead;
>> + =A0 =A0 =A0 if (pauseafter > 0 && pauseafter <=3D lcfg->num_elem) =
{
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (l =3D 0; l < pauseafter; l++)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sgn =3D sgn->next;
>
> Are you sure this code is correct? =A0Two problems:
>
> 1. If 'pauseafter' is 1, sgn is the second entry in the list, not the
> =A0 first, so you can't pause after the first descriptor.
>
> 2. If 'pauseafter' is 'nelem' then sgn will be NULL, resulting in an =
oops.
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sgn->next_desc_add_ptr |=3D DMA_LIST_D=
ESC_PAUSE;
>
> Assuming you have an out-by-one error above, this becomes:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sgn[pauseafter].next_desc_add_ptr |=3D=
 DMA_LIST_DESC_PAUSE;
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 lcfg->pausenode =3D pauseafter;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 /* Program the head descriptor's properties into CDP *=
/
>> + =A0 =A0 =A0 switch (lcfg->sghead->desc_type) {
>> + =A0 =A0 =A0 case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE1:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 type_id =3D DMA_LIST_CDP_TYPE1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE2a:
>> + =A0 =A0 =A0 case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE2b:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 type_id =3D DMA_LIST_CDP_TYPE2;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE3a:
>> + =A0 =A0 =A0 case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE3b:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 type_id =3D DMA_LIST_CDP_TYPE3;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 default:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 l =3D dma_read(CDP(listid));
>> + =A0 =A0 =A0 l |=3D type_id;
>> + =A0 =A0 =A0 if (lcfg->sghead->flags & OMAP_DMA_LIST_SRC_VALID)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 l |=3D DMA_LIST_CDP_SRC_VALID;
>> + =A0 =A0 =A0 if (lcfg->sghead->flags & OMAP_DMA_LIST_DST_VALID)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 l |=3D DMA_LIST_CDP_DST_VALID;
>> +
>> + =A0 =A0 =A0 dma_write(l, CDP(listid));
>> +
>> + =A0 =A0 =A0 dma_write((lcfg->sgheadphy), CNDP(listid));
>> + =A0 =A0 =A0 printk(KERN_DEBUG "Start list transfer for list %x\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 lcfg->sgheadphy);
>> + =A0 =A0 =A0 omap_start_dma(listid);
>> +
>> + =A0 =A0 =A0 return 0;
>> +}
>> +EXPORT_SYMBOL(omap_start_dma_sglist_transfers);
>> +
>> +int omap_resume_dma_sglist_transfers(const int listid, const int pa=
useafter)
>
> Same comment as above wrt 'const' parameters.
>
>> +{
>> + =A0 =A0 =A0 struct omap_dma_list_config_params *lcfg;
>> + =A0 =A0 =A0 struct omap_dma_sglist_node *sgn;
>> + =A0 =A0 =A0 int l;
>> +
>> + =A0 =A0 =A0 lcfg =3D dma_chan[listid].list_config;
>> + =A0 =A0 =A0 sgn =3D lcfg->sghead;
>> + =A0 =A0 =A0 /* Clear the previous pause, if any */
>> + =A0 =A0 =A0 lcfg->pausenode =3D 0;
>> +
>> + =A0 =A0 =A0 if (pauseafter > 0 && pauseafter <=3D lcfg->num_elem) =
{
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (l =3D 0; l < pauseafter; l++)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sgn =3D sgn->next;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sgn->next_desc_add_ptr |=3D DMA_LIST_D=
ESC_PAUSE;
>
> Same comments as per omap_start_dma_sglist_transfers().
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 lcfg->pausenode =3D pauseafter;
>> + =A0 =A0 =A0 }
>
> Incidentally, shouldn't this be an inline function or something like =
that,
> since this seems to be a duplication of what's happening in
> omap_start_dma_sglist_transfers() ?
>
>> +
>> + =A0 =A0 =A0 /* Clear pause bit in CDP */
>> + =A0 =A0 =A0 l =3D dma_read(CDP(listid));
>> + =A0 =A0 =A0 printk(KERN_DEBUG "Resuming after pause: CDP=3D%x\n", =
l);
>> + =A0 =A0 =A0 l &=3D ~(DMA_LIST_CDP_PAUSEMODE);
>> + =A0 =A0 =A0 dma_write(l, CDP(listid));
>> + =A0 =A0 =A0 omap_start_dma(listid);
>> + =A0 =A0 =A0 return 0;
>> +}
>> +EXPORT_SYMBOL(omap_resume_dma_sglist_transfers);
>> +
>> +int omap_release_dma_sglist(const int listid)
>> +{
>> + =A0 =A0 =A0 struct omap_dma_list_config_params *lcfg;
>> + =A0 =A0 =A0 struct omap_dma_sglist_node *sgn, *sgn2;
>> +
>> + =A0 =A0 =A0 lcfg =3D dma_chan[listid].list_config;
>> + =A0 =A0 =A0 sgn =3D lcfg->sghead;
>> +
>> + =A0 =A0 =A0 if (NULL !=3D sgn) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sgn =3D sgn->next;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 do {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sgn2 =3D sgn->next;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_free_coherent(NULL=
, sizeof(*sgn), sgn,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sgn->n=
ext_desc_add_ptr);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sgn =3D sgn2;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } while (sgn2 !=3D NULL);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_free_coherent(NULL, sizeof(*(lcfg-=
>sghead)),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 lcfg->sghead, lcfg->sg=
headphy);
>
> As a result of the way these are allocated, this can become the much
> simpler:
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dma_free_coherent(/*some device */,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sizeof(*lcfg->sghead) =
* lcfg->num_elem,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0lcfg->sghead, lcfg->sg=
headphy);
>
>> + =A0 =A0 =A0 }
>> + =A0 =A0 =A0 if (NULL !=3D dma_chan[listid].list_config)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(dma_chan[listid].list_config);
>> + =A0 =A0 =A0 dma_chan[listid].list_config =3D NULL;
>> + =A0 =A0 =A0 omap_free_dma(listid);
>> + =A0 =A0 =A0 return 0;
>> +}
>> +EXPORT_SYMBOL(omap_release_dma_sglist);
>> +
>> +int omap_get_completed_sglist_nodes(const int listid)
>> +{
>> + =A0 =A0 =A0 int list_count;
>> +
>> + =A0 =A0 =A0 list_count =3D dma_read(CCDN(listid));
>> + =A0 =A0 =A0 return list_count & 0xffff; /* only 16 LSB bits are va=
lid */
>> +}
>> +EXPORT_SYMBOL(omap_get_completed_sglist_nodes);
>> +
>> +int omap_dma_sglist_is_paused(const int listid)
>> +{
>> + =A0 =A0 =A0 int list_state;
>> +
>> + =A0 =A0 =A0 list_state =3D dma_read(CDP(listid));
>> + =A0 =A0 =A0 return (list_state & DMA_LIST_CDP_PAUSEMODE) ? 1 : 0;
>> +}
>> +EXPORT_SYMBOL(omap_dma_sglist_is_paused);
>> +
>> +void omap_dma_set_sglist_fastmode(const int listid, const int fastm=
ode)
>> +{
>> + =A0 =A0 =A0 int l =3D dma_read(CDP(listid));
>> +
>> + =A0 =A0 =A0 if (fastmode)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 l |=3D DMA_LIST_CDP_FASTMODE;
>> + =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 l &=3D ~(DMA_LIST_CDP_FASTMODE);
>> + =A0 =A0 =A0 dma_write(l, CDP(listid));
>> +}
>> +EXPORT_SYMBOL(omap_dma_set_sglist_fastmode);
>> +
>>
>> =A0#ifdef CONFIG_ARCH_OMAP1
>>
>> @@ -2367,6 +2668,7 @@ static int __init omap_init_dma(void)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(dma_chan);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_caps0_status =3D dma_read(CAPS_0);
>> =A0 =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 =A0 if (cpu_is_omap15xx()) {
>> @@ -2418,6 +2720,7 @@ static int __init omap_init_dma(void)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_clear_dma(ch);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_chan[ch].dev_id =3D -1;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_chan[ch].next_lch =3D -1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_chan[ch].list_config =3D NULL;
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ch >=3D 6 && enable_1510_mode)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> diff --git a/arch/arm/plat-omap/include/mach/dma.h b/arch/arm/plat-o=
map/include/mach/dma.h
>> index 72f680b..ca2970d 100644
>> --- a/arch/arm/plat-omap/include/mach/dma.h
>> +++ b/arch/arm/plat-omap/include/mach/dma.h
>> @@ -112,8 +112,12 @@
>> =A0#define OMAP1_DMA_COLOR_U(n) =A0 =A0 =A0 =A0 =A0 (0x40 * (n) + 0x=
22)
>> =A0#define OMAP1_DMA_CCR2(n) =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x40 * (n) =
+ 0x24)
>> =A0#define OMAP1_DMA_LCH_CTRL(n) =A0 =A0 =A0 =A0 =A0(0x40 * (n) + 0x=
2a) =A0 =A0 /* not on 15xx */
>> +#define OMAP1_DMA_COLOR(n) =A0 =A0 =A0 =A0 =A0 =A0 0
>> =A0#define OMAP1_DMA_CCEN(n) =A0 =A0 =A0 =A0 =A0 =A0 =A00
>> =A0#define OMAP1_DMA_CCFN(n) =A0 =A0 =A0 =A0 =A0 =A0 =A00
>> +#define OMAP1_DMA_CDP(n) =A0 =A0 =A0 =A0 =A0 =A0 =A0 0
>> +#define OMAP1_DMA_CNDP(n) =A0 =A0 =A0 =A0 =A0 =A0 =A00
>> +#define OMAP1_DMA_CCDN(n) =A0 =A0 =A0 =A0 =A0 =A0 =A00
>>
>> =A0/* Channel specific registers only on omap2 */
>> =A0#define OMAP_DMA4_CSSA(n) =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x60 * (n) =
+ 0x9c)
>> @@ -132,6 +136,8 @@
>> =A0#define OMAP1_DMA_IRQSTATUS_L0 =A0 =A0 =A0 =A0 0
>> =A0#define OMAP1_DMA_IRQENABLE_L0 =A0 =A0 =A0 =A0 0
>> =A0#define OMAP1_DMA_OCP_SYSCONFIG =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00
>> +#define OMAP1_DMA_CAPS_0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0
>> +
>> =A0#define OMAP_DMA4_HW_ID =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A00
>> =A0#define OMAP_DMA4_CAPS_0_L =A0 =A0 =A0 =A0 =A0 =A0 0
>> =A0#define OMAP_DMA4_CAPS_0_U =A0 =A0 =A0 =A0 =A0 =A0 0
>> @@ -576,6 +582,83 @@ struct omap_dma_channel_params {
>> =A0#endif
>> =A0};
>>
>> +struct omap_dma_sglist_type1_params {
>> + =A0 =A0 =A0 u32 src_addr;
>> + =A0 =A0 =A0 u32 dst_addr;
>> + =A0 =A0 =A0 u16 cfn_fn;
>> + =A0 =A0 =A0 u16 cicr;
>> + =A0 =A0 =A0 u16 dst_elem_idx;
>> + =A0 =A0 =A0 u16 src_elem_idx;
>> + =A0 =A0 =A0 u32 dst_frame_idx_or_pkt_size;
>> + =A0 =A0 =A0 u32 src_frame_idx_or_pkt_size;
>> + =A0 =A0 =A0 u32 color;
>> + =A0 =A0 =A0 u32 csdp;
>> + =A0 =A0 =A0 u32 clnk_ctrl;
>> + =A0 =A0 =A0 u32 ccr;
>> +};
>> +
>> +struct omap_dma_sglist_type2a_params {
>> + =A0 =A0 =A0 u32 src_addr;
>> + =A0 =A0 =A0 u32 dst_addr;
>> + =A0 =A0 =A0 u16 cfn_fn;
>> + =A0 =A0 =A0 u16 cicr;
>> + =A0 =A0 =A0 u16 dst_elem_idx;
>> + =A0 =A0 =A0 u16 src_elem_idx;
>> + =A0 =A0 =A0 u32 dst_frame_idx_or_pkt_size;
>> + =A0 =A0 =A0 u32 src_frame_idx_or_pkt_size;
>> +};
>> +
>> +struct omap_dma_sglist_type2b_params {
>> + =A0 =A0 =A0 u32 src_or_dest_addr;
>> + =A0 =A0 =A0 u16 cfn_fn;
>> + =A0 =A0 =A0 u16 cicr;
>> + =A0 =A0 =A0 u16 dst_elem_idx;
>> + =A0 =A0 =A0 u16 src_elem_idx;
>> + =A0 =A0 =A0 u32 dst_frame_idx_or_pkt_size;
>> + =A0 =A0 =A0 u32 src_frame_idx_or_pkt_size;
>> +};
>> +
>> +struct omap_dma_sglist_type3a_params {
>> + =A0 =A0 =A0 u32 src_addr;
>> + =A0 =A0 =A0 u32 dst_addr;
>> +};
>> +
>> +struct omap_dma_sglist_type3b_params {
>> + =A0 =A0 =A0 u32 src_or_dest_addr;
>> +};
>> +
>> +enum omap_dma_sglist_descriptor_select {
>> + =A0 =A0 =A0 OMAP_DMA_SGLIST_DESCRIPTOR_TYPE1,
>> + =A0 =A0 =A0 OMAP_DMA_SGLIST_DESCRIPTOR_TYPE2a,
>> + =A0 =A0 =A0 OMAP_DMA_SGLIST_DESCRIPTOR_TYPE2b,
>> + =A0 =A0 =A0 OMAP_DMA_SGLIST_DESCRIPTOR_TYPE3a,
>> + =A0 =A0 =A0 OMAP_DMA_SGLIST_DESCRIPTOR_TYPE3b,
>> +};
>> +
>> +union omap_dma_sglist_node_type{
>> + =A0 =A0 =A0 struct omap_dma_sglist_type1_params t1;
>> + =A0 =A0 =A0 struct omap_dma_sglist_type2a_params t2a;
>> + =A0 =A0 =A0 struct omap_dma_sglist_type2b_params t2b;
>> + =A0 =A0 =A0 struct omap_dma_sglist_type3a_params t3a;
>> + =A0 =A0 =A0 struct omap_dma_sglist_type3b_params t3b;
>> +};
>> +
>> +struct omap_dma_sglist_node {
>> +
>> + =A0 =A0 =A0 /* Common elements for all descriptors */
>> + =A0 =A0 =A0 u32 next_desc_add_ptr;
>
> For correct typing, this should be:
>
> =A0 =A0 =A0 =A0dma_addr_t next_desc_add_ptr;
>
> DMA addresses have type 'dma_addr_t' not u32.
>
>> + =A0 =A0 =A0 u32 num_of_elem;
>> + =A0 =A0 =A0 /* Type specific elements */
>> + =A0 =A0 =A0 union omap_dma_sglist_node_type sg_node;
>> + =A0 =A0 =A0 /* Control fields */
>> + =A0 =A0 =A0 int flags;
>
> Maybe unsigned?
>
>> + =A0 =A0 =A0 /* Fields that can be set in flags variable */
>> + =A0 =A0 =A0 #define OMAP_DMA_LIST_SRC_VALID =A0 =A0 =A0 =A0 (1)
>> + =A0 =A0 =A0 #define OMAP_DMA_LIST_DST_VALID =A0 =A0 =A0 =A0 (2)
>> + =A0 =A0 =A0 #define OMAP_DMA_LIST_NOTIFY_BLOCK_END =A0(4)
>
> And if you're only using a small number of flags, do you need 32 bits=
 for
> them? =A0Maybe something a little smaller like unsigned short?
>
>> + =A0 =A0 =A0 u32 desc_type;
>
> Isn't this enum omap_dma_sglist_descriptor_select ? =A0If you correct=
ly
> type this, the compiler can check that you're handling all cases in a
> switch statement automatically, which means if you add to the enum,
> it'll tell you the place you missed.
>
>> + =A0 =A0 =A0 struct omap_dma_sglist_node *next;
>> +};
>>
>> =A0extern void omap_set_dma_priority(int lch, int dst_port, int prio=
rity);
>> =A0extern int omap_request_dma(int dev_id, const char *dev_name,
>> @@ -655,6 +738,59 @@ extern int omap_modify_dma_chain_params(int cha=
in_id,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 struct omap_dma_channel_params params);
>> =A0extern int omap_dma_chain_status(int chain_id);
>> =A0#endif
>> +/* omap_request_dma_sglist:
>> + * Request to setup a DMA channel to transfer in linked list mode o=
f nelem
>> + * elements. The memory for the list will be allocated and returned=
 in
>> + * elems structure
>> + */
>> +extern int omap_request_dma_sglist(int dev_id, const char *dev_name=
,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 void (*callback) (int channel_id, u16 =
ch_status, void *data),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int *listid, int nelem, struct omap_dm=
a_sglist_node **elems);
>> +/* omap_set_dma_sglist_params
>> + * Provide the configuration parameters for the sglist channel
>> + * sghead should contain a fully populated list of nelems
>> + * which completely describe the transfer. chparams, if not NULL, w=
ill
>> + * set the appropriate parameters directly into the DMA register.
>> + * If chparams is NULL, fastmode will be enabled automatically
>> + */
>> +extern int omap_set_dma_sglist_params(const int listid,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 struct omap_dma_sglist_node *sghead,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 struct omap_dma_channel_params *chparams);
>> +/* omap_start_dma_sglist_transfers
>> + * Starts the linked list based DMA transfer for the specified list=
id
>> + * If no pause is required, -1 is to be set in pauseafter.
>> + * Else, the transfer will suspend after pauseafter elements.
>> + */
>> +extern int omap_start_dma_sglist_transfers(const int listid,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0const int pauseafter);
>> +/* omap_resume_dma_sglist_transfers
>> + * Resumes the previously paused transfer.
>> + * Can be again set to pause at pauseafter node of the linked list
>> + * The index is absolute (from the head of the list)
>> + */
>> +extern int omap_resume_dma_sglist_transfers(const int listid,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 const int pauseafter);
>> +/* omap_release_dma_sglist
>> + * Releases the list based DMA channel and the associated list desc=
riptors
>> + */
>> +extern int omap_release_dma_sglist(const int listid);
>> +/* omap_get_completed_sglist_nodes
>> + * Returns the number of completed elements in the linked list
>> + * The value is transient if the API is invoked for an ongoing tran=
sfer
>> + */
>> +int omap_get_completed_sglist_nodes(const int listid);
>> +/* omap_dma_sglist_is_paused
>> + * Returns non zero if the linked list is currently in pause state
>> + */
>> +int omap_dma_sglist_is_paused(const int listid);
>> +/* omap_dma_set_sglist_fastmode
>> + * Set or clear the fastmode status of the transfer
>> + * In fastmode, DMA register settings are updated from the first el=
ement
>> + * of the linked list, before initiating the tranfer.
>> + * In non-fastmode, the first element is used only after completing=
 the
>> + * transfer as already configured in the registers
>> + */
>> +void omap_dma_set_sglist_fastmode(const int listid, const int fastm=
ode);
>>
>> =A0/* LCD DMA functions */
>> =A0extern int omap_request_lcd_dma(void (*callback)(u16 status, void=
 *data),
>> ---

Apologies for a long break in this thread. Thanks for your detailed
review. I have posted a patch with all your comments taken in.

Best regards,
Venkat.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
