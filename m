From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: [PATCH 0/3] OMAP3 Beagle: Enable nand support
Date: Wed, 11 Jun 2008 11:17:47 -0700
Message-ID: <5e088bd90806111117q2e22e44bpd938d3b678fde397@mail.gmail.com>
References: <5e088bd90805312338j540aef97s4735eba05c736448@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:30679 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751124AbYFKSRt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Jun 2008 14:17:49 -0400
Received: by py-out-1112.google.com with SMTP id p76so1503203pyb.10
        for <linux-omap@vger.kernel.org>; Wed, 11 Jun 2008 11:17:48 -0700 (PDT)
In-Reply-To: <5e088bd90805312338j540aef97s4735eba05c736448@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Gmail seems to have messed with the wrapping on the initial
submission.  I will resubmit using git-send-email.

Steve

On Sat, May 31, 2008 at 11:38 PM, Steve Sakoman <sakoman@gmail.com> wrote:
> This series of patches adds nand support to the beagle board.
>
> The first patch in the series builds on work by Teerth Reddy
> <teerth@ti.com> to extend the omap2 nand driver to work with both
> omap2 and omap3 architectures (as well as adding/clarifying comments).
>
> The second patch adds the beagle nand support, and the final patch
> enables the nand driver and jffs2 support in the beagle defconfig.
>
> The patch set was reviewed by Khasim Syed Mohammed <khasim@ti.com>
> prior to this submission.  It was tested on a Rev B beagle board.
>
