From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [QUESTION] omap iommu: a generic IOMMU?
Date: Sun, 13 Nov 2011 16:47:36 +0200
Message-ID: <CAK=Wgba52OgASTrZyP+U6=5q6ZLzPRXxjjaAhHoBO5MnqewpxA@mail.gmail.com>
References: <CACVXFVPLgXfcpE9x2KKbU=r9_+ZeEbfo1TGndvm6yi34V15tPA@mail.gmail.com>
 <CAK=Wgba+m6D7hhr0CrfzrC7mAB=6NFhbik4qte7OPGGo0v6oYQ@mail.gmail.com> <CACVXFVOvFAbGsXBsRTYC=JWRrh9_tZ_jwgPp+3evxCvXy9inVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:42769 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751358Ab1KMOr6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 13 Nov 2011 09:47:58 -0500
Received: by ggnb2 with SMTP id b2so5453683ggn.19
        for <linux-omap@vger.kernel.org>; Sun, 13 Nov 2011 06:47:58 -0800 (PST)
In-Reply-To: <CACVXFVOvFAbGsXBsRTYC=JWRrh9_tZ_jwgPp+3evxCvXy9inVA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ming Lei <tom.leiming@gmail.com>
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Joerg Roedel <joerg.roedel@amd.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sun, Nov 13, 2011 at 4:07 PM, Ming Lei <tom.leiming@gmail.com> wrote:
> Could you give a use case about the usage of controlling the iommu from
> the A9?

E.g. before we boot the M3, we first configure its MMU (otherwise
every memory access it will do will fail).

> I understand that the M3 and DSP can do this too, :-)

AFAIK the M3 can't configure its own MMU, but even if it could, you
have a catch 22 here as it can't even access its very first
instruction without first having its MMU configured correctly to point
at it ;)
