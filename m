From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: [PATCH 1/3] trace points: power: remove 'cpu_id' from trace_clock_*
Date: Sat, 20 Aug 2011 10:44:12 +0800
Message-ID: <CACVXFVOWgM1aWf9x162Aa=8O6oWEXpDLK31MX+a38PMEt5tJvA@mail.gmail.com>
References: <1313766244-22313-1-git-send-email-tom.leiming@gmail.com>
	<1313766840.15704.104.camel@gandalf.stny.rr.com>
	<CACVXFVNKe+gt2VmrHcJ2Pd1ZvqfOPn+211vR-PcM-WDTYDN4cQ@mail.gmail.com>
	<4E4E8C52.6070900@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:44963 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753952Ab1HTCoO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Aug 2011 22:44:14 -0400
In-Reply-To: <4E4E8C52.6070900@linux.intel.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, fweisbec@gmail.com, jean.pihet@newoldbits.com, mingo@redhat.com, trenn@suse.de, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org

On Sat, Aug 20, 2011 at 12:16 AM, Arjan van de Ven
<arjan@linux.intel.com> wrote:
> On 8/19/2011 8:39 AM, Ming Lei wrote:
>>
>> Hi,
>>
>> On Fri, Aug 19, 2011 at 11:14 PM, Steven Rostedt<rostedt@goodmis.org=
>
>> =A0wrote:
>>>
>>> Do you know if these changes wont break powertop?
>>
>> I have run powertop 1.13 on these changes, and found it works well
>> just like before,
>> no breaks found.
>
> please use powertop 1.98 instead
> 1.13 does not use trace events while 1.98 does

=46rom the link below:

       http://www.lesswatts.org/projects/powertop/download.php

It mentions that "Version 1.13 is the latest version of PowerTOP", also
no any information about 1.98. so where can I get 1.98?

thanks,
--=20
Ming Lei
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
