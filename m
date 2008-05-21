From: "mohammed shareef" <mdshareef@gmail.com>
Subject: Re: enabling uart2 on omap5912 osk
Date: Wed, 21 May 2008 22:42:11 +0530
Message-ID: <a1d91fa0805211012v607195f2we8cc373b5a54ae4@mail.gmail.com>
References: <a1d91fa0805202342k706a4389h54b5b89178991d86@mail.gmail.com>
	 <20080521154010.GY23002@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.185]:53566 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763156AbYEURMM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 May 2008 13:12:12 -0400
Received: by ti-out-0910.google.com with SMTP id b6so1516191tic.23
        for <linux-omap@vger.kernel.org>; Wed, 21 May 2008 10:12:11 -0700 (PDT)
In-Reply-To: <20080521154010.GY23002@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: omap <linux-omap@vger.kernel.org>, linux-omap-open-source@linux.omap.com

i see the following lines in the omap-osk.c file regarding the uarts:

static struct omap_uart_config osk_uart_config __initdata = {
	.enabled_uarts = (1 << 0),
};


what does it mean? i want all my uarts (1,2,3) enabled. how do i have
to modify the above line?

thanx for the help.

regards,
Shareef

On Wed, May 21, 2008 at 9:10 PM, Tony Lindgren <tony@atomide.com> wrote:
> * mohammed shareef <mdshareef@gmail.com> [080520 23:43]:
>> Hello,
>>
>> How do i enable UART2 on omap5912_osk in the kernel?
>>
>> and is there a way by which i can test if the uart2 has been recongnised?
>>
>> i dont see uart module being initialized during the kernel boot-up.
>
> You need to enable it in board-osk.c, see enabled_uarts. Then to use it
> you also need the right hardware attached to it.
>
> Tony
>
