From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 1/2] usb: rename 'phy' field of 'struct usb_hcd' to 'transceiver'
Date: Wed, 09 Apr 2014 11:37:09 -0600
Message-ID: <53458545.4030907@wwwdotorg.org>
References: <201404091757.16574.sergei.shtylyov@cogentembedded.com> <534567BA.5030208@wwwdotorg.org> <534574FB.7060901@cogentembedded.com> <534579D5.10306@wwwdotorg.org> <53457B24.1030900@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <53457B24.1030900@cogentembedded.com>
Sender: linux-sh-owner@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org
Cc: Peter.Chen@freescale.com, stern@rowland.harvard.edu, thierry.reding@gmail.com, balbi@ti.com, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org, magnus.damm@gmail.com
List-Id: linux-omap@vger.kernel.org

On 04/09/2014 10:53 AM, Sergei Shtylyov wrote:
> On 04/09/2014 08:48 PM, Stephen Warren wrote:
> 
>>>>> Return to the 'phy' field of 'struct usb_hcd' its historic name
>>>>> 'transceiver'.
>>>>> This is in preparation to adding the generic PHY support.
> 
>>>> Surely if the correct term is transceiver, we should be adding generic
>>>> transceiver support not generic PHY support? To be honest, this rename
>>>> feels like churn, especially since the APIs and DT bindings all still
>>>> include the work phy so now everything will be inconsistent.
> 
>>>     How about 'usb_phy'?
> 
>> That certainly would make things more consistent, but I wonder why
>> "usb_phy" is better than "phy" when the code/struct in question is
>> something USB-specific; the "usb_" prefix seems implicit to me due to
>> context.
> 
>    I tend to agree. However, I need to name the new field of stype
> 'struct phy *' somehow... perhaps something like 'gen_phy' for it would do?

Ok, the existing field is being replaced by something? I didn't get that
from the patch description; I thought the new name in this patch was
going to be it. In that case, a temporary name of usb_phy for the
existing field, or adding the new field as gen_phy sound reasonable.

