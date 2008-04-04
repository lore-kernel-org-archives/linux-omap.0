From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH 1/1] Fix function declaration.
Date: Fri, 4 Apr 2008 14:33:15 +0300
Message-ID: <20080404143315.2ed2e601.jarkko.nikula@nokia.com>
References: <1207306776-19509-1-git-send-email-ext-tapio.laxstroem@nokia.com>
	<1207306776-19509-2-git-send-email-ext-tapio.laxstroem@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:26667 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751499AbYDDLdZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Apr 2008 07:33:25 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m34BYXso029098
	for <linux-omap@vger.kernel.org>; Fri, 4 Apr 2008 06:35:36 -0500
In-Reply-To: <1207306776-19509-2-git-send-email-ext-tapio.laxstroem@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext tapio =?ISO-8859-1?Q?laxstr=F6m?= <ext-tapio.laxstroem@nokia.com>
Cc: linux-omap@vger.kernel.org

On Fri,  4 Apr 2008 13:59:36 +0300
ext tapio laxstr=F6m <ext-tapio.laxstroem@nokia.com> wrote:

> Signed-off-by: tapio laxstr=F6m <ext-tapio.laxstroem@nokia.com>
> ---
>  arch/arm/mach-omap2/board-n800-audio.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> -void __init n800_audio_init(void)
> +void __init n800_audio_init(struct tsc2301_platform_data *tc)
>  {
>  }
Acked. Had exactly same fix in my own tree but forgot to send it :-)


Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
