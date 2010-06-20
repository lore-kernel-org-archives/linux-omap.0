From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: wait_for_completion_interruptible does not wait !! [During PM
 suspend]
Date: Sun, 20 Jun 2010 09:51:31 +0200
Message-ID: <4C1DC883.7090009@gmail.com>
References: <AANLkTik5x38mWno0EUGhaHDD_INLlpeaGSExGxjIC4as@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:32833 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752078Ab0FTHvf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 20 Jun 2010 03:51:35 -0400
In-Reply-To: <AANLkTik5x38mWno0EUGhaHDD_INLlpeaGSExGxjIC4as@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Suresh Rajashekara <suresh.raj+linuxomap@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-pm@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>

On 06/20/2010 09:42 AM, Suresh Rajashekara wrote:
> On Sun, Jun 20, 2010 at 12:23 AM, Jiri Slaby <jirislaby@gmail.com> wrote:
>> On 06/20/2010 08:52 AM, Suresh Rajashekara wrote:
>>> The ioctl waits on a completion variable (using
>>> wait_for_completion_interruptible).
>> ...
>>> I tried wait_for_completion instead, but now the kernel refuses to suspend.
>>
>> Do you check return value of wait_for_completion_interruptible and
>> return its value if nonzero?
>>
>> We need the code to comment, otherwise it's hard to say.
> 
> No. I am not checking the return value of the
> wait_for_completion_interruptible. I can do it

I thought so. Generally, all *_interruptible functions return a value
which should be checked and propagated to upper layers.

-- 
js
