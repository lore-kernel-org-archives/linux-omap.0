From: Olof Johansson <olof@lixom.net>
Subject: Re: [RFC v2 PATCH 2/3] dt: device tree bindings for TI's EMIF sdram controller
Date: Mon, 19 Dec 2011 08:59:18 -0800
Message-ID: <CAOesGMidr_orQ60wWrDkSPXZziZ6wuThTixmQj-idkkDjrMG0A@mail.gmail.com>
References: <1324303533-17458-1-git-send-email-aneesh@ti.com>
	<1324303533-17458-3-git-send-email-aneesh@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:39516 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751556Ab1LSQ7U convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Dec 2011 11:59:20 -0500
Received: by wgbdr13 with SMTP id dr13so11038261wgb.1
        for <linux-omap@vger.kernel.org>; Mon, 19 Dec 2011 08:59:19 -0800 (PST)
In-Reply-To: <1324303533-17458-3-git-send-email-aneesh@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aneesh V <aneesh@ti.com>
Cc: devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, Benoit Cousson <b-cousson@ti.com>

Oh wait, when I saw 3/3 I realized the following too:

On Mon, Dec 19, 2011 at 6:05 AM, Aneesh V <aneesh@ti.com> wrote:

> +- phy-type =A0 =A0 : string indicating the phy type. Should be one o=
f the
> + =A0following:
> +
> + =A0"phy-type-omap4" =A0: PHY used in OMAP4 family of SoCs
> +
> + =A0"phy-type-dm81xx" : PHY used in DM81XX family of SoCs

No, again please don't define new string properties when a simple
binary property will do just fine. Just use "phy-type-omap4" or
"phy-type-dm81xx" as an empty property to indicate what phy is used.
Or encode as an integer and list the valid values here.

Every time you add a string to the device tree, the data structure
grows, not to mention the fact that it adds a lot of string
comparisons during setup. Please keep that in mind when defining
bindings.



-Olof
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
