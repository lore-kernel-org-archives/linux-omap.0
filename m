From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH] OMAPDSS: Check if RPM enabled before trying to change state
Date: Mon, 25 Jun 2012 14:19:38 +0530
Message-ID: <CAJe_Zhf-H0dLtFsFAcryDy3av60RjmWmP+d3GSaxq8dNZKiXWw@mail.gmail.com>
References: <1340438771-25587-1-git-send-email-jaswinder.singh@linaro.org>
	<1340605221.12683.30.camel@lappyti>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:36601 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752356Ab2FYItk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Jun 2012 04:49:40 -0400
Received: by lbbgm6 with SMTP id gm6so6206517lbb.19
        for <linux-omap@vger.kernel.org>; Mon, 25 Jun 2012 01:49:38 -0700 (PDT)
In-Reply-To: <1340605221.12683.30.camel@lappyti>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: mythripk@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, andy.green@linaro.org, n-dechesne@ti.com

On 25 June 2012 11:50, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On Sat, 2012-06-23 at 13:36 +0530, jaswinder.singh@linaro.org wrote:
=2E...
>> =A0Currenlty HDMI fails to come up in the suspend-resume path.
>> This patch helps that real-world scenario.
>
> What is the problem there? It'd be good to explain the problem in the
> patch description. Does the pm_runtime_get return -EACCES?
>
Yes, it returns -EACCESS because RPM on devices is disabled during the
period from suspend-start to resume-finished.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
