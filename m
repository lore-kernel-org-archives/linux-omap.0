From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH] OMAPDSS: Check if RPM enabled before trying to change state
Date: Tue, 26 Jun 2012 16:02:46 +0300
Message-ID: <CANOLnOP_z47QCB234y-BOWyRGHeO8u-pJct=Kq6+2XCig-tX=w@mail.gmail.com>
References: <1340438771-25587-1-git-send-email-jaswinder.singh@linaro.org>
	<1340605221.12683.30.camel@lappyti>
	<CANOLnOOodXtqV7Hs-SsEUfB3Uo1PSGb8bkaeN7M48jVpQrb-cA@mail.gmail.com>
	<1340627459.3395.54.camel@deskari>
	<4FE85CCA.80903@ti.com>
	<1340628648.3395.69.camel@deskari>
	<4FE93FB9.3080705@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:61203 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756430Ab2FZNCw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Jun 2012 09:02:52 -0400
In-Reply-To: <4FE93FB9.3080705@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, jaswinder.singh@linaro.org, mythripk@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, andy.green@linaro.org, n-dechesne@ti.com, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org

CCing some PM people, maybe they can comment?

On Tue, Jun 26, 2012 at 7:51 AM, Rajendra Nayak <rnayak@ti.com> wrote:
> On Monday 25 June 2012 06:20 PM, Tomi Valkeinen wrote:
>>
>> Do you know how the drivers should handle CONFIG_PM_RUNTIME=3Dn?
>> Are they supposed to handle the error values returned by runtime PM
>> functions somehow, or should they use #ifdef CONFIG_PM_RUNTIME?
>
> hmm, I always though with CONFIG_RUNTIME_PM=3Dn, the functions would
> be stubbed to return success and not failure. And the _pm_runtime_res=
ume
> function indeed seems to return 1, which is not failure but just sayi=
ng
> that your device is already active/enabled.
> The _pm_runtime_suspend and _pm_runtime_idle do return a -ENOSYS, whi=
ch
> is something only returned when CONFIG_RUNTIME_PM=3Dn, so if you real=
ly
> want to handle failing pm_runtime_put_sync cases, maybe you still can=
=2E
> But then, I don't know if there is anything you can do to recover fro=
m
> a failing pm_runtime_put_sync, except for warning the user maybe.
>
>> Both options sound a bit difficult to me... With the first one it's
>> difficult to see if there was an actual error and we should somehow
>> react to it, or is everything fine and we just shouldn't care about
>> runtime PM. The second one requires ifdefs in many places.

--=20
Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
