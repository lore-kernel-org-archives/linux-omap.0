From: Vimal Singh <vimal.newwork@gmail.com>
Subject: Re: [PATCH v2 2/3] OMAP: SDP: Introducing 'board-sdp-flash.c' for
	flash init
Date: Mon, 8 Feb 2010 18:27:19 +0530
Message-ID: <ce9ab5791002080457ye599b57t4c61fe273e82e072@mail.gmail.com>
References: <ce9ab5791002080347q3c8a73bvf80736b125cfac1@mail.gmail.com>
	<20100208135209.GA11847@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f223.google.com ([209.85.218.223]:61334 "EHLO
	mail-bw0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751341Ab0BHM5l convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Feb 2010 07:57:41 -0500
Received: by bwz23 with SMTP id 23so1062326bwz.1
        for <linux-omap@vger.kernel.org>; Mon, 08 Feb 2010 04:57:39 -0800 (PST)
In-Reply-To: <20100208135209.GA11847@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Mon, Feb 8, 2010 at 7:22 PM, Ladislav Michl <Ladislav.Michl@seznam.c=
z> wrote:
>> diff --git a/arch/arm/mach-omap2/board-sdp-flash.c
>> b/arch/arm/mach-omap2/board-sdp-flash.c
>> new file mode 100644
>> index 0000000..54ef19f
>> --- /dev/null
>> +++ b/arch/arm/mach-omap2/board-sdp-flash.c
> [snip]
>> +static void omap_set_vpp(struct map_info *map, int enable)
>> +{
>> + =A0 =A0 static int =A0 =A0 =A0count;
>> + =A0 =A0 u32 l;
>> +
>> + =A0 =A0 if (cpu_class_is_omap1()) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (enable) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (count++ =3D=3D 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 l =3D omap=
_readl(EMIFS_CONFIG);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 l |=3D OMA=
P_EMIFS_CONFIG_WP;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_write=
l(l, EMIFS_CONFIG);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (count && (--count =3D=3D=
 0)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 l =3D omap=
_readl(EMIFS_CONFIG);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 l &=3D ~OM=
AP_EMIFS_CONFIG_WP;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_write=
l(l, EMIFS_CONFIG);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>> +}
>
> Hmm, as you are adding files into arch/arm/mach-omap2 directory, is t=
here
> a chance cpu_class_is_omap1() ever returns non-zero?
>
>> +static struct physmap_flash_data sdp_nor_data =3D {
>> + =A0 =A0 .width =A0 =A0 =A0 =A0 =A0=3D 2,
>> + =A0 =A0 .set_vpp =A0 =A0 =A0 =A0=3D omap_set_vpp,
>> +};
>
> ... and in case there is not, just leave set_vpp set to NULL and dele=
te this
> incarnation of omap_set_vpp.
>

My bad. I just did not look into that.
I'll fix it as per your suggestion.

--=20
Regards,
Vimal Singh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
