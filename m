From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: wait_for_completion_interruptible does not wait !!
Date: Sun, 20 Jun 2010 09:23:28 +0200
Message-ID: <4C1DC1F0.7040609@gmail.com>
References: <AANLkTikPOcNZk5ISX2WDHSmsPDw_a5_3Ic3owAbO4o0y@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:55789 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752674Ab0FTHXd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 20 Jun 2010 03:23:33 -0400
In-Reply-To: <AANLkTikPOcNZk5ISX2WDHSmsPDw_a5_3Ic3owAbO4o0y@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Suresh Rajashekara <suresh.raj+linuxomap@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-pm@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>

On 06/20/2010 08:52 AM, Suresh Rajashekara wrote:
> The ioctl waits on a completion variable (using
> wait_for_completion_interruptible).
...
> I tried wait_for_completion instead, but now the kernel refuses to suspend.

Do you check return value of wait_for_completion_interruptible and
return its value if nonzero?

We need the code to comment, otherwise it's hard to say.

-- 
js
