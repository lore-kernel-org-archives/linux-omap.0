From: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/5] usb: musb: conditionally save and restore the context
 on suspend
Date: Mon, 25 Nov 2013 21:27:29 +0100
Message-ID: <5293B2B1.4010108@gmail.com>
References: <1385408393-19707-1-git-send-email-zonque@gmail.com> <1385408393-19707-2-git-send-email-zonque@gmail.com> <20131125194427.GZ18046@saruman.home> <5293AE53.9080606@gmail.com> <20131125201339.GH18046@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131125201339.GH18046-HgARHv6XitL9zxVx7UNMDg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, neumann-SRDuVqtxQLSzQB+pC5nmwQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 11/25/2013 09:13 PM, Felipe Balbi wrote:
> Hi,
> 
> On Mon, Nov 25, 2013 at 09:08:51PM +0100, Daniel Mack wrote:
>> On 11/25/2013 08:44 PM, Felipe Balbi wrote:
>>> Hi,
>>>
>>> On Mon, Nov 25, 2013 at 08:39:49PM +0100, Daniel Mack wrote:
>>>> It appears not all platforms featuring a musb core need to save the musb
>>>> core registers at suspend time and restore them on resume.
>>>>
>>>> The dsps platform does, however. So add a bit in struct
>>>> musb_hdrc_platform_data to let platforms specify their need of such
>>>> action being taken.
>>>>
>>>> Signed-off-by: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>>> ---
>>>>  drivers/usb/musb/musb_core.c | 17 ++++++++++++++++-
>>>>  include/linux/usb/musb.h     |  3 +++
>>>>  2 files changed, 19 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
>>>> index 0a43329..a8ded57 100644
>>>> --- a/drivers/usb/musb/musb_core.c
>>>> +++ b/drivers/usb/musb/musb_core.c
>>>> @@ -2202,6 +2202,7 @@ static int musb_suspend(struct device *dev)
>>>>  {
>>>>  	struct musb	*musb = dev_to_musb(dev);
>>>>  	unsigned long	flags;
>>>> +	struct musb_hdrc_platform_data *plat = dev_get_platdata(dev);
>>>
>>> we don't want to have platform_data on DT-based boot. It's best to just
>>> save those registers unconditionally as it doesn't hurt.
>>>
>>
>> My concern about doing it unconditionally from the core is simply that I
>> fear regressions for other platforms. I can of course drop it if you're
>> certain that that's correct.
>>
>> I can only test this on a dsps glue layer, and I have no documentation
>> for the musb core. All I'm left with here is fishing in muddy waters :/
> 
> I really don't think it should cause any issues with any other platform.
> 
> We can make to leave this soaking in linux-next for a long time and hope
> people test it.
> 

Ok, sounds good. I'll do it and repost, along with the other changes.


Many thanks,
Daniel


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
