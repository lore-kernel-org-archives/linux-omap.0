From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC PATCH 2/2] usb: dwc3: Add chained TRB support for ep0
Date: Mon, 1 Jun 2015 15:23:48 +0530
Message-ID: <556C2BAC.4070901@ti.com>
References: <1423223735-32512-1-git-send-email-kishon@ti.com> <1423223735-32512-2-git-send-email-kishon@ti.com> <20150206144841.GB16783@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150206144841.GB16783-HgARHv6XitJaoMGHk7MhZQC/G2K4zDHf@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Felipe,

On Friday 06 February 2015 08:18 PM, Felipe Balbi wrote:
> Hi,
>
> On Fri, Feb 06, 2015 at 05:25:35PM +0530, Kishon Vijay Abraham I wrote:
>> dwc3 can do only max packet aligned transfers. So in case request length
>> is not max packet aligned and is bigger than DWC3_EP0_BOUNCE_SIZE
>> two chained TRBs is required to handle the transfer.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
>> ---
>> *) Did eumeration testing with g_zero in kernel
>> *) Similar patch was added in u-boot. With DFU, was able to create a scenario
>> where the request length is not max packet aligned and is bigger than
>> DWC3_EP0_BOUNCE_SIZE (512 bytes). In that case, 2 chained TRBs will be used.
>
> I really need a test case for this. If you have to patch g_zero to have
> a configuration descriptor so large that it's over 512, so be it, but I
> really need to have a test case exposing the problem.

sure.
>
> I also need you to run full USB30CV (for USB2 and USB3 device), together
> with Link Layer Tests (on USB3-only, clearly) using USB30CV and LeCroy's
> compliance suite (there's a slight difference from USB30CV and LeCroy's
> compliance, we must work with both because both are accepted test
> vectors per USB-IF).

