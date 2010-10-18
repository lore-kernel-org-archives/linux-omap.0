From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH v2] OMAP3: DSS: Kconfig changes to enable display options
 on OMAP3
Date: Mon, 18 Oct 2010 14:19:22 +0300
Message-ID: <AANLkTi=g3iXKcFRLz1Spyke1xJ0cgsS5LDWRvEnY0Ukh@mail.gmail.com>
References: <1287381341-4450-1-git-send-email-samreen@ti.com>
	<AANLkTimrSj0_ussokxOnwqF=kWQoRt=cefyxDbBYXs0E@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:59225 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754636Ab0JRLTX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Oct 2010 07:19:23 -0400
Received: by qwa26 with SMTP id 26so447020qwa.19
        for <linux-omap@vger.kernel.org>; Mon, 18 Oct 2010 04:19:22 -0700 (PDT)
In-Reply-To: <AANLkTimrSj0_ussokxOnwqF=kWQoRt=cefyxDbBYXs0E@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Samreen <samreen@ti.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>, linux-omap@vger.kernel.org

On Mon, Oct 18, 2010 at 12:37 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Mon, Oct 18, 2010 at 8:55 AM, Samreen <samreen@ti.com> wrote:
>> The defconfig options for display are taken in the respective Kconfi=
g
>> to enable display by default on OMAP3 platforms
>
>
>> =A0config FB_OMAP2_NUM_FBS
>> =A0 =A0 =A0 =A0int "Number of framebuffers"
>> =A0 =A0 =A0 =A0range 1 10
>> - =A0 =A0 =A0 default 3
>> + =A0 =A0 =A0 default 1 =A0if ARCH_OMAP2 || ARCH_OMAP3
>> + =A0 =A0 =A0 default 3 =A0if ARCH_OMAP4
>> =A0 =A0 =A0 =A0depends on FB_OMAP2
>> =A0 =A0 =A0 =A0help
>> =A0 =A0 =A0 =A0 =A0Select the number of framebuffers created. OMAP2/=
3 has 3 overlays
>
> I think this should be 3 also for OMAP3.

Right, please don't change defaults out of the blue like this.

Also when sending DSS patches, please CC linux-fbdev and DSS
maintainer (Tomi), run ./scripts/get_maintainer.pl <your patch> for
maintainers.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
