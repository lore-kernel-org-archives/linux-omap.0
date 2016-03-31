From: Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: USB gadgets with configfs hang reboot
Date: Thu, 31 Mar 2016 19:32:44 +0300
Message-ID: <56FD512C.2070108@gmail.com>
References: <Pine.LNX.4.44L0.1603301509180.2194-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1603301509180.2194-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, =?UTF-8?Q?pali_Roh=c3=a1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Robert Baldyga <r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Andrzej Pietrasiewicz <andrzej.p-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org



On 30.03.2016 22:25, Alan Stern wrote:
> On Wed, 30 Mar 2016, Ivaylo Dimitrov wrote:
>
>>>>> seems to be created twice :). Maybe the problem is that the first time
>>>>> musb-hdrc is probed it fails with -EPROBE_DEFER, however that failure is
>>>>> after gadget drivers got loaded and noone unloads them.
>>>>
>>>> gadget drivers will get added to a pending list, then later they'll
>>>> bind. But they shouldn't bind() twice, unless there are multiple
>>>> interfaces for them.
>>>>
>>>
>>> Well, then it seems we have problem, as the 2 unbind() calls are with
>>> one and the same "common" pointer (again, from memory).
>>>
>>>>> Just some wild guesses based on my memories as I've lost the logs (power
>>>>> outage). For sure I can recreate them if needed.
>>>>
>>>> okay.
>>>
>>> I will redo dump_stack() and printks and will provide logs as soon as I
>>> have some time, so to stop counting on my memories.
>>>
>>
>> Please find attached the relevant logs. It really seems that g_nokia is
>> probed twice, with all the gadgets in it created two times. I am
>> starting to suspect 855ed04a3758b205e84b269f92d26ab36ed8e2f7 ("usb:
>> gadget: udc-core: independent registration of gadgets and gadget
>> drivers") has something to do with the problem, though reverting it
>> resulted in g_nokia not being probed at all :)
>
> The problem is not caused by nokia_bind() getting called twice.  The
> log clearly shows that nokia_bind() is called only once, but it calls
> usb_add_config() from two different places:
>
> Jan  1 02:00:10 Nokia-N900 kernel: [    8.002838] [<c040c5b4>] (usb_add_config) from [<c041b274>] (nokia_bind+0x160/0x2f0)
> Jan  1 02:00:10 Nokia-N900 kernel: [    8.014526] [<c041b274>] (nokia_bind) from [<c040e128>] (composite_bind+0x68/0x1a0)
> ...
> Jan  1 02:00:10 Nokia-N900 kernel: [    8.381286] [<c040c5b4>] (usb_add_config) from [<c041b28c>] (nokia_bind+0x178/0x2f0)
> Jan  1 02:00:10 Nokia-N900 kernel: [    8.394348] [<c041b28c>] (nokia_bind) from [<c040e128>] (composite_bind+0x68/0x1a0)
>
> Everything else along the two pathways is the same, so this is where
> the multiple binds come from.  And indeed, looking at the code in
> nokia_bind() you can see the two calls:
>
>          /* finally register the configuration */
>          status = usb_add_config(cdev, &nokia_config_500ma_driver,
>                          nokia_bind_config);
>          if (status < 0)
>                  goto err_msg_luns;
>
>          status = usb_add_config(cdev, &nokia_config_100ma_driver,
>                          nokia_bind_config);
>

Right, somehow I've overslept there are two different nokia_bind+XXX values.

> This isn't supposed to cause any problems.  The two instances should
> never run at the same time, because they belong to different configs.
>

The problem seems to be that fsg driver creates a thread for every 
fsg_bind() call, which overwrites common->thread_task without first 
checking if a thread is already created. I don't know the idea behind - 
should it have only one thread for all instances, or there should be a 
thread per instance, but anyway the current implementation looks wrong.

Ivo
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
