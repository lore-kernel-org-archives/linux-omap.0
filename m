From: "Semwal, Sumit" <sumit.semwal@ti.com>
Subject: Re: [PATCH v3 07/17] OMAP2,3: DSS2: Build omap_device for each DSS HWIP
Date: Tue, 4 Jan 2011 17:57:48 +0530
Message-ID: <AANLkTin=XMafCFVKQwYqRzbv-rvjeDAMon2TBdmE20ww@mail.gmail.com>
References: <1294059069-26737-1-git-send-email-svadivu@ti.com>
 <1294059069-26737-8-git-send-email-svadivu@ti.com> <20110104015652.GY7771@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:58410 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751353Ab1ADM2K convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 4 Jan 2011 07:28:10 -0500
Received: by mail-qy0-f182.google.com with SMTP id 36so14117104qyk.6
        for <linux-omap@vger.kernel.org>; Tue, 04 Jan 2011 04:28:09 -0800 (PST)
In-Reply-To: <20110104015652.GY7771@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Guruswamy Senthilvadivu <svadivu@ti.com>, tomi.valkeinen@nokia.com, paul@pwsan.com, khilman@deeprootsystems.com, v-hiremath@ti.com, a0919096@ti.com, linux-omap@vger.kernel.org

Hi Tony,

On Tue, Jan 4, 2011 at 7:26 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Guruswamy Senthilvadivu <svadivu@ti.com> [110103 04:51]:
>> + =A0 =A0 char *omap2_oh_name[] =3D { "dss_dss", "dss_dispc", "dss_r=
fbi",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "dss_venc"=
 };
>> + =A0 =A0 char *omap3_oh_name[] =3D { "dss_dss", "dss_dispc", "dss_r=
fbi",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "dss_venc"=
, "dss_dsi1" };
>> + =A0 =A0 char *omap2_dev_name[] =3D { "omap_dss", "omap_dispc", "om=
ap_rfbi",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "omap_venc=
" };
>> + =A0 =A0 char *omap3_dev_name[] =3D { "omap_dss", "omap_dispc", "om=
ap_rfbi",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "omap_venc=
", "omap_dsi1" };
>> + =A0 =A0 char *(*oh_name)[];
>> + =A0 =A0 char *(*dev_name)[];
>> + =A0 =A0 int oh_count;
>> +
>> + =A0 =A0 if (cpu_is_omap24xx()) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 oh_name =3D &omap2_oh_name;
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_name =3D &omap2_dev_name;
>> + =A0 =A0 =A0 =A0 =A0 =A0 oh_count =3D ARRAY_SIZE(omap2_oh_name);
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 oh_name =3D &omap3_oh_name;
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_name =3D &omap3_dev_name;
>> + =A0 =A0 =A0 =A0 =A0 =A0 oh_count =3D ARRAY_SIZE(omap3_oh_name);
>> + =A0 =A0 }
>
> Here it looks like you don't need to repeat the common names
> "dss_dss", "dss_dispc", "dss_rfbi". Instead you can have a
> common char *omap_oh_name[5] then set oh_count smaller based
> on the omap type.
Thanks, yes, that's a good suggestion. Senthil is going to be out for
sometime, so I will update this and send an updated patch series by
tomorrow, after waiting for any more comments.

Best regards,
~Sumit.
>
> Regards,
>
> Tony
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
