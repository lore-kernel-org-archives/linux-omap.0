From: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 1/2] usb: rename 'phy' field of 'struct usb_hcd' to 'transceiver'
Date: Wed, 09 Apr 2014 20:53:56 +0400
Message-ID: <53457B24.1030900@cogentembedded.com>
References: <201404091757.16574.sergei.shtylyov@cogentembedded.com> <534567BA.5030208@wwwdotorg.org> <534574FB.7060901@cogentembedded.com> <534579D5.10306@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <534579D5.10306-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Peter.Chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 04/09/2014 08:48 PM, Stephen Warren wrote:

>>>> Return to the 'phy' field of 'struct usb_hcd' its historic name
>>>> 'transceiver'.
>>>> This is in preparation to adding the generic PHY support.

>>> Surely if the correct term is transceiver, we should be adding generic
>>> transceiver support not generic PHY support? To be honest, this rename
>>> feels like churn, especially since the APIs and DT bindings all still
>>> include the work phy so now everything will be inconsistent.

>>     How about 'usb_phy'?

> That certainly would make things more consistent, but I wonder why
> "usb_phy" is better than "phy" when the code/struct in question is
> something USB-specific; the "usb_" prefix seems implicit to me due to
> context.

    I tend to agree. However, I need to name the new field of stype 'struct 
phy *' somehow... perhaps something like 'gen_phy' for it would do?

WBR, Sergei
