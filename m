From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH V2] omap2/omapfb: make DBG() more resistant in if-else
 constructions
Date: Tue, 10 May 2011 15:16:07 +0300
Message-ID: <1305029767.2045.42.camel@deskari>
References: <BANLkTinEJZ=fvJmWRkQ7kKyxbFRaJnum7g@mail.gmail.com>
	 <1305025653-17138-1-git-send-email-ndevos@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:45824 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754823Ab1EJMQN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 May 2011 08:16:13 -0400
In-Reply-To: <1305025653-17138-1-git-send-email-ndevos@redhat.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Niels de Vos <ndevos@redhat.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Sanjeev Premi <premi@ti.com>

On Tue, 2011-05-10 at 12:07 +0100, Niels de Vos wrote:
> When DBG() is used in a simple if-else, the resulting code path
> currently depends on the definition of DBG(). Inserting the statement in
> a "do { ... } while (0)" prevents this possible misuse.
> 
> Signed-off-by: Niels de Vos <ndevos@redhat.com>

Thanks, I'll add this to the dss2 tree.

 Tomi


