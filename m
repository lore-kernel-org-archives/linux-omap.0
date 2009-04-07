From: David Brownell <david-b@pacbell.net>
Subject: Re: Preempt-RT on OMAP3?
Date: Mon, 6 Apr 2009 20:36:57 -0700
Message-ID: <200904062036.57982.david-b@pacbell.net>
References: <5a7b8b7b0904052025g74325484h66335606bebea5a3@mail.gmail.com> <200904061927.09627.david-b@pacbell.net> <5a7b8b7b0904061944h65f7b36cja70681d6a512693b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from n22b.bullet.mail.mud.yahoo.com ([68.142.206.159]:39158 "HELO
	n22b.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752185AbZDGDhE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Apr 2009 23:37:04 -0400
In-Reply-To: <5a7b8b7b0904061944h65f7b36cja70681d6a512693b@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hugo Vincent <hugo.vincent@gmail.com>
Cc: linux-omap@vger.kernel.org

On Monday 06 April 2009, Hugo Vincent wrote:
> Here is a complete boot log + config:
> http://hugovincent.com/files/lkml-20090407/boot2.log

Erm, not very complete actually.  Enable DEBUG_LL to see
more early messages ... like the ones starting right
after the kernel decompression messages.

Also, re those udev-induced messages:

Remounting root file system...
uncorrectable error : <3>end_request: I/O error, dev mtdblock0, sector 0
Buffer I/O error on device mtdblock0, logical block 0
uncorrectable error : <3>uncorrectable error : <3>end_request: I/O error, dev mtdblock0, sector 8
Buffer I/O error on device mtdblock0, logical block 1
end_request: I/O error, dev mtdblock0, sector 16
Buffer I/O error on device mtdblock0, logical block 2
uncorrectable error : <3>end_request: I/O error, dev mtdblock0, sector 24
Buffer I/O error on device mtdblock0, logical block 3
uncorrectable error : <3>end_request: I/O error, dev mtdblock0, sector 0
Buffer I/O error on device mtdblock0, logical block 0

You shouldn't need mtdblock unless you run JFSS2, so that's
the quick way to get rid of them:  take that out of your
kernel configuration.  Else, add "mtdblock*" to
the "KERNEL==... ; goto persistent_storage_end" check in

 /etc/udev/rules.d/60-persistent-storage.rules

I understand the next version of udev will fix that.

- Dave

