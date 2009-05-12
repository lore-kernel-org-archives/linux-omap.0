From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: N810: latest linux-omap-2.6.git master
Date: Tue, 12 May 2009 10:06:58 +0300
Message-ID: <20090512100658.86a99e98.jhnikula@gmail.com>
References: <200905091745.06435.luke@dashjr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.27]:36490 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755930AbZELHFR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 May 2009 03:05:17 -0400
Received: by ey-out-2122.google.com with SMTP id 9so1017293eyd.37
        for <linux-omap@vger.kernel.org>; Tue, 12 May 2009 00:05:17 -0700 (PDT)
In-Reply-To: <200905091745.06435.luke@dashjr.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Luke-Jr <luke@dashjr.org>
Cc: linux-omap@vger.kernel.org

On Sat, 9 May 2009 17:45:00 -0500
"Luke-Jr" <luke@dashjr.org> wrote:

> Having trouble getting "2.6.30-rc4-omap1" to boot my US N810 (running
> Gentoo). The initial problem appears to be related to /dev/mmcblk*
> missing, but I can't debug it very far due to the second problem I

For me mmc is working. I'm booting through the modified initfs with
official major number 179 for /dev/mmcblk* device nodes.

> encountered: The keys "fghjvbnm" do not appear to work. I added debug
> info to print when the keyboard FIFO is empty, and also when it has a
> valid mapping, but these keys do not appear to be triggering the
> 'process_keys' function at all.
> 
I see this problem as well. I think this wasn't here just couple weeks
ago after Tony's code reset to mainline patches but I'm not sure was
it still 2.6.29 when I last time used the keyboard.


-- 
Jarkko
