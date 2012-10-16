From: Ricardo Neri <ricardo.neri@ti.com>
Subject: Re: [PATCH 6/6] OMAPDSS: HDMI: Create platform device to support
 audio
Date: Tue, 16 Oct 2012 06:11:57 -0500
Message-ID: <507D40FD.10003@ti.com>
References: <1350350839-30408-1-git-send-email-ricardo.neri@ti.com> <1350350839-30408-7-git-send-email-ricardo.neri@ti.com> <507D2953.8030801@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45208 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752693Ab2JPLOD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Oct 2012 07:14:03 -0400
Received: from dlelxv30.itg.ti.com ([172.17.2.17])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id q9GBE2Tq014004
	for <linux-omap@vger.kernel.org>; Tue, 16 Oct 2012 06:14:02 -0500
Received: from DFLE73.ent.ti.com (dfle73.ent.ti.com [128.247.5.110])
	by dlelxv30.itg.ti.com (8.13.8/8.13.8) with ESMTP id q9GBE1u4032719
	for <linux-omap@vger.kernel.org>; Tue, 16 Oct 2012 06:14:02 -0500
In-Reply-To: <507D2953.8030801@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?ISO-8859-1?Q?P=E9ter_Ujfalusi?= <peter.ujfalusi@ti.com>
Cc: tomi.valkeinen@ti.com, s-guiriec@ti.com, b-cousson@ti.com, linux-omap@vger.kernel.org

Hi Peter,

Thanks for reviewing!

On 10/16/2012 04:30 AM, P=E9ter Ujfalusi wrote:
> On 10/16/2012 03:27 AM, Ricardo Neri wrote:
>> Creating the accessory devices, such as audio, from the HDMI driver
>> allows to regard HDMI as a single entity with audio an display
>> functionality. This intends to follow the design of drivers such
>> as MFD, in which a single entity handles the creation of the accesor=
y
>> devices. Such devices are then used by domain-specific drivers; audi=
o in
>> this case.
>>
>> Also, this is in line with the DT implementation of HDMI, in which w=
e will
>> have a single node to describe this feature of the OMAP SoC.
>
> ...
>
>> +	hdmi_aud_res[HDMI_AUDIO_MEM_RESOURCE].start =3D res->start;
>> +	hdmi_aud_res[HDMI_AUDIO_MEM_RESOURCE].end =3D res->end;
>> +	hdmi_aud_res[HDMI_AUDIO_MEM_RESOURCE].flags =3D IORESOURCE_MEM;
>> +
>> +	res =3D platform_get_resource(hdmi.pdev, IORESOURCE_DMA, 0);
>> +	if (!res) {
>> +		DSSERR("can't get IORESOURCE_DMA HDMI\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* Pass this resource to audio_pdev */
>> +	hdmi_aud_res[HDMI_AUDIO_DMA_RESOURCE].start =3D res->start;
>> +	hdmi_aud_res[HDMI_AUDIO_DMA_RESOURCE].end =3D res->end;
>> +	hdmi_aud_res[HDMI_AUDIO_DMA_RESOURCE].flags =3D IORESOURCE_DMA;
>> +
>> +	/* create platform device for HDMI audio driver */
>> +	hdmi.audio_pdev =3D platform_device_register_simple(
>> +							  "omap_hdmi_audio",
>> +							  -1, hdmi_aud_res,
>> +							   ARRAY_SIZE(hdmi_aud_res));
>
> Should you also update arch/arm/mach-omap2/devices.c to not register =
the same
> device?
> When we do not boot with DT devices.c will create the same device ear=
lier
> (without pdata) which will prevent this device to be created and at t=
he end
> will prevent omap_hdmi_audio driver to probe due to missing pdata...

Yes, I have already a set of patches to remove the device creation from=
=20
devices.c. I decided to send this patch set first to see if Tomi and th=
e=20
reviewers are OK with it. After they are accepted I will send the=20
updates to devices.c and ASoC.

BR

Ricardo
>
>> +	if (IS_ERR(hdmi.audio_pdev)) {
>> +		DSSERR("Can't instantiate hdmi-audio\n");
>> +		return PTR_ERR(hdmi.audio_pdev);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
