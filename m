From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [rft/rfc/patch-v2.6.29-rc5+ 00/23] ehci cleanup series
Date: Wed, 25 Feb 2009 00:13:29 +0200
Message-ID: <6ed0b2680902241413l9529e76j792a69354de27950@mail.gmail.com>
References: <1235415171-17376-1-git-send-email-me@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.184]:25400 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753386AbZBXWNf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Feb 2009 17:13:35 -0500
Received: by fk-out-0910.google.com with SMTP id f33so1849354fkf.5
        for <linux-omap@vger.kernel.org>; Tue, 24 Feb 2009 14:13:32 -0800 (PST)
In-Reply-To: <1235415171-17376-1-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: linux-omap@vger.kernel.org, Steve Sakoman <steve@sakoman.com>, Anand Gadiyar <gadiyar@ti.com>, Syed Mohammed Khasim <x0khasim@ti.com>

hi,

On Mon, Feb 23, 2009 at 8:52 PM, Felipe Balbi <me@felipebalbi.com> wrote:
> Hi all,
>
> Please give the following patches a good test. I don't have
> hw to test them so any comments will be really welcome.
>
> We still have lots to do before getting this driver upstream,
> let's try to keep track of our TODO list and get this driver in
> mainline for 2.6.31 merge window (2.6.30 is too close already).
>
> Let's not try to push this driver until ES2.x and ES3.x are fully
> supported, that will probably have to be done by an omap_rev
> check in ehci-omap driver, also, this driver doesn't really
> enumerate any attached devices, but that's old problem as Tony
> told me off list.

It enumerates for me on current l-o head if I define
EXT_PHY_RESET_GPIO_PORT1 correctly in host-ehci.c. However it doesn't
work with your patches applied, it looks like you are using
time_after() wrong:

if (time_after(timeout, jiffies)) {
        dev_dbg(omap->dev, "operation timed out\n");
        ret = -EINVAL;
        goto err_sys_status;
}

 * time_after(a,b) returns true if the time a is after time b.

[   15.280487] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[   15.287139] ehci_hcd: block sizes: qh 128 qtd 96 itd 160 sitd 96
[   15.293273] ehci-omap ehci-omap.0: starting TI EHCI USB Controller
[   15.299499] ehci-omap ehci-omap.0: idlest2 = 0x0
[   15.304168] ehci-omap ehci-omap.0: operation timed out
[   15.309387] ehci-omap ehci-omap.0: failed to start ehci
[   15.314666] ehci-omap: probe of ehci-omap.0 failed with error -22

after fixing that it locks up, I'll comment about that more later.
