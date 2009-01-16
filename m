From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 0/1] ASoC patch on top of linux-omap 2.6.29-rc1 (TWL4030 related)
Date: Fri, 16 Jan 2009 08:21:07 +0200
Message-ID: <200901160821.07772.peter.ujfalusi@nokia.com>
References: <1232086493-2811-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:65466 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751599AbZAPGVS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Jan 2009 01:21:18 -0500
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n0G6KuN6018415
	for <linux-omap@vger.kernel.org>; Fri, 16 Jan 2009 00:21:15 -0600
In-Reply-To: <1232086493-2811-1-git-send-email-peter.ujfalusi@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hmm, should I take the patch from Takashi's tree (with his sign-off) an=
d
resend it?
This patch is the one that I have sent to alsa-devel...

--=20
P=E9ter

On Friday 16 January 2009 08:14:52 Peter Ujfalusi wrote:
> Hello,
>
> This patch has been sent after 29-rc1 to ALSA devel, it is already in
> Takashi's tree and will go upstream as soon as possible.
>
> Somehow I have left out this from the soc_value_enum type merge to th=
e
> soc_enum series, which kind of renders the twl4030 codec driver to no=
t to
> update the value_enum types. In other words: without this patch the t=
wl4030
> codec is not working.
>
> The patch applies cleanly to the head of linux-omap tree.
>
> ---
> Peter Ujfalusi (1):
>   ASoC: Fix the power update function for snd_soc_dapm_value_mux
>
>  sound/soc/soc-dapm.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
