From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/4] omap: iovmm - fixes for iovmm module
Date: Tue, 14 Dec 2010 17:10:54 +0200
Message-ID: <AANLkTim3i+nAV+isLy+rVZ9gtkeW408G_6BhJAbLJZTL@mail.gmail.com>
References: <1292332047-8206-1-git-send-email-fernando.lugo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1292332047-8206-1-git-send-email-fernando.lugo@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fernando Guzman Lugo <fernando.lugo@ti.com>
Cc: Hiroshi.DOYU@nokia.com, linux@arm.linux.org.uk, h-kanigeri2@ti.com, felipe.contreras@nokia.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

On Tue, Dec 14, 2010 at 3:07 PM, Fernando Guzman Lugo
<fernando.lugo@ti.com> wrote:

You are missing a description here.

> Version 6:
> * Rebase on Russell King branch.
> =C2=A0- for details see:
> =C2=A0http://marc.info/?l=3Dlinux-omap&m=3D129228495723001&w=3D2

Even if these patches are applied, iommu would still not be usable
form tidspbridge, you need at least this patch:
http://article.gmane.org/gmane.linux.ports.arm.omap/44753

Cheers.

--=20
=46elipe Contreras
