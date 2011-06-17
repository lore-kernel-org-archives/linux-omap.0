From: Kevin Hilman <khilman@ti.com>
Subject: Re: [pm-wip/voltdm_nm][PATCH 07/10] OMAP3+: PM: VP: use uV for max and min voltage limits
Date: Fri, 17 Jun 2011 08:48:52 -0700
Message-ID: <87sjr8cvbv.fsf@ti.com>
References: <1307412972-25854-1-git-send-email-nm@ti.com>
	<1307412972-25854-8-git-send-email-nm@ti.com> <87hb7ph5er.fsf@ti.com>
	<BANLkTi=A75NHVeqz6dnKFZB-EcmJEH0XhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:33799 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751673Ab1FQPs4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Jun 2011 11:48:56 -0400
Received: by mail-pz0-f47.google.com with SMTP id 36so2137232pzk.6
        for <linux-omap@vger.kernel.org>; Fri, 17 Jun 2011 08:48:55 -0700 (PDT)
In-Reply-To: <BANLkTi=A75NHVeqz6dnKFZB-EcmJEH0XhA@mail.gmail.com> (Nishanth
	Menon's message of "Thu, 16 Jun 2011 19:28:34 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

"Menon, Nishanth" <nm@ti.com> writes:

> On Thu, Jun 16, 2011 at 15:45, Kevin Hilman <khilman@ti.com> wrote:
>> Nice!
>>
>> A reference to where these voltages values came from would be good to
>> have in the code as well.
> these are just conversions of the existing values - :( 
> I think we need a seperate patch updating from each of OMAP DMs..

Yes please.
