From: Nick Krause <xerofoify@gmail.com>
Subject: Re: omap-wakeupgen.c: Remove function for fix me
Date: Wed, 23 Jul 2014 11:08:51 -0400
Message-ID: <CAPDOMVjrSskMHq0ZdB6mpGJBn9gvbpguLSK-+aHaV9k0QrqzHA@mail.gmail.com>
References: <CAPDOMVinWFVKY=mMOA1f6pd4orOgcKh1kE01MPVaLZi0Z_tMmg@mail.gmail.com>
	<20140723074328.GI18374@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140723074328.GI18374@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Jul 23, 2014 at 3:43 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Nick Krause <xerofoify@gmail.com> [140722 14:12]:
>> static void __init irq_pm_init(void)
>> 382 {
>> 383         /* FIXME: Remove this when MPU OSWR support is added */
>> 384         if (!soc_is_omap54xx())
>> 385                 cpu_pm_register_notifier(&irq_notifier_block);
>> 386 }
>> I am wondering is this omap supported now if it is can I remove it?
>
> Does REVISIT cause issues for you with cscope? It may be easier to
> replace the cscope bugging FIXME statements with just REVISIT unless
> a real fix is provided.
>
> Regards,
>
> Tony


Very well then , seems like a good idea will try later.
Nick