sure.
>
>> diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
>> index 24b7925..3b728b8 100644
>> --- a/drivers/usb/dwc3/ep0.c
>> +++ b/drivers/usb/dwc3/ep0.c
>> @@ -56,7 +56,7 @@ static const char *dwc3_ep0_state_string(enum dwc3_ep0_state state)
>>   }
>>
>>   static int dwc3_ep0_start_trans(struct dwc3 *dwc, u8 epnum, dma_addr_t buf_dma,
>> -		u32 len, u32 type)
>> +		u32 len, u32 type, unsigned chain)
>>   {
>>   	struct dwc3_gadget_ep_cmd_params params;
>>   	struct dwc3_trb			*trb;
>> @@ -70,7 +70,10 @@ static int dwc3_ep0_start_trans(struct dwc3 *dwc, u8 epnum, dma_addr_t buf_dma,
>>   		return 0;
>>   	}
>>
>> -	trb = dwc->ep0_trb;
>> +	trb = &dwc->ep0_trb[dep->free_slot];
>> +
>> +	if (chain)
>> +		dep->free_slot++;
>>
>>   	trb->bpl = lower_32_bits(buf_dma);
>>   	trb->bph = upper_32_bits(buf_dma);
>> @@ -78,10 +81,17 @@ static int dwc3_ep0_start_trans(struct dwc3 *dwc, u8 epnum, dma_addr_t buf_dma,
>>   	trb->ctrl = type;
>>
>>   	trb->ctrl |= (DWC3_TRB_CTRL_HWO
>> -			| DWC3_TRB_CTRL_LST
>> -			| DWC3_TRB_CTRL_IOC
>>   			| DWC3_TRB_CTRL_ISP_IMI);
>>
>> +	if (chain)
>> +		trb->ctrl |= DWC3_TRB_CTRL_CHN;
>> +	else
>> +		trb->ctrl |= (DWC3_TRB_CTRL_IOC
>> +				| DWC3_TRB_CTRL_LST);
>> +
>> +	if (chain)
>> +		return 0;
>> +
>>   	memset(&params, 0, sizeof(params));
>>   	params.param0 = upper_32_bits(dwc->ep0_trb_addr);
>>   	params.param1 = lower_32_bits(dwc->ep0_trb_addr);
>> @@ -302,7 +312,7 @@ void dwc3_ep0_out_start(struct dwc3 *dwc)
>>   	int				ret;
>>
>>   	ret = dwc3_ep0_start_trans(dwc, 0, dwc->ctrl_req_addr, 8,
>> -			DWC3_TRBCTL_CONTROL_SETUP);
>> +			DWC3_TRBCTL_CONTROL_SETUP, false);
>>   	WARN_ON(ret < 0);
>>   }
>>
>> @@ -817,6 +827,22 @@ static void dwc3_ep0_complete_data(struct dwc3 *dwc,
>>
>>   	maxp = ep0->endpoint.maxpacket;
>>
>> +	/* Handle the first TRB before handling the bounce buffer if the request
>> +	 * length is greater than the bounce buffer size
>> +	 */
>> +	if (!IS_ALIGNED(ur->length, maxp) &&
>> +	    ur->length > DWC3_EP0_BOUNCE_SIZE) {
>> +		transfer_size = (ur->length / maxp) * maxp;
>
> you can use ALIGN() for this which is more efficient. Note however that
> this is not safe, see below.

right, I can achieve the same using ALIGN(ur->length - maxp, maxp);
>
>> +		transferred = transfer_size - length;
>> +		buf = (u8 *)buf + transferred;
>> +		ur->actual += transferred;
>
> this is dangerous. The extra size is because you *must* align OUT to
> wMaxPacketSize, so you cannot allow more than the original req->length
> to be copied into buf. That bounce buffer, is really supposed to be a

Here we are not handling bounce buffer. The bounce buffer is used only for the 
2nd TRB which actually programs to receive data that is less than bounce buffer 
size. The 1st TRB will always be max packet aligned and the data is directly 
copied to the request buffer. (However note that if the request length is less 
than bounce buffer size, we'll use 1 TRB only)

To summarize..
We are splitting req->length into 2 TRB's if the req->length is not aligned to 
wMaxPacketSize _and_ req->length is greater than bounce buffer size. By this 
way we can make the 2nd TRB to receive data lesser than or equal to bounce 
buffer size and the rest of it can be received using the 1st TRB.

Consider the following case.
ur->length = 612;
maxp = 512;

This case can't be handled by the existing bounce buffer mechanism since the 
size of bounce buffer is only 512. So we program 2 TRB's.
First TRB
trb->size = 512; /* We don't need bounce buffer for this TRB since it is max 
packet aligned. The data is directly loaded to the request buffer. */

Second TRB
trb->size = 512 /* For the remaining 100 bytes we use bounce buffer and it uses 
the same existing bounce buffer mechanism. But instead of copying the data to 
the start of the request buffer, it has to be appended to the data that is 
received due to first TRB. */

> throw-away buffer and should never have data in it. You should really
> add a big fat WARN() if transferred > req->length.
>
> The thing is that if host sends more data than we were expecting, this
> could be someone trying to use our driver as an exploit vector, trying
> to send more data than it should. We must be robust against that.

This is handled in the existing bounce buffer mechanism and I use the same 
bounce buffer mechanism for the 2nd TRB.
>
>> +
>> +		trb++;
>> +		length = trb->size & DWC3_TRB_SIZE_MASK;
>> +
>> +		ep0->free_slot = 0;
>> +	}
>> +
>>   	if (dwc->ep0_bounced) {
>>   		transfer_size = roundup((ur->length - transfer_size),
>>   					maxp);
>> @@ -844,7 +870,7 @@ static void dwc3_ep0_complete_data(struct dwc3 *dwc,
>>
>>   			ret = dwc3_ep0_start_trans(dwc, epnum,
>>   					dwc->ctrl_req_addr, 0,
>> -					DWC3_TRBCTL_CONTROL_DATA);
>> +					DWC3_TRBCTL_CONTROL_DATA, false);
>>   			WARN_ON(ret < 0);
>>   		}
>>   	}
>> @@ -928,7 +954,7 @@ static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
>>   	if (req->request.length == 0) {
>>   		ret = dwc3_ep0_start_trans(dwc, dep->number,
>>   				dwc->ctrl_req_addr, 0,
>> -				DWC3_TRBCTL_CONTROL_DATA);
>> +				DWC3_TRBCTL_CONTROL_DATA, false);
>>   	} else if (!IS_ALIGNED(req->request.length, dep->endpoint.maxpacket)
>>   			&& (dep->number == 0)) {
>>   		u32	transfer_size = 0;
>> @@ -941,22 +967,26 @@ static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
>>   			return;
>>   		}
>>
>> -		WARN_ON(req->request.length > DWC3_EP0_BOUNCE_SIZE);
>> -
>>   		maxpacket = dep->endpoint.maxpacket;
>> +
>> +		if (req->request.length > DWC3_EP0_BOUNCE_SIZE) {
>> +			transfer_size = (req->request.length / maxpacket) *
>> +						maxpacket;
>> +			ret = dwc3_ep0_start_trans(dwc, dep->number,
>> +						   req->request.dma,
>> +						   transfer_size,
>> +						   DWC3_TRBCTL_CONTROL_DATA,
>> +						   true);
>
> I would prefer to split this even further. First add the new chain
> parameter, then make use of it. This means that anywhere chain is false,
> would not be part of $subject.

Sure.

Thanks
Kishon
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
