From: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH] usb: musb: Fix fifo reads for dm816x with musb_dsps
Date: Thu, 19 Mar 2015 20:49:48 +0300
Message-ID: <550B0C3C.3080107@cogentembedded.com>
References: <1426718882-27187-1-git-send-email-tony@atomide.com> <550ACF61.5000909@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <550ACF61.5000909-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bin Liu <binmlist-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Brian Hutchinson <b.hutchman-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 03/19/2015 04:30 PM, Sergei Shtylyov wrote:

>> Looks like dm81xx can only do 32-bit fifo reads like am35x. Let's set
>> up musb-dsps with a custom read_fifo function based on the compatible
>> flag.

>> Otherwise we can get the following errors when starting dhclient on a
>> asix USB Ethernet adapter:

>> asix 2-1:1.0 eth2: asix_rx_fixup() Bad Header Length 0xffff003c, offset 4

>> While at it, let's also remove pointless cast of the driver data.

>> Cc: Bin Liu <binmlist-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> Cc: Brian Hutchinson <b.hutchman-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> Cc: George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>
>> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
>> ---
>>   drivers/usb/musb/musb_dsps.c | 37 ++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 36 insertions(+), 1 deletion(-)

>> --- a/drivers/usb/musb/musb_dsps.c
>> +++ b/drivers/usb/musb/musb_dsps.c
>> @@ -655,6 +655,36 @@ static int dsps_musb_reset(struct musb *musb)
>>       return !session_restart;
>>   }
>>
>> +/* Similar to am35x, dm81xx support only 32-bit read operation */
>> +static void dsps_read_fifo32(struct musb_hw_ep *hw_ep, u16 len, u8 *dst)
>> +{
>> +    void __iomem *fifo = hw_ep->fifo;
>> +    u32        val;
>> +    int        i;
>> +
>> +    /* Read for 32bit-aligned destination address */
>> +    if (likely((0x03 & (unsigned long)dst) == 0) && len >= 4) {
>> +        readsl(fifo, dst, len >> 2);
>> +        dst += len & ~0x03;
>> +        len &= 0x03;
>> +    }
>> +    /*
>> +     * Now read the remaining 1 to 3 byte or complete length if
>> +     * unaligned address.
>> +     */

>    This comment seems misplaced, it belongs before the next *if*.

>> +    if (len > 4) {
>> +        for (i = 0; i < (len >> 2); i++) {
>> +            *(u32 *)dst = musb_readl(fifo, 0);
>> +            dst += 4;
>> +        }

>     Not sure how this is different to using readsl().

    Ah, the default implementation of musb_readl() uses __raw_readl().
So you'd probably want to keep this loop, not readsl() call.

>> +        len &= 0x03;
>> +    }
>> +    if (len > 0) {
>> +        val = musb_readl(fifo, 0);
>> +        memcpy(dst, &val, len);
>> +    }
>> +}
>> +
>>   static struct musb_platform_ops dsps_ops = {
>>       .quirks        = MUSB_INDEXED_EP,
>>       .init        = dsps_musb_init,
[...]

WBR, Sergei

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
