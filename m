From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v9 11/14] usb: otg: use dev_dbg() instead of VDBG()
Date: Thu, 9 Jun 2016 10:25:39 +0300
Message-ID: <575919F3.7020807@ti.com>
References: <1465376626-30122-1-git-send-email-rogerq@ti.com>
 <1465376626-30122-12-git-send-email-rogerq@ti.com>
 <1465398640.25087.50.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1465398640.25087.50.camel-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>, peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org
Cc: balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 08/06/16 18:10, Joe Perches wrote:
> On Wed, 2016-06-08 at 12:03 +0300, Roger Quadros wrote:
>> Now that we have a device reference in struct usb_otg
>> let's use dev_dbg() for debug messages.
> 
> dev_vdbg vs dev_dbg
> 
> The patch subject and commit message don't match the code changes.

Indeed. Will fix it. Thanks.

> 
>> diff --git a/drivers/usb/common/usb-otg-fsm.c b/drivers/usb/common/usb-otg-fsm.c
> []
>> @@ -44,8 +37,9 @@ static int otg_set_protocol(struct otg_fsm *fsm, int protocol)
>>  	int ret = 0;
>>  
>>  	if (fsm->protocol != protocol) {
>> -		VDBG("Changing role fsm->protocol= %d; new protocol= %d\n",
>> -			fsm->protocol, protocol);
>> +		dev_vdbg(otg->dev,
>> +			 "Changing role fsm->protocol= %d; new protocol= %d\n",
>> +			 fsm->protocol, protocol);
> 
> etc...
> 

--
cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
