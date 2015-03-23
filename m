From: Petr Kulhavy <petr@barix.com>
Subject: Re: Serious memory leak in TI EDMA driver (drivers/dma/edma.c)
Date: Mon, 23 Mar 2015 16:45:19 +0100
Message-ID: <5510350F.5070906@barix.com>
References: <55072E56.7050802@barix.com> <5508205D.7010106@ti.com> <55087A3A.6070300@barix.com> <55098414.9020301@ti.com> <5509EF23.8080404@barix.com> <550C27C3.10406@ti.com> <550C96E8.5080603@barix.com> <55103130.70906@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:33224 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752793AbbCWPpX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Mar 2015 11:45:23 -0400
Received: by wgbcc7 with SMTP id cc7so149195550wgb.0
        for <linux-omap@vger.kernel.org>; Mon, 23 Mar 2015 08:45:22 -0700 (PDT)
In-Reply-To: <55103130.70906@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org

Hi Peter,

I've just posted a patch to the community, you should have received 
another email from me just a few minutes ago.
Basically there should be a kfree in terminate_all() just before 
echan->edesc is set to NULL.
The reason is that at that point the edesc is in none of the vchan lists 
(edma_execute() removes it from the "issued" list)
and vchan_get_all_descriptors() doesn't find it.

With the extra kfree the mem leak is not seen any more.
It's a good question why terminate_all is called before the transfer 
finished, but I thought it could be called at any time?

I'm also not sure if the echan->edesc shouldn't be free also in 
edma_execute(), could you please check that? :

static void edma_execute(struct edma_chan *echan)
{
     struct virt_dma_desc *vdesc;
     struct edma_desc *edesc;
     struct device *dev = echan->vchan.chan.device->dev;
     int i, j, left, nslots;

     /* If either we processed all psets or we're still not started */
     if (!echan->edesc ||
         echan->edesc->pset_nr == echan->edesc->processed) {
         /* Get next vdesc */
         vdesc = vchan_next_desc(&echan->vchan);
         if (!vdesc) {
             dev_dbg(dev, "Setting edesc 0x%p to NULL\n",echan->edesc);
             echan->edesc = NULL;
#warning "possible memory leak here ?"
             return;
         }
         list_del(&vdesc->node);        // at this point node was in issued
         echan->edesc = to_edma_desc(&vdesc->tx);
     }

I'll post another patch for the wrong type in edma_alloc_chan_resources()


Regards
Petr


On 23.03.2015 16:28, Peter Ujfalusi wrote:
> On 03/20/2015 11:53 PM, Petr Kulhavy wrote:
>> Hi Peter,
>>
>> yes, that is one of the differences to the EVM that the SD card is on MMCSD1.
>> This is due to the pin multiplexer and other peripherals we're using.
>>
>> Your patch is correct, however the edma_callback()  is using the channel
>> number parameter for debug messages only. For the actual work echan->ch_num is
>> used. BTW is that correct? Could there be a mismatch between the echan->ch_num
>> and the ch_num parameter?
>>
>> Something else seems to be odd in edma_alloc_chan_resources():
>>
>> /* Alloc channel resources */
>> static int edma_alloc_chan_resources(struct dma_chan *chan)
>> {
>>          struct edma_chan *echan = to_edma_chan(chan);
>>          struct device *dev = chan->device->dev;
>>          int ret;
>>          int a_ch_num;
>>          LIST_HEAD(descs);
>>
>>          a_ch_num = edma_alloc_channel(echan->ch_num, edma_callback,
>>                                          chan, EVENTQ_DEFAULT);
> Hah, yes this is wrong but worked so far fine because:
> struct edma_chan {
> 	struct virt_dma_chan		vchan;
> ...
> };
>
> struct virt_dma_chan {
> 	struct dma_chan	chan;
> ...
> };
>
> so &edma_chan == &edma_chan.vchan.chan;
>
> But this is not why you see the leak.
>
> What I did on my board is that I have swapped in SW the cc0 and cc1, now mmc0
> is on cc1 from the sw point of view, but still can not reproduce the issue.
>
>> The third parameter to edma_alloc_channel() should be echan, not chan, since
>> the edma_callback() interprets the callback data parameter as struct edma_chan *.
>>
>> Let me know if you find something or if you have an advice for more debug.
>  From the log I would go and see what happens in the
> vchan_get_all_descriptors() and vchan_dma_desc_free_list(), is it so that at
> terminate_all time the list we got is empty? But why it is?
>
> It seams you got the terminate_all call before the transfer finished, this is
> also interesting. I'll look at at this more deeply.
> What I see is that at terminate_all we clear the echan->edesc and for some
> reason the vchan code will not free the desc. Later the completion interrupt
> comes, but since the echan->edesc is NULL we do nothing. This causes the leak.
>
> The question to all of this why and how to reproduce it?
>

