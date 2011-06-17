From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [pm-wip/voltdm_nm][PATCH 07/10] OMAP3+: PM: VP: use uV for max
 and min voltage limits
Date: Thu, 16 Jun 2011 19:28:34 -0500
Message-ID: <BANLkTi=A75NHVeqz6dnKFZB-EcmJEH0XhA@mail.gmail.com>
References: <1307412972-25854-1-git-send-email-nm@ti.com> <1307412972-25854-8-git-send-email-nm@ti.com>
 <87hb7ph5er.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:33171 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752416Ab1FQA2z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Jun 2011 20:28:55 -0400
Received: by mail-ww0-f44.google.com with SMTP id 36so1416516wwa.13
        for <linux-omap@vger.kernel.org>; Thu, 16 Jun 2011 17:28:54 -0700 (PDT)
In-Reply-To: <87hb7ph5er.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

On Thu, Jun 16, 2011 at 15:45, Kevin Hilman <khilman@ti.com> wrote:
> Nice!
>
> A reference to where these voltages values came from would be good to
> have in the code as well.
these are just conversions of the existing values - :( I think we need
a seperate patch updating from each of OMAP DMs..

Regards,
Nishanth Menon
