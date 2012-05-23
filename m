From: Omar Ramirez Luna <omar.luna@linaro.org>
Subject: Re: [PATCH 0/2] OMAP: mailbox initial device tree support
Date: Wed, 23 May 2012 17:03:51 -0500
Message-ID: <CALLhW=7ENCpodLxf-vaY6EzYRv9uKz_52FDsUbMAaSGNFy4LiQ@mail.gmail.com>
References: <1335894460-19941-1-git-send-email-omar.luna@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:40117 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751026Ab2EWWDw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 May 2012 18:03:52 -0400
Received: by mail-gg0-f174.google.com with SMTP id u4so7079777ggl.19
        for <linux-omap@vger.kernel.org>; Wed, 23 May 2012 15:03:51 -0700 (PDT)
In-Reply-To: <1335894460-19941-1-git-send-email-omar.luna@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, Russell King <linux@arm.linux.org.uk>, Vaibhav Bedia <vaibhav.bedia@ti.com>, Omar Ramirez Luna <omar.luna@linaro.org>, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, patches@linaro.org, linaro-dev@lists.linaro.org, devicetree-discuss@lists.ozlabs.org

Hi Tony, Benoit,

On 1 May 2012 12:47, Omar Ramirez Luna <omar.luna@linaro.org> wrote:
> To allow mailbox driver to function with device tree.
>
> Tested in OMAP4 and OMAP3. OMAP2 untested.
>
> Omar Ramirez Luna (2):
> =A0OMAP: mailbox: add device tree support
> =A0arm/dts: OMAP2+: Add mailbox nodes
>
> =A0.../devicetree/bindings/arm/omap/mailbox.txt =A0 =A0 =A0 | =A0 =A0=
9 +++++++++
> =A0arch/arm/boot/dts/omap2.dtsi =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0 =A05 +++++
> =A0arch/arm/boot/dts/omap3.dtsi =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0 =A05 +++++
> =A0arch/arm/boot/dts/omap4.dtsi =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0 =A05 +++++
> =A0arch/arm/mach-omap2/devices.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| =A0 =A03 +++
> =A0arch/arm/mach-omap2/mailbox.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| =A0 12 ++++++++++++
> =A06 files changed, 39 insertions(+), 0 deletions(-)
> =A0create mode 100644 Documentation/devicetree/bindings/arm/omap/mail=
box.txt

Can you share your thoughts for these patches?

Regards,

Omar
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
