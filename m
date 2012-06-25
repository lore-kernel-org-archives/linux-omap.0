From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH] OMAPDSS: Check if RPM enabled before trying to change state
Date: Mon, 25 Jun 2012 18:03:35 +0530
Message-ID: <CAJe_ZhecBjXi99NjOrMo5oCYtRBso6mGmWZcZVbbXxxc=pHrUw@mail.gmail.com>
References: <1340438771-25587-1-git-send-email-jaswinder.singh@linaro.org>
	<1340605221.12683.30.camel@lappyti>
	<CANOLnOOodXtqV7Hs-SsEUfB3Uo1PSGb8bkaeN7M48jVpQrb-cA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:52537 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751088Ab2FYMdg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Jun 2012 08:33:36 -0400
Received: by bkcji2 with SMTP id ji2so3059662bkc.19
        for <linux-omap@vger.kernel.org>; Mon, 25 Jun 2012 05:33:35 -0700 (PDT)
In-Reply-To: <CANOLnOOodXtqV7Hs-SsEUfB3Uo1PSGb8bkaeN7M48jVpQrb-cA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, mythripk@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, andy.green@linaro.org, n-dechesne@ti.com

On 25 June 2012 17:35, Grazvydas Ignotas <notasas@gmail.com> wrote:
> On Mon, Jun 25, 2012 at 9:20 AM, Tomi Valkeinen <tomi.valkeinen@ti.co=
m> wrote:
>> On Sat, 2012-06-23 at 13:36 +0530, jaswinder.singh@linaro.org wrote:
>>>
>>> =A0Currenlty HDMI fails to come up in the suspend-resume path.
>>> This patch helps that real-world scenario.
>>
>> What is the problem there? It'd be good to explain the problem in th=
e
>> patch description. Does the pm_runtime_get return -EACCES?
>
> On slightly different but related issue, currently OMAPDSS always
> spits lots of backtraces when it's compiled without CONFIG_PM_RUNTIME=
,
> because pm_runtime_put* always return -ENOSYS without
> CONFIG_PM_RUNTIME. So something like this patch proposes is needed, o=
r
> maybe WARN_ON should check for -ENOSYS, I don't know..
>
I didn't check, but this patch should already fix that I think ?

IMHO, for omapdss, we need not differentiate between -ENOSYS and
-EACCESS because anyway the ultimate functions dispc_runtime_resume()
and dispc_runtime_suspend()  can't report failure (they always return
0).

-j
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
