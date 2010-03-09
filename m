From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: Re: Commit 0c8219f0... breaks omap7xx support
Date: Mon, 8 Mar 2010 17:51:53 -0800
Message-ID: <6cb013311003081751u2c7cd8c6v59472ee85ac90e77@mail.gmail.com>
References: <6cb013311003062056v3ed83a53u2636838348bf4845@mail.gmail.com>
	<20100309004832.GK2900@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f181.google.com ([209.85.216.181]:35302 "EHLO
	mail-px0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756496Ab0CIBwO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Mar 2010 20:52:14 -0500
Received: by pxi11 with SMTP id 11so1734927pxi.15
        for <linux-omap@vger.kernel.org>; Mon, 08 Mar 2010 17:52:14 -0800 (PST)
In-Reply-To: <20100309004832.GK2900@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, miknix@gmail.com, a.j.buxton@gmail.com, linwizard-devel@lists.sf.net

On Mon, Mar 8, 2010 at 4:48 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Cory Maccarrone <darkstar6262@gmail.com> [100306 20:53]:
>> All,
>>
>> I've finally gotten some time to test the latest linux-omap code, an=
d
>> found the following commit:
>>
>> =C2=A0 =C2=A0 4f2c49fedf... omap: Clean the serial port defines
>>
>> breaks current omap7xx support. =C2=A0To get linux-omap master to bo=
ot, I
>> had to revert that, and the three two that follow it:
>>
>> =C2=A0 =C2=A0 0c8219f03... omap: Make uncompress code and DEBUG_LL c=
ode generic
>> =C2=A0 =C2=A0 61b603b4e...omap: Remove old DEBUG_LL serial port opti=
ons
>>
>> in order to boot with DEBUG_LL enabled. =C2=A0Disabled, I only neede=
d to
>> revert the last two.
>
> Hmm OK thanks for bisecting this. The first patch seems to have
> a bug for uncompress.h on non omap3 platforms, see the attached
> patch.
>
> Are you sure you have CONFIG_EARLY_PRINTK and earlyprintk also
> in your cmdline?
>

I am now :)  It crashes equally with those enabled.

>> I don't know enough about that part of the kernel to debug it, so al=
l
>> I can offer is a test result. =C2=A0For reference, this was on
>> board-htcherald using the htcherald_defconfig settings.
>
> Can you try the following:
>
> - Use the current mainline kernel head
> - make sure you have DEBUG_LL and EARLY_PRINTK enabled in your .confi=
g
> - check that you have earlyprintk also in the kernel cmdline
> - no other serial patches applied
>

No output, kernel crashes, watchdog reboots the device with this setup.

> If no serial output, please temporarily hardcode the values
> for your 7xx board in mach-omap1/include/mach/debug-macro.S for
> omap_uart_phys and omap_uart_virt. Maybe that will give some
> more clues.
>

Same result as above with the hardcoding.

> If you don't have any serial output with that, then try this:
>
> - reset some branch to 4f2c49fedf
> - make sure you have DEBUG_LL and EARLY_PRINTK enabled in your .confi=
g
> - check that you have earlyprintk also in the kernel cmdline
> - apply the following patch for the uncompress code
>

This worked.  I was able to boot in with DEBUG_LL enabled and
everything appears to be working properly.

> That way you might be able to track down further where things
> break with the patches following 4f2c49fedf.
>
> Regards,
>
> Tony
>
> --- a/arch/arm/plat-omap/include/plat/uncompress.h
> +++ b/arch/arm/plat-omap/include/plat/uncompress.h
> @@ -42,11 +42,11 @@ static void putc(int c)
> =C2=A0#ifdef CONFIG_ARCH_OMAP
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Will get removed in the next patch, set=
 to OMAP3 to compile */
> =C2=A0#ifdef CONFIG_OMAP_LL_DEBUG_UART3
> - =C2=A0 =C2=A0 =C2=A0 uart =3D (volatile u8 *)(OMAP3_UART3_BASE);
> + =C2=A0 =C2=A0 =C2=A0 uart =3D (volatile u8 *)(OMAP1_UART3_BASE);
> =C2=A0#elif defined(CONFIG_OMAP_LL_DEBUG_UART2)
> - =C2=A0 =C2=A0 =C2=A0 uart =3D (volatile u8 *)(OMAP3_UART2_BASE);
> + =C2=A0 =C2=A0 =C2=A0 uart =3D (volatile u8 *)(OMAP1_UART2_BASE);
> =C2=A0#elif defined(CONFIG_OMAP_LL_DEBUG_UART1)
> - =C2=A0 =C2=A0 =C2=A0 uart =3D (volatile u8 *)(OMAP3_UART1_BASE);
> + =C2=A0 =C2=A0 =C2=A0 uart =3D (volatile u8 *)(OMAP1_UART1_BASE);
> =C2=A0#elif defined(CONFIG_OMAP_LL_DEBUG_NONE)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
> =C2=A0#else
>

Any other hints?  I'm going to start looking at the changes, I'm
beginning to understand them more.

Thanks
- Cory
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
