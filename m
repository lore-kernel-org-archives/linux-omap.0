From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v9 00/14] USB OTG/dual-role framework
Date: Thu, 9 Jun 2016 10:30:53 +0300
Message-ID: <57591B2D.7080403@ti.com>
References: <1465376626-30122-1-git-send-email-rogerq@ti.com>
 <CAL411-owotvsJVEnbFh5g8yK7YEPnnpBhYx9_tRf6NQET38L+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAL411-owotvsJVEnbFh5g8yK7YEPnnpBhYx9_tRf6NQET38L+A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Peter Chen <peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org
Cc: balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Peter & Yoshihiro,

On 09/06/16 08:27, Peter Chen wrote:
> On Wed, Jun 8, 2016 at 5:03 PM, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> wrote:
>> Hi,
>>
>> This series centralizes OTG/Dual-role functionality in the kernel.
>> As of now I've got Dual-role functionality working pretty reliably on
>> dra7-evm and am437x-gp-evm.
>>
>> DWC3 controller and TI platform related patches will be sent separately.
>>
>> Series is based on v4.7-rc1.
>>
> 
> Roger, I will wait your dwc3 and TI patch set since one framework needs
> one user at least, thanks.

Sure I will post the dwc3 patch.

Yoshihiro,

could you please post the platform side patches for your platform
that enables dual-role using this framework? Thanks.

--
cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
