From: Arend van Spriel <arend@broadcom.com>
Subject: Re: [PATCH v2 2/2] dmaengine: omap-dma: Restore the CLINK_CTRL in
 resume path
Date: Tue, 16 Sep 2014 15:59:27 +0200
Message-ID: <5418423F.4010007@broadcom.com>
References: <1410875629-1540-1-git-send-email-peter.ujfalusi@ti.com> <1410875629-1540-3-git-send-email-peter.ujfalusi@ti.com> <20140916135649.GF12379@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140916135649.GF12379@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: vinod.koul@intel.com, dan.j.williams@intel.com, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 09/16/14 15:56, Russell King - ARM Linux wrote:
> On Tue, Sep 16, 2014 at 04:53:49PM +0300, Peter Ujfalusi wrote:
>> When the audio stream is paused or suspended we stop the sDMA and when it
>> is unpaused/resumed we start the channel without reconfiguring it.
>> The omap_dma_stop() clears the link configuration when we pause the dma, but
>> it is not setting it back on start. This will result only one audio buffer
>> to be played back and the DMA will stop, since the linking is disabled.
>> We need to restore the CLINK_CTRL register in case of resume.
>>
>> Signed-off-by: Peter Ujfalusi<peter.ujfalusi@ti.com>
>
> Both of these patches now look good, thanks.  For both:
>
> Acked-by: Russell King<rmk+kernel@arm.linux.org.uk>
>
>> ---
>>   drivers/dma/omap-dma.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
>> index c01ea505ee7c..e0990c505889 100644
>> --- a/drivers/dma/omap-dma.c
>> +++ b/drivers/dma/omap-dma.c
>> @@ -1019,6 +1019,9 @@ static int omap_dma_resume(struct omap_chan *c)
>>   	if (c->paused) {
>>   		mb();
>>
>> +		/* Restore chanel link register */

Just too bad that the comment seems to have a typo.

>> +		omap_dma_chan_write(c, CLNK_CTRL, c->desc->clnk_ctrl);
>> +
>>   		omap_dma_start(c, c->desc);
>>   		c->paused = false;
>>   	}
>> --
>> 2.1.0
>>
>
