From: Omar Ramirez Luna <omar.luna@linaro.org>
Subject: Re: [PATCH 0/3] OMAP: control: bootaddr and bootmod APIs
Date: Tue, 15 May 2012 21:20:19 -0500
Message-ID: <CALLhW=6g59V7UMWMsaiCnr=UYuXo4CRZfpELosfk7xs5XevJTg@mail.gmail.com>
References: <1336011113-31502-1-git-send-email-omar.luna@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:51540 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932561Ab2EPCUU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 May 2012 22:20:20 -0400
Received: by yenm10 with SMTP id m10so249670yen.19
        for <linux-omap@vger.kernel.org>; Tue, 15 May 2012 19:20:19 -0700 (PDT)
In-Reply-To: <1336011113-31502-1-git-send-email-omar.luna@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: Russell King <linux@arm.linux.org.uk>, Omar Ramirez Luna <omar.ramirez@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org, linaro-dev@lists.linaro.org, Omar Ramirez Luna <omar.luna@linaro.org>

On 2 May 2012 21:11, Omar Ramirez Luna <omar.luna@linaro.org> wrote:
> Recently a patch went in for tidspbridge code, to ioremap
> SCM registers and solve a build break[1]. However it has
> been pointed out before that this is a layer violation
> given that control module should handle its own registers, this
> series is an attempt to create APIs for the users of these
> registers.
>
> With some adaptations this patch might also make use of it:
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg66491.html
>
> Patch: staging: tidspbridge: use scm functions to set boot address an=
d mode,
> will be sent separately to staging tree.
>
> Tested on OMAP3 Beagleboard.
>
> [1] http://www.mail-archive.com/devel@linuxdriverproject.org/msg18762=
=2Ehtml
>
> Omar Ramirez Luna (3):
> =A0OMAP2+: control: new APIs to configure boot address and mode
> =A0OMAP: dsp: interface to control module functions
> =A0staging: tidspbridge: use scm functions to set boot address and mo=
de

Ping.

It seems that I unconsciously copied the previous concept, recently I
dug this thread to explain the reasoning of these patches:

http://www.mail-archive.com/linux-omap@vger.kernel.org/msg38015.html

These were provided by Paul, one of them acked by Kevin, somehow they
were not included and I forgot about them.

My set also includes OMAP4 check, which I heard recently was tested
with the dsp on pandaboard. If needed I can go back to Paul's version
and re-spin them, with minor changes. Please let me know.

Regards,

Omar
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
