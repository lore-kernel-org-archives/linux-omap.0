From: <Tero.Kristo@nokia.com>
Subject: RE: [PATCH] Added sleep support to UART
Date: Thu, 12 Jun 2008 11:48:53 +0300
Message-ID: <B71CE868F2BC2847B3F23C5A8EE3943024C0F4@vaebe110.NOE.Nokia.com>
References: <> <1213106931-17954-1-git-send-email-tero.kristo@nokia.com> <alpine.DEB.1.00.0806111712520.21166@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:37286 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752372AbYFLItV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Jun 2008 04:49:21 -0400
Content-class: urn:content-classes:message
In-Reply-To: <alpine.DEB.1.00.0806111712520.21166@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: linux-omap@vger.kernel.org

Hi, 

>A few minor comments based on a quick look.
>
>In terms of the OMAP3 code, is that for retention-idle only, 
>or does it work with off-idle also?  

That patch should basically work in off-mode also, however it requires
correct settings in the padconfig registers which are currently done in
the boot code. Also, currently I have not had any chance to actually
test this in off-mode, I am still trying to get the off-mode work on my
HW.

>
>On Tue, 10 Jun 2008, Tero Kristo wrote:
>
>> +const u32 omap2_uart_wk_bit[OMAP_MAX_NR_PORTS] = {
>> +       OMAP24XX_ST_UART1, OMAP24XX_ST_UART2, OMAP24XX_ST_UART3 };
>
>Looks like that can be static.  

True.

>
>> +/* UART padconfig registers, these may differ if 
>non-default padconfig
>> +   is used */
>> +#define CONTROL_PADCONF_UART1_RX 0x48002182 #define 
>> +CONTROL_PADCONF_UART2_RX 0x4800217A #define 
>CONTROL_PADCONF_UART3_RX 
>> +0x4800219E #define PADCONF_WAKEUP_ST 0x8000
>
>Please use omap_ctrl_read{b,w,l}() rather than 
>omap_read{b,w,l}() for SCM addresses.

Hmm yea, could do.

>Also, the above are register addresses + 2.  Is it possible to 
>use the actual register addresses (ideally they should be 
>defined in include/asm-arm/arch-omap/control.h), do long 
>reads, and simply shift the register contents for the serial 
>ports that need it?

These registers are currently not defined anywhere and I did not feel
like wanting to put all the padconfig register definitions somewhere
(all 200+ of them).... I don't think it is currently very clear how we
want to handle these registers in general. Also, this fix is more or
less temporary anyway while we are waiting for a real driver that
handles UART clocks properly (the final solution will most likely use
some of the elements of this though.)

Also, the spec says that these registers can be accessed in either 8, 16
or 32 bit modes so why make it unnecessarily complicated and potentially
buggy with shifts (race conditions)?

-Tero
