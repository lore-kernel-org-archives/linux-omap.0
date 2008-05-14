From: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: [PATCH] MMC: Fix omap compile by replacing dev_name with
 dma_dev_name
Date: Wed, 14 May 2008 21:01:05 +0200
Message-ID: <20080514210105.6e7827c1@mjolnir.drzeus.cx>
References: <20080506233647.GL18682@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761853AbYENTBk@vger.kernel.org>
In-Reply-To: <20080506233647.GL18682@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Carlos Aguiar <carlos.aguiar@indt.org.br>, Anderson Briglia <anderson.briglia@indt.org.br>, Syed Khasim <sm.khasim@gmail.com>
List-Id: linux-omap@vger.kernel.org

On Tue, 6 May 2008 16:36:47 -0700
Tony Lindgren <tony@atomide.com> wrote:

> Hi Pierre,
> 
> Here's a fix to make omap.c compile again because of a name conflict
> introduced by 3efcdd76c4906236f9043c8b34837818177b291d.
> 
> Regards,
> 
> Tony


applied, thanks

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  rdesktop, core developer          http://www.rdesktop.org
