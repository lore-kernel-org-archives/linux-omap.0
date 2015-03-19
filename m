From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC][PATCH 8/9] usb: otg-fsm: Remove unused members in struct
 otg_fsm
Date: Thu, 19 Mar 2015 12:20:47 +0200
Message-ID: <550AA2FF.8080800@ti.com>
References: <1426686963-11613-1-git-send-email-rogerq@ti.com> <1426686963-11613-9-git-send-email-rogerq@ti.com> <20150319034620.GB7779@shlinux2>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150319034620.GB7779@shlinux2>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Chen <peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 19/03/15 05:46, Peter Chen wrote:
> On Wed, Mar 18, 2015 at 03:56:02PM +0200, Roger Quadros wrote:
>> These members are not used anywhere so remove them.
>>
>> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
>> ---
>>  include/linux/usb/otg-fsm.h | 5 -----
>>  1 file changed, 5 deletions(-)
>>
>> diff --git a/include/linux/usb/otg-fsm.h b/include/linux/usb/otg-fsm.h
>> index b6ba1bf..176c4fc 100644
>> --- a/include/linux/usb/otg-fsm.h
>> +++ b/include/linux/usb/otg-fsm.h
>> @@ -95,11 +95,6 @@ struct otg_fsm {
>>  	int b_hnp_enable;
>>  	int a_clr_err;
>>  
>> -	/* Informative variables */
>> -	int a_bus_drop_inf;
>> -	int a_bus_req_inf;
>> -	int a_clr_err_inf;
>> -	int b_bus_req_inf;
>>  	/* Auxilary informative variables */
>>  	int a_suspend_req_inf;
>>  
> 
> But the above are defined at: ch 7.4.4, On-The-Go and Embedded Host
> Supplement to the USB Revision 2.0 Specification

I can leave them there then but just add a note saying that they are
not yet used by the OTG FSM.

cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
