From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [PATCH 07/07][GIT 3/4+] Renaming CFG_GetC55Procs
Date: Mon, 4 Aug 2008 11:48:10 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E0AF98CB7@dlee03.ent.ti.com>
References: <27F9C60D11D683428E133F85D2BB4A530804B519@dlee03.ent.ti.com>
 <20080804151105.GA25489@kos.to>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from calf.ext.ti.com ([198.47.26.144]:49000 "EHLO calf.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758681AbYHDQs1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Aug 2008 12:48:27 -0400
In-Reply-To: <20080804151105.GA25489@kos.to>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Riku Voipio <riku.voipio@iki.fi>, "Ramirez Luna, Omar" <x00omar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> > Renaming CFG_GetC55Procs function for a more proper name
> (CFG_GetDSPProcs) and removed redundant initialization statements.
>
> Why does this function need to exist in the first place? The only place
> this is ever going to be used print a trace message on how many
> dsp's there are... Just eliminate the CFG_GetC55Procs please.
>
> > ---

---- Looks like legacy Bridge code from 2430. Yes, we can get rid of this function.

Best regards,
Hari
