From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 1/2 v2] ARM: OMAP4: Fix NULL pointer dereference crash.
Date: Mon, 24 Aug 2009 15:39:39 +0300
Message-ID: <87tyzxper8.fsf@deeprootsystems.com>
References: <1250928012-5233-1-git-send-email-santosh.shilimkar@ti.com>
	<87hbvytich.fsf@deeprootsystems.com>
	<87pralqvnp.fsf@deeprootsystems.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02BA434EC2@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f217.google.com ([209.85.220.217]:40882 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752349AbZHXMjl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Aug 2009 08:39:41 -0400
Received: by fxm17 with SMTP id 17so1422831fxm.37
        for <linux-omap@vger.kernel.org>; Mon, 24 Aug 2009 05:39:42 -0700 (PDT)
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02BA434EC2@dbde02.ent.ti.com> (Santosh Shilimkar's message of "Mon\, 24 Aug 2009 17\:56\:00 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "rmk@arm.linux.org.uk" <rmk@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Syed, Rafiuddin" <rafiuddin.syed@ti.com>

"Shilimkar, Santosh" <santosh.shilimkar@ti.com> writes:

>> >>  static inline unsigned int serial_read_reg(struct plat_serial8250_port
>> *up,
>> >>  					   int offset)
>> >>  {
>> >> @@ -550,6 +564,17 @@ static struct omap_uart_state
>> omap_uart[OMAP_MAX_NR_PORTS] = {
>> >>  			},
>> >>  		},
>> >>  	},
>> >> +#ifdef CONFIG_ARCH_OMAP4
>> >> +	{
>> >> +		.pdev = {
>> >> +			.name			= "serial8250",
>> >> +			.id			= PLAT8250_DEV_FOURPORT,
>> >
>> > This should not be FOURPORT, it should just be a number.  In this case,
>> > it should be 3 (the others start from zero.)
>> 
>> Santosh,
>> 
>> I've changed the .id field to '3' and will queue up this fix for the
>> next merge window along with my fixes queue[1].  Please let me know if you
>> want to do otherwise.
>
> This is fine Kevin. Thanks !!
>
> Bye the way I have also posted v3 version in which I changed the .id field to 3.

Yeah, saw that after I replied.  Thanks!

Kevin


