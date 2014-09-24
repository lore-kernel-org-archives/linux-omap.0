From: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v5 1/2] usb: rename phy to usb_phy in HCD
Date: Wed, 24 Sep 2014 22:56:30 +0400
Message-ID: <542313DE.1080709@cogentembedded.com>
References: <5072811.p8odmvpxdS@wasted.cogentembedded.com> <2282553.NrZjRxyKlv@wasted.cogentembedded.com> <20140924051138.GA4440@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140924051138.GA4440-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Peter.Chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
List-Id: linux-omap@vger.kernel.org

hello.

On 09/24/2014 09:11 AM, Greg KH wrote:

>> From: Antoine Tenart <antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

>> The USB PHY member of the HCD structure is renamed to 'usb_phy' and
>> modifications are done in all drivers accessing it.
>> This is in preparation to adding the generic PHY support.

>> Signed-off-by: Antoine Tenart <antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
>> [Sergei: added missing 'drivers/usb/misc/lvstest.c' file, resolved rejects
>> caused by patch reordering, updated changelog.]
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
>> Acked-by: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
>> Acked-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

>> ---
>> Changes in version 5:
>> - imported the patch from Antoine Tenart's series;
>> - added missing 'drivers/usb/misc/lvstest.c' file;
>> - resolved rejects caused by patch reordering;
>> - refreshed patch;
>> - updated changelog.

>>   drivers/usb/chipidea/host.c   |    2 +-
>>   drivers/usb/core/hcd.c        |   20 ++++++++++----------
>>   drivers/usb/core/hub.c        |    8 ++++----
>>   drivers/usb/host/ehci-fsl.c   |   16 ++++++++--------
>>   drivers/usb/host/ehci-hub.c   |    2 +-
>>   drivers/usb/host/ehci-msm.c   |    4 ++--
>>   drivers/usb/host/ehci-tegra.c |   16 ++++++++--------
>>   drivers/usb/host/ohci-omap.c  |   20 ++++++++++----------
>>   drivers/usb/misc/lvstest.c    |    8 ++++----
>>   include/linux/usb/hcd.h       |    2 +-
>>   10 files changed, 49 insertions(+), 49 deletions(-)

> This doesn't apply to my tree at all anymore,

    Well, I'm seeing only a minor reject in the first file, easily fixable.

> can you refresh it and resend?

    OK, will re-post now.

> thanks,

> greg k-h

WBR, Sergei
