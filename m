From: Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCHv2 09/15] OMAP: DSS2: HDMI: implement detect()
Date: Mon, 12 Sep 2011 11:46:50 -0500
Message-ID: <CAF6AEGuhjZgH9zFuigjfvHGM9r7jSLY2TTCD0LjZbT+Ubrb12A@mail.gmail.com>
References: <1315818818-18733-1-git-send-email-tomi.valkeinen@ti.com>
	<1315818818-18733-10-git-send-email-tomi.valkeinen@ti.com>
	<CAP5A+B9_Jsg23oR49q2bkBGVLDWHBiBZj_=_G1SRf7ftrMt_iw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:44125 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751333Ab1ILQqw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Sep 2011 12:46:52 -0400
In-Reply-To: <CAP5A+B9_Jsg23oR49q2bkBGVLDWHBiBZj_=_G1SRf7ftrMt_iw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "K, Mythri P" <mythripk@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, archit@ti.com

On Mon, Sep 12, 2011 at 8:24 AM, K, Mythri P <mythripk@ti.com> wrote:
>> +bool ti_hdmi_4xxx_detect(struct hdmi_ip_data *ip_data)
>> +{
>> + =A0 =A0 =A0 int r;
>> +
>> + =A0 =A0 =A0 void __iomem *base =3D hdmi_core_sys_base(ip_data);
>> +
>> + =A0 =A0 =A0 /* HPD */
>> + =A0 =A0 =A0 r =3D REG_GET(base, HDMI_CORE_SYS_SYS_STAT, 1, 1);
>> +
>> + =A0 =A0 =A0 return r =3D=3D 1;
>> +}
>> +
> For HPD the probe should also be on the core interrupt first , and th=
e
> detect should be dynamic, ie based on the cable connect and disconnec=
t
> event.So this approach for HPD is not really the way.
> Also that should be based on the GPIO(63) , I am planning to push a
> patch on that shortly.


=46wiw, we do still need a dssdrv->detect() function from omapdrm
driver..  if there is another way to implement that function, such as
with a GPIO, that is great.  But somehow or another we need the detect
function.  The implementation can always change later.

BR,
-R
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
