From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2] OMAP3: DSS: Kconfig changes to enable display options
 on OMAP3
Date: Mon, 18 Oct 2010 12:37:39 +0300
Message-ID: <AANLkTimrSj0_ussokxOnwqF=kWQoRt=cefyxDbBYXs0E@mail.gmail.com>
References: <1287381341-4450-1-git-send-email-samreen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:62382 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752293Ab0JRJhm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Oct 2010 05:37:42 -0400
Received: by bwz15 with SMTP id 15so469344bwz.19
        for <linux-omap@vger.kernel.org>; Mon, 18 Oct 2010 02:37:40 -0700 (PDT)
In-Reply-To: <1287381341-4450-1-git-send-email-samreen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Samreen <samreen@ti.com>
Cc: linux-omap@vger.kernel.org

On Mon, Oct 18, 2010 at 8:55 AM, Samreen <samreen@ti.com> wrote:
> The defconfig options for display are taken in the respective Kconfig
> to enable display by default on OMAP3 platforms


> =C2=A0config FB_OMAP2_NUM_FBS
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int "Number of framebuffers"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0range 1 10
> - =C2=A0 =C2=A0 =C2=A0 default 3
> + =C2=A0 =C2=A0 =C2=A0 default 1 =C2=A0if ARCH_OMAP2 || ARCH_OMAP3
> + =C2=A0 =C2=A0 =C2=A0 default 3 =C2=A0if ARCH_OMAP4
> =C2=A0 =C2=A0 =C2=A0 =C2=A0depends on FB_OMAP2
> =C2=A0 =C2=A0 =C2=A0 =C2=A0help
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Select the number of framebuffers c=
reated. OMAP2/3 has 3 overlays

I think this should be 3 also for OMAP3.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
