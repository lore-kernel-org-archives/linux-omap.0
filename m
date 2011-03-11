From: Kevin Hilman <khilman@ti.com>
Subject: Re: [GIT PULL] OMAP PM updates for 2.6.39
Date: Fri, 11 Mar 2011 08:32:24 -0800
Message-ID: <87k4g5botj.fsf@ti.com>
References: <87k4g6eakw.fsf@ti.com>
	<AANLkTimMsYhCqqRjcBDCMDT4=iTwBG_qLHWjuxVZTmXE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:43954 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751983Ab1CKQc3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Mar 2011 11:32:29 -0500
Received: by pxi6 with SMTP id 6so724475pxi.31
        for <linux-omap@vger.kernel.org>; Fri, 11 Mar 2011 08:32:28 -0800 (PST)
In-Reply-To: <AANLkTimMsYhCqqRjcBDCMDT4=iTwBG_qLHWjuxVZTmXE@mail.gmail.com>
	(Jean Pihet's message of "Fri, 11 Mar 2011 16:33:40 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Jean Pihet <jean.pihet@newoldbits.com> writes:

> Hi Kevin,
>
> On Fri, Mar 11, 2011 at 1:59 AM, Kevin Hilman <khilman@ti.com> wrote:
>> Tony,
>>
>> Please pull the following OMAP PM related changes for the upcoming
>> 2.6.39 merge window.
>>
>> Kevin
>>
>> The following changes since commit a5abba989deceb731047425812d268daf=
7536575:
>>
>> =C2=A0Linux 2.6.38-rc8 (2011-03-07 21:09:37 -0800)
>>
>> are available in the git repository at:
>> =C2=A0ssh://master.kernel.org/pub/scm/linux/kernel/git/khilman/linux=
-omap-pm.git for_2.6.39/pm-misc
>
> Waht about the following patch? IIUC it is scheduled for .39.
>
>     perf: add OMAP support for the new power events
>

I have another branch (for_2.6.39/pm-integration) that is based on
Paul's integration branch and includes your perf patch.

Once Tony pulls Paul's integration branch, I will send Tony a 2nd pull
request for this branch.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
