From: Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>
Subject: RE: USB on omap2430
Date: Fri, 26 Mar 2010 12:44:16 -0500
Message-ID: <3821c76c47d164935b857a29de6bb797@secure211.sgcpanel.com>
References: <70376CA23424B34D86F1C7DE6B997343017F5D5BE1@VSHINMSMBX01.vshodc.lntinfotech.com>,<5A47E75E594F054BAF48C5E4FC4B92AB032221A9F3@dbde02.ent.ti.com>,<70376CA23424B34D86F1C7DE6B997343017F5D5BE3@VSHINMSMBX01.vshodc.lntinfotech.com> <70376CA23424B34D86F1C7DE6B997343017F5D5BE7@VSHINMSMBX01.vshodc.lntinfotech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <70376CA23424B34D86F1C7DE6B997343017F5D5BE7-fVvhrSDAkVjuuPCCJ6VnObSn4PsL5ZDKvpI+GvaZM4lBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viral Mehta <Viral.Mehta-oonXi/34qI7c+919tysfdA@public.gmane.org>
Cc: "Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Fri, 26 Mar 2010 16:38:11 +0530, Viral Mehta
<Viral.Mehta-oonXi/34qI7c+919tysfdA@public.gmane.org> wrote:
> Hi,
> 
> I enabled "earlyprintk" and I have copy+pasted crashdump at the end of
the
> email.
> 
> It is not able to get "otg_get_transceiver()" since transceiver was
never
> set.
> OMAP2430 uses ISP1301 (grepped from SDP manual).
> It is on I2C1 bus and address 0x2D if I read the manual correctly.
> 
> I think it was not initialised in platform_init.
> arch/arm/mach-omap2/board-3430sdp.c
> ========= Present Code=========
> static struct i2c_board_info __initdata sdp2430_i2c_boardinfo[] = {
>     {
>         I2C_BOARD_INFO("twl4030", 0x48),
>         .flags = I2C_CLIENT_WAKE,
>         .irq = INT_24XX_SYS_NIRQ,
>         .platform_data = &sdp2430_twldata,
>     },
> };
> ==========================
> I think it needs to be modified something like this
> =============
> static struct i2c_board_info __initdata sdp2430_i2c_boardinfo[] = {
>     {
>         I2C_BOARD_INFO("twl4030", 0x48),
>         .flags = I2C_CLIENT_WAKE,
>         .irq = INT_24XX_SYS_NIRQ,
>         .platform_data = &sdp2430_twldata,
>     },
> };
> 
> static struct i2c_board_info __initdata sdp2430_i2c_1_boardinfo[] = {
>     { /* for camera sensor */
>         I2C_BOARD_INFO("ex3691", 0x48),
> /*      .flags = I2C_CLIENT_WAKE,
>         .irq = INT_24XX_SYS_NIRQ,
>         .platform_data = &sdp2430_twldata,*/
>     },
>     {
>       /* for camera transceiver */
>         I2C_BOARD_INFO("isp1301_omap", 0x2D),
>     },
> 
> };
> ==========================
> 
> I think we also need to make one change in ./arch/arm/mach-omap2/Kconfig
> ======== Present Code ========
> config ARCH_OMAP2430
>     bool "OMAP2430 support"
>     depends on ARCH_OMAP24XX
> =====================
> This should be changed to
> ===============
> config ARCH_OMAP2430
>     bool "OMAP2430 support"
>     depends on ARCH_OMAP24XX
>     select ARCH_OMAP_OTG
> ====================
> 
> The changes are not in form of "git diff" since it had lots of my other
> debug prints.
> But, I hope this makes sense. Do let me know your comments.
> =========== Crash dump with earlyprintk=========
> "Switching to clocksource gp timer
> musb_hdrc: version 6.0, musb-dma, host, debug=0
> HS USB OTG: no transceiver configured
> musb_hdrc musb_hdrc: musb_init_controller failed with status -19
> Unhandled fault: imprecise external abort (0xc06) at 0x00000000
> Internal error: : c06 [#1] PREEMPT
> last sysfs file:
> Modules linked in:
> CPU: 0    Not tainted  (2.6.33 #56)
> PC is at musb_platform_suspend+0x20/0x88
> LR is at musb_platform_suspend+0x1c/0x88
> pc : [<c01e1d44>]    lr : [<c01e1d40>]    psr: a0000013
> sp : c1c19e28  ip : 22222222  fp : c03a4b9c
> r10: c03a4bc0  r9 : 00000000  r8 : c03bf7a8
> r7 : c03c0dd0  r6 : 00000000  r5 : c1c5e8f8  r4 : c1c5e8f8
> r3 : c03a4460  r2 : c1c59608  r1 : 480ac414  r0 : fa0ac414
> Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
> Control: 00c5387d  Table: 80004000  DAC: 00000017
> Process swapper (pid: 1, stack limit = 0xc1c18268)
> Stack: (0xc1c19e28 to 0xc1c1a000)
> 9e20:                   c1c5e8f8 c01e1db8 00000000 c01e0da0 ffffffed
> c1c5e8f8
> 9e40: 00000000 c001a9d0 00000005 c1c19e8c c03af81c ffffffff c03a4bb8
> 0000005c
> 9e60: fa0ac000 00000008 c1c5ba80 00000002 c1c18000 c03e34a4 00000000
> c01710d8
> 9e80: c1c19ed4 00000000 000080d0 c1c0e7a8 00000000 60000013 00000007
> 60000013
> 9ea0: c1c000c0 c03483b8 60000013 c1c2f158 c1c18000 00000008 c1c2f158
> c1c2ff98
> 9ec0: 00000000 c02a9208 00000000 c1c19ef8 00000000 c00ef1a8 c1c19ef8
> c00eed74
> 9ee0: c1c2f158 c1c2ff98 c1c19ef8 00000000 c1c2ff98 c00ef8d8 c1c59608
> c03a4bc0
> 9f00: c03a4bf4 c03c0dd0 c03c0dd0 c03bf7a8 00000000 00000000 00000000
> c01b5184
> 9f20: c03a4bc0 c01b4288 c03a4bc0 c03a4bf4 c03c0dd0 c03c0dd0 c03bf7a8
> c01b4394
> 9f40: 00000000 c1c19f50 c01b4334 c01b376c c1c034d8 c1c63e30 c03c0dd0
> 00000001
> 9f60: c03c0dd0 c1c5a8a0 c0019e90 c01b3cd8 c02c1d7c c02c1d7c c1c19f70
> 00000001
> 9f80: c03c0dd0 c03cd040 c0019e90 00000001 00000000 c01b4744 00000001
> c03c0dbc
> 9fa0: c03cd040 c0019e90 00000001 00000000 00000000 c01b5514 c0021528
> 00000000
> 9fc0: c03cd040 c002736c c0019e90 c0171c98 00000000 c002173c c0021528
> 00000000
> 9fe0: 00000000 00000000 00000000 c0008868 00000000 c0028ea8 000a050a
> 02050d09
> [<c01e1d44>] (musb_platform_suspend+0x20/0x88) from [<c01e1db8>]
> (musb_platform_exit+0xc/0x20)

to me it sounds like you don't have a transceiver. Can you do the
following:

1. arm-linux-gdb vmlinux (with the same kernel image you reproduce the
crash)
2. (gdb) l *(musb_platform_suspend + 0x20)

it should show you the source code and the line number from
where the NULL pointer comes

ps: please read http://elinux.org/Netiquette

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
