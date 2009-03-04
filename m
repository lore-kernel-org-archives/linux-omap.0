From: Ameya Palande <2ameya@gmail.com>
Subject: Re: [PATCH 2/5] DSPBRIDGE: Removes wrappers funtions of readl and
	writel
Date: Wed, 4 Mar 2009 16:56:40 +0200
Message-ID: <269694c00903040656h2937ff4fs486a5315e88e12b9@mail.gmail.com>
References: <496565EC904933469F292DDA3F1663E60287B84DB6@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f177.google.com ([209.85.219.177]:49852 "EHLO
	mail-ew0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752420AbZCDO4o convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Mar 2009 09:56:44 -0500
Received: by ewy25 with SMTP id 25so2711832ewy.37
        for <linux-omap@vger.kernel.org>; Wed, 04 Mar 2009 06:56:41 -0800 (PST)
In-Reply-To: <496565EC904933469F292DDA3F1663E60287B84DB6@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Guzman Lugo, Fernando" <x0095840@ti.com>
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Fernando,

On Tue, Mar 3, 2009 at 2:01 AM, Guzman Lugo, Fernando <x0095840@ti.com>=
 wrote:
> @@ -34,13 +35,13 @@
> =C2=A0 =C2=A0 const u32 offset =3D MLB_MAILBOX_SYSCONFIG_OFFSET;\
> =C2=A0 =C2=A0 register u32 newValue =3D ((u32)(value));\

This and all the remaining patches contain extra characters "=3D3D"
Here is one example:

@@ -34,13 +35,13 @@
     const u32 offset =3D3D MLB_MAILBOX_SYSCONFIG_OFFSET;\

Cheers,
Ameya.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
