From: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 5/5] dma: cppi41: add support for suspend and resume
Date: Sun, 22 Sep 2013 16:39:30 +0200
Message-ID: <523F0122.2030904@gmail.com>
References: <1379851068-18675-1-git-send-email-zonque@gmail.com> <1379851068-18675-6-git-send-email-zonque@gmail.com> <523EFDD9.4060906@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <523EFDD9.4060906-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, neumann-SRDuVqtxQLSzQB+pC5nmwQ@public.gmane.org, bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 22.09.2013 16:25, Sergei Shtylyov wrote:
> On 22-09-2013 15:57, Daniel Mack wrote:
>> +#ifdef CONFIG_PM_SLEEP
> [...]
>> +static SIMPLE_DEV_PM_OPS(cppi41_pm_ops, cppi41_suspend, cppi41_resume);
>> +
>> +#define DEV_PM_OPS (&cppi41_pm_ops)
>> +#else
>> +#define DEV_PM_OPS NULL
>> +#endif
> 
>     You don't need that with SIMPLE_DEV_PM_OPS(), just get it out of #ifdef.

Ah, now I see it. Thanks for the heads-up!


Daniel

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
