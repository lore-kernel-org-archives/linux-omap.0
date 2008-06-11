From: "Rodrigo Vivi" <rodrigo.vivi@gmail.com>
Subject: Re: FW: driver DVI output OMAP3 EVM
Date: Wed, 11 Jun 2008 01:46:32 -0300
Message-ID: <bdb0025f0806102146v49203fd7s5b0692dfe3d22d38@mail.gmail.com>
References: <0680EC522D0CC943BC586913CF3768C001DE4464FE@dbde02.ent.ti.com>
	 <bdb0025f0806102142j1c5d020bnfd7074b892c3c7e8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.175]:33726 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221AbYFKEqc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Jun 2008 00:46:32 -0400
Received: by wf-out-1314.google.com with SMTP id 27so2920328wfd.4
        for <linux-omap@vger.kernel.org>; Tue, 10 Jun 2008 21:46:32 -0700 (PDT)
In-Reply-To: <bdb0025f0806102142j1c5d020bnfd7074b892c3c7e8@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Syed Mohammed, Khasim" <khasim@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Royer, Fabien" <f-royer@ti.com>

ops, I'm sorry,
The end of that email:

I'm trying to do it on a omap3430sdp.

Thanks in advance

Best Regards,
vivijim


On Wed, Jun 11, 2008 at 1:42 AM, Rodrigo Vivi <rodrigo.vivi@gmail.com> wrote:
> Hi there,
>
> I'd like to use the vga output trough s-video conector. I already have
> this 3 files and they seems ok to me. Apparently they are setting
> correctly all bits.
> But when echoing "tv" to /sys/.../graphics the lcd is turned off but
> nothing appears on the tv...
>
> am I missing something?
>
> has anyone already tried to do it? is it working?
>
> On Mon, Jun 2, 2008 at 9:08 AM, Syed Mohammed, Khasim <khasim@ti.com> wrote:
>> Resending: I think you have received the attachments if not do let me know.
>>
>>> -----Original Message-----
>>> From: linux-omap-open-source-bounces@linux.omap.com [mailto:linux-omap-open-source-
>>> bounces@linux.omap.com] On Behalf Of Royer, Fabien
>>> Sent: Monday, June 02, 2008 4:55 PM
>>> To: linux-omap-open-source@linux.omap.com
>>> Subject: driver DVI output OMAP3 EVM
>>>
>>> Hello,
>>>
>>> I would like to know how to drive the DVI output on the OMAP3 EVM.
>>>
>>
>> Hi Fabien,
>>
>> If you use TI's release for OMAP3 EVM then the mods required to get DVI working is as given below, basically it is hardcoded version, LCD will not work from there on. At present we don't have a  version that allows you to dynamically switch between DVI and LCD. The files attached are bit old, may be you have to twik in a bit to get it compiled.
>>
>> Hardware:
>>
>> On EVM 3530 Base board, replace the Resistor R18 (It's near to DVI connector [TOP SIDE] of the board) with a 510 ohm (its 10K now).
>>
>> Software:
>>
>> The attached files have to be copied to respective directories.
>>
>> - arch/arm/plat-omap/display.c
>> - drivers/video/omap/omap_disp_out.c
>> - drivers/video/omap/omap_fb.c
>>
>> Changes for different resolution:
>>
>> It is now configured for 1280x720. If you want to modify it to your monitor resolution then do the following.
>>
>> 1) In arch/arm/plat-omap/display.c function omap2_disp_set_panel_size()
>>
>> dispc_reg_out(DISPC_SIZE_LCD,0x2CF04FF); /* it is 720 = 2cf , 1280 = 0x4ff */
>>
>> 2) In drivers/video/omap/omap_disp_out.c
>> #define H4_LCD_XRES             1280   /* Change these */
>> #define H4_LCD_YRES             720
>>
>> Regards,
>> Khasim
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
>
>
> --
> Rodrigo Vivi
> INdT - Instituto Nokia de Tecnologia
> Blog: http://blog.vivi.eng.br
> GPG: 0x905BE242 @ wwwkeys.pgp.net
>



-- 
Rodrigo Vivi
INdT - Instituto Nokia de Tecnologia
Blog: http://blog.vivi.eng.br
GPG: 0x905BE242 @ wwwkeys.pgp.net
