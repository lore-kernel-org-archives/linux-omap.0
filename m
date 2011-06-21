From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [RFC 0/8] Introducing a generic AMP/IPC framework
Date: Tue, 21 Jun 2011 12:30:21 +0300
Message-ID: <BANLkTin3DeTK96nBo2qJGeg5NFZnDPSyxg@mail.gmail.com>
References: <1308640714-17961-1-git-send-email-ohad@wizery.com> <BANLkTimn-THKipuQVHLA9i3QSoO5RTqMtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:56064 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755293Ab1FUJam (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Jun 2011 05:30:42 -0400
In-Reply-To: <BANLkTimn-THKipuQVHLA9i3QSoO5RTqMtA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: akpm@linux-foundation.org, Brian Swetland <swetland@google.com>, Arnd Bergmann <arnd@arndb.de>, Grant Likely <grant.likely@secretlab.ca>, davinci-linux-open-source <davinci-linux-open-source@linux.davincidsp.com>, Rusty Russell <rusty@rustcorp.com.au>

On Tue, Jun 21, 2011 at 10:50 AM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> root@omap4430-panda:~# cat /debug/remoteproc/omap-rproc.1/state
> running (2)

At this point, the two remote M3 cores also start dumping trace logs to
shared memory buffers, which are exposed by debugfs entries:

root@omap4430-panda:~# cat /debug/remoteproc/omap-rproc.1/trace0
CORE0 starting..
...

root@omap4430-panda:~# cat /debug/remoteproc/omap-rproc.1/trace1
CORE1 starting..
...
