From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: [ANNOUNCE] Public x-loader git tree
Date: Fri, 17 Dec 2010 00:26:25 +0530
Message-ID: <AANLkTik-KToxzbAcL_9izi=66Tfwg7E09arHLe2tRbvY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:51687 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757293Ab0LPS4r (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Dec 2010 13:56:47 -0500
Received: by mail-gy0-f178.google.com with SMTP id 4so1931770gyh.23
        for <linux-omap@vger.kernel.org>; Thu, 16 Dec 2010 10:56:46 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: x-loader@googlegroups.com, "Rangasamy, Devaraj" <dev@ti.com>

Hi all,

As all OMAP folks know, x-loader is a first-stage bootloader for
OMAPs, derived from the u-boot base code. There have been several
forks of the x-loader code within and outside of TI. X-loader has no
upstream path as it is currently used only for TI-products.

To avoid duplication of efforts, it's high time the code from these
different trees was consolidated. Several contributors to x-loader
have expressed a desire to have the code developed collaboratively in
public.

To this end, we have set up an x-loader git tree on gitorious, and
seeded it with Steve Sakoman's x-loader tree [1] as of 15 December
2010. (Thanks Steve for unifying so much of the forked code, and
getting rid of the dependency on u-boot, and more!).

The tree is available at:
http://gitorious.org/x-loader/x-loader

And a wiki page at:
http://gitorious.org/x-loader/pages/Home

In addition, a mailing list has been set up at:
http://groups.google.com/group/x-loader

(Thanks Nishanth Menon for setting these up).

Deva and I have volunteered to maintain the x-loader code - everyone
is welcome to contribute and help make it better.
(This is our first attempt at maintaining a software project - so any
help is appreciated).

Currently, thanks mainly to Steve's efforts, the tree builds for and
works on the following platforms: the OMAP3 EVM, the Overo and Beagle
(both 35xx and 37xx), and the Pandaboard.

There are also configs for the 1710 h3, 2420 h4, 2430 SDP, 3430 SDP
and 3430 Labrador boards - however these don't currently compile. They
will be removed soon unless someone steps in to help bring them into
shape and maintain them. (We can discuss this on the x-loader mailing
list above ;) ).

Patches are welcome for any new platforms that would like to be
supported in this repository. If there are forked versions out there,
let us know and we'll try and integrate them here.

Feel free to use this tree, test it, report issues, and help keep the
code in shape.

- Anand and Deva

[1] Steve Sakoman's x-loader tree:
http://www.sakoman.com/cgi-bin/gitweb.cgi?p=x-loader.git;a=summary
