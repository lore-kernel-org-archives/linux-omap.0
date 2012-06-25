From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH] OMAPDSS: Check if RPM enabled before trying to change state
Date: Mon, 25 Jun 2012 15:05:18 +0300
Message-ID: <CANOLnOOodXtqV7Hs-SsEUfB3Uo1PSGb8bkaeN7M48jVpQrb-cA@mail.gmail.com>
References: <1340438771-25587-1-git-send-email-jaswinder.singh@linaro.org>
	<1340605221.12683.30.camel@lappyti>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:54545 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756228Ab2FYMFT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Jun 2012 08:05:19 -0400
In-Reply-To: <1340605221.12683.30.camel@lappyti>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: jaswinder.singh@linaro.org, mythripk@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, andy.green@linaro.org, n-dechesne@ti.com

On Mon, Jun 25, 2012 at 9:20 AM, Tomi Valkeinen <tomi.valkeinen@ti.com>=
 wrote:
> On Sat, 2012-06-23 at 13:36 +0530, jaswinder.singh@linaro.org wrote:
>>
>>  Currenlty HDMI fails to come up in the suspend-resume path.
>> This patch helps that real-world scenario.
>
> What is the problem there? It'd be good to explain the problem in the
> patch description. Does the pm_runtime_get return -EACCES?

On slightly different but related issue, currently OMAPDSS always
spits lots of backtraces when it's compiled without CONFIG_PM_RUNTIME,
because pm_runtime_put* always return -ENOSYS without
CONFIG_PM_RUNTIME. So something like this patch proposes is needed, or
maybe WARN_ON should check for -ENOSYS, I don't know..


--=20
Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
