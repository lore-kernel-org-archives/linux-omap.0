From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCH 05/21] Revert "OMAP3+: PM: SR: add suspend/resume handlers"
Date: Wed, 25 Jan 2012 15:29:01 -0600
Message-ID: <CAOMWX4eju6Zm5=DOyXkmRYjEvdnx+bGyNouEB01oG=zQPdyfyQ@mail.gmail.com>
References: <1327504583-13408-1-git-send-email-j-pihet@ti.com>
 <1327504583-13408-6-git-send-email-j-pihet@ti.com> <4F2041B1.6060907@ti.com>
 <CAORVsuWu-pzTWzYp2=gqqPzRJQ1eBLu=12uNyEbVSZp407WUnA@mail.gmail.com>
 <4F204916.7050504@ti.com> <87zkdbehx5.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:48324 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751120Ab2AYV3W (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Jan 2012 16:29:22 -0500
Received: by mail-we0-f171.google.com with SMTP id b14so5056989wer.2
        for <linux-omap@vger.kernel.org>; Wed, 25 Jan 2012 13:29:21 -0800 (PST)
In-Reply-To: <87zkdbehx5.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com, Paul Walmsley <paul@pwsan.com>, Jean Pihet <j-pihet@ti.com>, Kevin Hilman <khilman@ti.com>

On Wed, Jan 25, 2012 at 12:49, Kevin Hilman <khilman@ti.com> wrote:
> "Cousson, Benoit" <b-cousson@ti.com> writes:
>
>> On 1/25/2012 7:13 PM, Jean Pihet wrote:
>
> [...]
>
>>>>
>>>> I guess that path #3 and #5 should just be removed.
>>> I am ok with both options (keeping or removing the 2 commits), please
>>> let me know what you prefer.
>>
>> I guess that removing both is the only acceptable solution
>> anyway.
>
> Yes, please remove them both.
Also, please drop Change-IDs as well.. :)

Regards,
Nishanth Menon
