From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 0/7 v5] OMAP3: clean up ASM sleep code
Date: Fri, 17 Dec 2010 17:22:03 -0600
Message-ID: <4D0BF09B.5050709@ti.com>
References: <1292580506-4421-1-git-send-email-j-pihet@ti.com>	<87bp4k6m1d.fsf@deeprootsystems.com> <AANLkTi=4XhE+fYDa9BYqk+1yb08Kiu3ppYNqEfW2w5Hf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:54898 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754208Ab0LQXWH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Dec 2010 18:22:07 -0500
Received: by gwj21 with SMTP id 21so839714gwj.13
        for <linux-omap@vger.kernel.org>; Fri, 17 Dec 2010 15:22:05 -0800 (PST)
In-Reply-To: <AANLkTi=4XhE+fYDa9BYqk+1yb08Kiu3ppYNqEfW2w5Hf@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jean Pihet <j-pihet@ti.com>

Jean Pihet had written, on 12/17/2010 05:07 PM, the following:
> Hi Kevin,
> 
> On Sat, Dec 18, 2010 at 12:02 AM, Kevin Hilman
> <khilman@deeprootsystems.com> wrote:
>> Hi Jean,
>>
>> jean.pihet@newoldbits.com writes:
>>
>>> From: Jean Pihet <j-pihet@ti.com>
>>>
>>> This patch only contains clean-ups and cosmetic changes,
>>> no functional change.
>>>
>>> Clean-up of the ASM sleep code, for better readability and
>>> easier maintenance.
>>>
>>> Applies on top of Nishant's latest idle path errata fixes step 2,
>>> cf. http://marc.info/?l=linux-omap&m=129139584919242&w=2
>> Can you do one more spin of this series in order to collect the
>> reviewed-by/tested-by tags posted, and address some of Nishanth's
>> comments.  Since we are reaching a merge window deadline, I'll leave it
>> to your discretion to decide which of Nishanth's suggestions to address
>> now and which to address later.
> Sure I will post a new version tomorrow.
> This will include some fixes after Nishant's comments. The rest can be
> done later after we agree on the future changes.
Sounds good to me as well.. the minor cleanups should be easy to do..
will help with testing tomorrow on the new series if there are any 
functional changes. I will post out my revamped series as well 2morrow.


-- 
Regards,
Nishanth Menon
