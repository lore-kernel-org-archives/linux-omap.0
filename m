From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCH v2 2/6] OMAP4: ID: add omap_has_feature for max freq supported
Date: Thu, 4 Aug 2011 18:33:51 -0500
Message-ID: <CAOMWX4eMPfDqNBWj=ROOw_5wF0cq-v8-ske5JeCkMAyzFQu4bw@mail.gmail.com>
References: <1309573826-10615-1-git-send-email-rnayak@ti.com>
 <1309573826-10615-2-git-send-email-rnayak@ti.com> <1309573826-10615-3-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:37334 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753089Ab1HDXeO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Aug 2011 19:34:14 -0400
Received: by mail-ew0-f54.google.com with SMTP id 1so1681175ewy.41
        for <linux-omap@vger.kernel.org>; Thu, 04 Aug 2011 16:34:13 -0700 (PDT)
In-Reply-To: <1309573826-10615-3-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, Aneesh V <aneesh@ti.com>

On Fri, Jul 1, 2011 at 21:30, Rajendra Nayak <rnayak@ti.com> wrote:

[...]

> +static void __init omap4_check_features(void)
> +{
> + =A0 =A0 =A0 u32 si_type;
> +
> + =A0 =A0 =A0 if (cpu_is_omap443x())
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_features |=3D OMAP4_HAS_MPU_1GHZ;
> +
> +
> + =A0 =A0 =A0 if (cpu_is_omap446x()) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 si_type =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 read_tap_reg(OMAP4_CTRL=
_MODULE_CORE_STD_FUSE_PROD_ID_1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 switch ((si_type & (3 << 16)) >> 16) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 2:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* High performance dev=
ice */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_features |=3D OMAP=
4_HAS_MPU_1_5GHZ;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
I have seen http://www.mail-archive.com/linux-omap@vger.kernel.org/msg5=
1988.html
and I disagree with this.

We are setting up a standard for all future silicon that omap_features
if it contains a higher frequency will always support all lower
frequencies in omap_feature. This may be convinent for the moment,
BUT, I disagree with the approach as we cannot guarantee that this
will be the approach for all silica in the future and approach taken
here could be considered short-sighted. if 1.2GHz will be supported
then a check for omap_has_1_2GHz should be true as well - which this
patch will fail to support. E.g. on 4460 has_1GHz should'nt return
true as it is 920MHz, but the check for 1_2GHz should be true - which
it wont as return omap_features & OMAP3_HAS_ ##flag;     will not have
BIT(9) set.


Regards,
Nishanth Menon
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 1:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Standard device */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_features |=3D OMAP=
4_HAS_MPU_1_2GHZ;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +}
[...]
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
