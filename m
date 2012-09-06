From: Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
Subject: Re: [PATCH] musb: Kill __init from function that are called at other times as well.
Date: Thu, 6 Sep 2012 20:36:39 +0300
Message-ID: <7CED20FA-3501-40ED-B289-28FDC04FCF20@antoniou-consulting.com>
References: <1346940106-20269-1-git-send-email-panto@antoniou-consulting.com> <20120906130425.GF29202@arwen.pp.htv.fi> <B7BE7E99-90E8-4E54-B146-C09C6643BAFE@antoniou-consulting.com> <20120906170740.GB17754@arwen.pp.htv.fi>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120906170740.GB17754-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Russ Dill <Russ.Dill-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Felipe

I see about __devinit.
There's no crash because in those logs the __init modifiers are gone.

Regards

-- Pantelis


On Sep 6, 2012, at 8:07 PM, Felipe Balbi wrote:

> Hi,
> 
> On Thu, Sep 06, 2012 at 05:58:27PM +0300, Pantelis Antoniou wrote:
>> Hi Felipe,
>> 
>> A proper answer required some instrumentation printks().
>> 
>> So what I did is that I peppered each function marked with a removed
>> __init or __devinit with a 
>> 
>>> printk(KERN_INFO "%s:%d (%s) %s\n", __FILE__, __LINE__, KBUILD_MODNAME, __func__);
>>> 
>> 
>> Both omap2430 & musb_hdrc are compiled as module, and I issued the following 
>> commands on a beagleboard xm.
>> 
>> # modprobe omap2430
>> # modprobe g_mass_storage file=backing_file
>> # rmmod g_mass_storage
>> # rmmod omap2430
>> # modprobe omap2430
>> 
>> The problem is obvious when you see that functions marked as init or devinit are
>> called when re-loading the omap2430 module again. Those functions if marked as
>> much can (and will as I have witnessed) be removed from memory, leading to a 
>> crash.
>> 
>> What do you think?
> 
> the problem would be with usage of __init. __devinit will only drop
> .devinit.text if HOTPLUG and MODULE isn't set, AFAICT. I also can't see
> a crash on below logs.
> 
> -- 
> balbi

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
