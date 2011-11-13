From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [QUESTION] omap iommu: a generic IOMMU?
Date: Sun, 13 Nov 2011 15:37:26 +0200
Message-ID: <CAK=Wgba+m6D7hhr0CrfzrC7mAB=6NFhbik4qte7OPGGo0v6oYQ@mail.gmail.com>
References: <CACVXFVPLgXfcpE9x2KKbU=r9_+ZeEbfo1TGndvm6yi34V15tPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:61221 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753131Ab1KMNhr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 13 Nov 2011 08:37:47 -0500
Received: by yenr9 with SMTP id r9so4395863yen.19
        for <linux-omap@vger.kernel.org>; Sun, 13 Nov 2011 05:37:47 -0800 (PST)
In-Reply-To: <CACVXFVPLgXfcpE9x2KKbU=r9_+ZeEbfo1TGndvm6yi34V15tPA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ming Lei <tom.leiming@gmail.com>
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Joerg Roedel <joerg.roedel@amd.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello,

On Sun, Nov 13, 2011 at 1:04 PM, Ming Lei <tom.leiming@gmail.com> wrote:
> Just be curious, is it a generic IOMMU so that it can be used by all IO
> peripherals in OMAP4?

No, it's a dedicated iommu for the DSP and dual-M3 subsystems.

> From related source code[1] and OMAP4 TRM[2], looks like the omap iommu
> only belongs to Cortex-M3 MPU subsystem inside OMAP4 chip, so I am wondering
> why introduces the driver for arm v7 based linux kernel...

Because we control the iommus from the A9 (which is running Linux..) :)

Ohad.
