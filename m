From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC 0/8] Introducing a generic AMP/IPC framework
Date: Tue, 21 Jun 2011 16:20:01 +0200
Message-ID: <201106211620.02065.arnd@arndb.de>
References: <1308640714-17961-1-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:55485 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755165Ab1FUOUp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Jun 2011 10:20:45 -0400
In-Reply-To: <1308640714-17961-1-git-send-email-ohad@wizery.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org, Brian Swetland <swetland@google.com>, Grant Likely <grant.likely@secretlab.ca>, davinci-linux-open-source <davinci-linux-open-source@linux.davincidsp.com>, Rusty Russell <rusty@rustcorp.com.au>

Hi Ohad,

On Tuesday 21 June 2011, Ohad Ben-Cohen wrote:

> This patch set adds a generic AMP/IPC framework which makes it possible to
> control (power on, boot, power off) and communicate (simply send and receive
> messages) with those remote processors.

This looks really nice overall, but I don't currently have time for a
more in-depth review. My feeling is that you are definitely on the right
track here, and the plans you list as TODO to continue are all good.

One point I noticed is the use of debugfs, which you should probably
replace at some point with a stable API, e.g. your own debugfs-like
file system, but there is no hurry to do that now.

> The gory part of remoteproc is the firmware handling. We tried to come up
> with a simple binary format that will require minimum kernel code to handle,
> but at the same time be generic enough in the hopes that it would prove
> useful to others as well. We're not at all hang onto the binary format
> we picked: if there's any technical reason to change it to support other
> platforms, please let us know. We do realize that a single binary firmware
> structure might eventually not work for everyone. it did prove useful for
> us though; we adopted both the OMAP and Davinci platforms (and their
> completely different remote processor devices) to this simple binary
> structure, so we don't have to duplicate the firmware handling code.

Regarding the firmware, I think it would be nice to have the option
to stick the firmware blob into the flattened device tree as a bininclude,
so you can build systems using the external processors without special
user space support.

The binary format looks reasonable, but if you need anything more complex,
you should probably go straight for ELF files ;-)

The structures you use like

+struct fw_section {
+       u32 type;
+       u64 da;
+       u32 len;
+       char content[0];
+} __packed;

Unfortunately require __packed. It would be better to sort the members
differently so that each member is naturally aligned in order to
avoid the need for padding or __packed attributes, like:

struct fw_section {
       u32 type;
       u32 len;
       u64 da;
       char content[0];
};

	Arnd
