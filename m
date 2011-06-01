From: "Titiano, Patrick" <p-titiano@ti.com>
Subject: RE: [PATCH/RFC 2/4] OMAP2: PM debug: remove register dumping
Date: Wed, 1 Jun 2011 16:28:49 +0200
Message-ID: <E8606C3FD412994585953171ED63A9340219137850@dnce01.ent.ti.com>
References: <1306450971-27732-1-git-send-email-khilman@ti.com><1306450971-27732-3-git-send-email-khilman@ti.com><BANLkTikG1yExnfKGH6RsXU99MfTxGgiXww@mail.gmail.com><E8606C3FD412994585953171ED63A9340219136F97@dnce01.ent.ti.com>
 <87sjrujply.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33135 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750751Ab1FAO2x convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Jun 2011 10:28:53 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <87sjrujply.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: Jean Pihet <jean.pihet@newoldbits.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Kevin,

[...]
> > Sorry but omapconf is run from userspace, it cannot be used to dump
> > PRCM registers right before and after MPU WFI.
> >
>
> Right, taking register snapshots is currently beyond the scope of
> omapconf.
>
> However, as I suggested earlier in this thread, if we had a new driver
> with read/write interface where register snapshots are saved, I imagine
> adopting omapconf to read from such an interface for dumping register
> snapshots would be relatively easy, right?
>

Correct, this feature could be pretty easily added to omapconf.

Patrick.


Texas Instruments France SA, 821 Avenue Jack Kilby, 06270 Villeneuve Loubet. 036 420 040 R.C.S Antibes. Capital de EUR 753.920



