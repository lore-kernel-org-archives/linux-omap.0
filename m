From: <roman.tereshonkov@nokia.com>
Subject: RE: enabling uart2 on omap5912 osk
Date: Wed, 21 May 2008 20:41:18 +0300
Message-ID: <96D01537CAEBF940B0144E7F8E88229C03A9A49B@esebe102.NOE.Nokia.com>
References: <a1d91fa0805202342k706a4389h54b5b89178991d86@mail.gmail.com> <20080521154010.GY23002@atomide.com> <a1d91fa0805211012v607195f2we8cc373b5a54ae4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:23804 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936180AbYEURmG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 May 2008 13:42:06 -0400
Content-class: urn:content-classes:message
In-Reply-To: <a1d91fa0805211012v607195f2we8cc373b5a54ae4@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mdshareef@gmail.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-omap-open-source@linux.omap.com


Each bit enables one uart.
For uarts 1, 2, 3 it will look like:

static struct omap_uart_config osk_uart_config __initdata = {
	.enabled_uarts = (1 << 0) | (1 << 1) | (1 << 2),
};


Just a hint. You can look board-xxx.c config files and see examples
there.



Roman Tereshonkov

-----Original Message-----
From: linux-omap-owner@vger.kernel.org
[mailto:linux-omap-owner@vger.kernel.org] On Behalf Of ext mohammed
shareef
Sent: 21 May, 2008 20:12
To: Tony Lindgren
Cc: omap; linux-omap-open-source@linux.omap.com
Subject: Re: enabling uart2 on omap5912 osk

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
>> and is there a way by which i can test if the uart2 has been
recongnised?
>>
>> i dont see uart module being initialized during the kernel boot-up.
>
> You need to enable it in board-osk.c, see enabled_uarts. Then to use
it
> you also need the right hardware attached to it.
>
> Tony
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
